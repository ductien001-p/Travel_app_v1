import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import {
  CompleteUploadDto,
  CompleteUploadMultipleDto,
} from './dto/complete-media.dto';
import { S3Service } from '../../uploads/s3/s3.service';
import { InternalServerErrorException } from '@nestjs/common';
import { UploadFolder } from '../../uploads/s3/upload-folder.type';
import { Prisma } from '../../generated/prisma/client';

@Injectable()
export class MediaService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async validateMediaExists(objectKey: string): Promise<void> {
    const exists = await this.s3.objectExists(objectKey);
    if (!exists) {
      throw new BadRequestException('File has not been uploaded to S3');
    }
  }
  private async completeUpload(userId: string, dto: CompleteUploadDto) {
    // 1. Kiểm tra objectKey có đúng của user này không
    this.assertIssuedObjectKey(dto.objectKey, userId);

    const exists = await this.s3.objectExists(dto.objectKey);
    if (!exists) {
      throw new BadRequestException('File has not been uploaded to S3');
    }

    const existing = await this.prisma.uploadedMedia.findUnique({
      where: { objectKey: dto.objectKey },
    });
    if (existing) {
      return this.resolveExistingUpload(existing, userId);
    }

    // 3. Tạo UploadedMedia
    try {
      return await this.prisma.uploadedMedia.create({
        data: {
          userId,
          objectKey: dto.objectKey,
          mimeType: dto.mimeType,
          fileSize: dto.fileSize,
          width: dto.width,
          height: dto.height,
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const raced = await this.prisma.uploadedMedia.findUnique({
          where: {
            objectKey: dto.objectKey,
          },
        });
        if (!raced) {
          throw new ConflictException('Upload could not be completed');
        }
        return this.resolveExistingUpload(raced, userId);
      }

      throw error;
    }
  }

  private assertIssuedObjectKey(objectKey: string, userId: string): void {
    const segments = objectKey.split('/');
    const allowedFolders = new Set(Object.values(UploadFolder));
    const validFilename = /^[a-f0-9]{16}\.(?:jpg|png|gif|webp)$/i;

    if (
      segments.length !== 3 ||
      !allowedFolders.has(segments[0] as UploadFolder) ||
      segments[1] !== userId ||
      !validFilename.test(segments[2])
    ) {
      throw new ForbiddenException('You cannot use this object key');
    }
  }

  private resolveExistingUpload<
    T extends { userId: string | null; deletedAt: Date | null },
  >(existing: T, userId: string): T {
    if (existing.userId !== userId) {
      throw new ForbiddenException('Object key belongs to another user');
    }
    if (existing.deletedAt !== null) {
      throw new ConflictException('Media has been deleted');
    }
    return existing;
  }

  async completeUploadMultiple(userId: string, dto: CompleteUploadMultipleDto) {
    return Promise.all(
      dto.files.map((file) => this.completeUpload(userId, file)),
    );
  }
  async findOne(id: string) {
    const media = await this.prisma.uploadedMedia.findUnique({
      where: { id, deletedAt: null },
    });
    return media;
  }

  async findOwnMedia(userId: string, id: string) {
    const media = await this.prisma.uploadedMedia.findFirst({
      where: { id, userId, deletedAt: null },
    });
    return media;
  }
  async createFromExternalImage(
    userId: string,
    url: string,
    folder: UploadFolder,
  ) {
    let presigned:
      | {
          key: string;
          uploadUrl: string;
        }
      | undefined;
    try {
      const response = await fetch(url);

      if (!response.ok) {
        throw new BadRequestException(
          `Cannot download external image: ${response.status}`,
        );
      }

      // 2. Check file size trước khi đọc toàn bộ vào RAM
      const contentLength = response.headers.get('content-length');

      const MAX_FILE_SIZE = 5 * 1024 * 1024;

      if (contentLength && Number(contentLength) > MAX_FILE_SIZE) {
        throw new BadRequestException('Image is too large');
      }

      // 3. Check MIME type
      const mimeType =
        response.headers.get('content-type')?.split(';')[0] ?? 'image/jpeg';

      const allowedMimeTypes = ['image/jpeg', 'image/png', 'image/webp'];

      if (!allowedMimeTypes.includes(mimeType)) {
        throw new BadRequestException(`Unsupported image type: ${mimeType}`);
      }

      // 4. Convert image → Buffer
      const buffer = Buffer.from(await response.arrayBuffer());

      // 5. Check size lần nữa
      // Vì Content-Length có thể không tồn tại
      if (buffer.length > MAX_FILE_SIZE) {
        throw new BadRequestException('Image is too large');
      }

      // 6. Tạo presigned PUT URL
      presigned = await this.s3.createImagePresignedPut({
        userId,
        contentType: mimeType,
        folder,
      });

      // 7. Upload Buffer → S3/R2
      const uploadResponse = await fetch(presigned.uploadUrl, {
        method: 'PUT',
        headers: {
          'Content-Type': mimeType,
        },
        body: buffer,
      });

      if (!uploadResponse.ok) {
        throw new InternalServerErrorException(
          'Failed to upload image to storage',
        );
      }

      // 8. Tạo UploadedMedia
      const media = await this.prisma.uploadedMedia.create({
        data: {
          userId,
          objectKey: presigned.key,
          mimeType,
          fileSize: buffer.length,
        },
      });

      return media;
    } catch (error) {
      if (presigned) {
        await this.s3.deleteObject(presigned.key);
      }
      throw error;
    }
  }
}
