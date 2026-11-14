import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../../../../../prisma.service';
import { S3Service } from '../../../../../uploads/s3/s3.service';
import { MEMORY_BADGE } from '../../../../../generated/prisma/enums';
import { MemoryBadgeClassifier } from './memory-badge.classifier';

const PENDING_BATCH_SIZE = 20;
/** Leaves fresh memories to the creation event before the backfill takes them. */
const PENDING_GRACE_MS = 5 * 60_000;
const MAX_IMAGE_BYTES = 10 * 1024 * 1024;

type Outcome = 'checked' | 'retry-later';

/**
 * Stores the suggested badge of memory photos, one photo at a time so the
 * vision model is never flooded. A photo stays pending (`badgeCheckedAt`
 * null) after a transient failure and is picked up by [classifyPending].
 */
@Injectable()
export class MemoryBadgeService {
  private readonly logger = new Logger(MemoryBadgeService.name);
  private queue: Promise<void> = Promise.resolve();
  private queuedBatches = 0;

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly classifier: MemoryBadgeClassifier,
  ) {}

  /** Runs after every batch queued before it. */
  enqueue(memoryIds: string[]): Promise<void> {
    if (!this.classifier.enabled || memoryIds.length === 0) {
      return Promise.resolve();
    }
    this.queuedBatches++;
    const run = this.queue
      .then(() => this.classifyAll(memoryIds))
      .finally(() => this.queuedBatches--);
    this.queue = run.catch(() => undefined);
    return run;
  }

  /** Classifies the oldest pending photos, unless a batch is still running. */
  async classifyPending(now = new Date()): Promise<void> {
    if (!this.classifier.enabled || this.queuedBatches > 0) return;
    const pending = await this.prisma.tripMedia.findMany({
      where: {
        badgeCheckedAt: null,
        createdAt: { lt: new Date(now.getTime() - PENDING_GRACE_MS) },
        media: { deletedAt: null },
      },
      orderBy: { createdAt: 'asc' },
      take: PENDING_BATCH_SIZE,
      select: { id: true },
    });
    await this.enqueue(pending.map((memory) => memory.id));
  }

  private async classifyAll(memoryIds: string[]): Promise<void> {
    for (const memoryId of memoryIds) {
      // The model or storage is likely down: retry the rest later.
      if ((await this.classifyOne(memoryId)) === 'retry-later') return;
    }
  }

  private async classifyOne(memoryId: string): Promise<Outcome> {
    const memory = await this.prisma.tripMedia.findFirst({
      where: { id: memoryId, badgeCheckedAt: null, media: { deletedAt: null } },
      select: { media: { select: { objectKey: true, mimeType: true } } },
    });
    if (!memory) return 'checked';

    let badge: MEMORY_BADGE | null = null;
    if (memory.media.mimeType?.startsWith('image/')) {
      try {
        const image = await this.s3.getObjectBytes(
          memory.media.objectKey,
          MAX_IMAGE_BYTES,
        );
        badge = image ? await this.classifier.classify(image) : null;
      } catch (error) {
        if (!isRejectedImage(error)) {
          this.logger.warn(
            `Badge of memory ${memoryId} postponed: ${describe(error)}`,
          );
          return 'retry-later';
        }
        this.logger.warn(
          `Badge of memory ${memoryId} skipped: ${describe(error)}`,
        );
      }
    }

    await this.prisma.tripMedia.updateMany({
      where: { id: memoryId, badgeCheckedAt: null },
      data: { badge, badgeCheckedAt: new Date() },
    });
    return 'checked';
  }
}

/** Ollama answers 400 for an image it cannot decode; retrying never helps. */
function isRejectedImage(error: unknown): boolean {
  const status = (error as { status_code?: unknown } | null)?.status_code;
  return status === 400;
}

function describe(error: unknown): string {
  return error instanceof Error ? `${error.name}: ${error.message}` : 'unknown';
}
