import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Ollama } from 'ollama';
import { MEMORY_BADGE } from '../../../../../generated/prisma/enums';

const DEFAULT_MODEL = 'gemma3:4b';
/** The first request also loads the model, which is slow on CPU. */
const DEFAULT_TIMEOUT_MS = 120_000;
const NO_BADGE = 'OTHER';

const PROMPT = `You label photos of a trip album. Answer with exactly one category:
- NIGHT: taken at night or in the dark, e.g. night streets, night markets, city lights, lanterns, fireworks.
- FOOD: food or drinks are the main subject.
- PEOPLE: one or more people are the main subject, e.g. portraits, selfies, group photos.
- SCENERY: daytime landscapes, landmarks, streets or nature.
- ${NO_BADGE}: none of the above, e.g. documents, screenshots, receipts or unclear images.
When several fit, prefer NIGHT, then FOOD, then PEOPLE, then SCENERY.`;

const CATEGORIES = [...Object.values(MEMORY_BADGE), NO_BADGE];

const RESPONSE_SCHEMA = {
  type: 'object',
  properties: { category: { type: 'string', enum: CATEGORIES } },
  required: ['category'],
};

/**
 * Suggests a [MEMORY_BADGE] from the photo content with a local multimodal
 * Ollama model (`MEMORY_BADGE_MODEL`, empty to disable).
 */
@Injectable()
export class MemoryBadgeClassifier {
  private readonly model: string | null;
  private readonly client: Ollama;

  constructor(config: ConfigService) {
    this.model =
      config.get<string>('MEMORY_BADGE_MODEL', DEFAULT_MODEL).trim() || null;
    const timeoutMs = positiveNumber(
      config.get<string>('MEMORY_BADGE_TIMEOUT_MS'),
      DEFAULT_TIMEOUT_MS,
    );
    this.client = new Ollama({
      host: config.get<string>('OLLAMA_HOST') || undefined,
      fetch: (input, init) => {
        const timeout = AbortSignal.timeout(timeoutMs);
        const signal = init?.signal
          ? AbortSignal.any([init.signal, timeout])
          : timeout;
        return fetch(input, { ...init, signal });
      },
    });
  }

  get enabled(): boolean {
    return this.model !== null;
  }

  /** Null when no category fits or the model answers out of contract. */
  async classify(image: Uint8Array): Promise<MEMORY_BADGE | null> {
    if (!this.model) return null;
    const response = await this.client.chat({
      model: this.model,
      stream: false,
      format: RESPONSE_SCHEMA,
      options: { temperature: 0 },
      messages: [
        { role: 'system', content: PROMPT },
        { role: 'user', content: 'Classify this photo.', images: [image] },
      ],
    });
    return parseBadge(response.message.content);
  }
}

export function parseBadge(content: string): MEMORY_BADGE | null {
  let category: unknown;
  try {
    category = (JSON.parse(content) as { category?: unknown })?.category;
  } catch {
    return null;
  }
  return (
    Object.values(MEMORY_BADGE).find((badge) => badge === category) ?? null
  );
}

function positiveNumber(value: string | undefined, fallback: number): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback;
}
