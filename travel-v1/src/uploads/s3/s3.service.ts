import { BadRequestException, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import {
  DeleteObjectCommand,
  GetObjectCommand,
  HeadObjectCommand,
  PutObjectCommand,
  S3Client,
} from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import * as crypto from 'crypto';
import { Readable } from 'stream';
import { UploadFolder } from './upload-folder.type';
import { PresignFileDto } from '../presign-upload/presign-upload.dto';

interface GenerateKeyParams {
  folder: UploadFolder;
  userId: string;
  contentType: string;
}
const ALLOWED_MIME = [
  'image/jpeg',
  'image/jpg',
  'image/png',
  'image/gif',
  'image/webp',
];

const DEFAULT_PRESIGN_EXPIRES_SEC = 3600;

@Injectable()
export class S3Service {
  private readonly client: S3Client;
  private readonly bucket: string;

  constructor(private readonly configService: ConfigService) {
    const accountId = this.configService.getOrThrow<string>('R2_ACCOUNT_ID');

    this.bucket = this.configService.getOrThrow<string>('R2_BUCKET_NAME');

    this.client = new S3Client({
      region: 'auto',
      endpoint: `https://${accountId}.r2.cloudflarestorage.com`,
      credentials: {
        accessKeyId: this.configService.getOrThrow<string>('R2_ACCESS_KEY_ID'),
        secretAccessKey: this.configService.getOrThrow<string>(
          'R2_SECRET_ACCESS_KEY',
        ),
      },
      requestChecksumCalculation: 'WHEN_REQUIRED',
      responseChecksumValidation: 'WHEN_REQUIRED',
    });
  }

  isUploadConfigured(): boolean {
    return !!(
      this.configService.get('R2_ACCOUNT_ID') &&
      this.configService.get('R2_BUCKET_NAME') &&
      this.configService.get('R2_ACCESS_KEY_ID') &&
      this.configService.get('R2_SECRET_ACCESS_KEY')
    );
  }

  getPublicUrl(objectKey: string): string {
    const baseUrl = this.configService
      .getOrThrow<string>('R2_PUBLIC_URL')
      .replace(/\/$/, '');

    return `${baseUrl}/${objectKey}`;
  }

  async createImagePresignedPut(params: {
    userId: string;
    contentType: string;
    folder: UploadFolder;
    expiresInSeconds?: number;
  }) {
    const { userId, contentType, folder, expiresInSeconds } = params;
    const typeCheck = this.validateImageContentType(contentType);

    if (!typeCheck.valid) {
      throw new BadRequestException(
        typeCheck.message ?? 'Invalid content type',
      );
    }

    const key = this.generateObjectKey({
      userId,
      contentType,
      folder,
    });

    const expiresIn = this.resolvePresignExpires(expiresInSeconds);

    const uploadUrl = await this.getPresignedPutUrl(
      key,
      contentType,
      expiresIn,
    );

    return {
      method: 'PUT' as const,
      uploadUrl,
      key,
      expiresIn,
      headers: {
        'Content-Type': contentType,
      },
    };
  }

  async createImagePresignedPutMultiple(params: {
    userId: string;
    files: PresignFileDto[];
    folder: UploadFolder;
    expiresInSeconds?: number;
  }) {
    const presignUrls = await Promise.all(
      params.files.map(async (file) => {
        const upload = await this.createImagePresignedPut({
          userId: params.userId,
          contentType: file.contentType,
          folder: params.folder,
          expiresInSeconds: params.expiresInSeconds,
        });

        return {
          url: upload.uploadUrl,
          headers: upload.headers,
          key: upload.key,
        };
      }),
    );

    return {
      method: 'PUT' as const,
      expiresIn: this.resolvePresignExpires(params.expiresInSeconds),
      uploads: presignUrls,
    };
  }

  async objectExists(key: string) {
    try {
      return await this.client.send(
        new HeadObjectCommand({
          Bucket: this.bucket,
          Key: key,
        }),
      );
    } catch (error: any) {
      if (
        error?.name === 'NotFound' ||
        error?.$metadata?.httpStatusCode === 404
      ) {
        return null;
      }

      throw error;
    }
  }

  /**
   * Downloads an object, or returns null when it does not exist or is larger
   * than [maxBytes].
   */
  async getObjectBytes(
    key: string,
    maxBytes: number,
  ): Promise<Uint8Array | null> {
    try {
      const object = await this.client.send(
        new GetObjectCommand({ Bucket: this.bucket, Key: key }),
      );
      if (!object.Body) return null;
      if ((object.ContentLength ?? 0) > maxBytes) {
        // Frees the socket without downloading the body.
        if (object.Body instanceof Readable) object.Body.destroy();
        return null;
      }
      const bytes = await object.Body.transformToByteArray();
      return bytes.byteLength > maxBytes ? null : bytes;
    } catch (error: any) {
      if (
        error?.name === 'NoSuchKey' ||
        error?.$metadata?.httpStatusCode === 404
      ) {
        return null;
      }
      throw error;
    }
  }

  async deleteObject(key: string): Promise<void> {
    await this.client.send(
      new DeleteObjectCommand({
        Bucket: this.bucket,
        Key: key,
      }),
    );
  }

  private getExtension(mimetype: string): string {
    const map: Record<string, string> = {
      'image/jpeg': 'jpg',
      'image/jpg': 'jpg',
      'image/png': 'png',
      'image/gif': 'gif',
      'image/webp': 'webp',
    };

    return map[mimetype] ?? 'jpg';
  }

  private generateObjectKey(params: GenerateKeyParams): string {
    const { folder, userId, contentType } = params;

    const ext = this.getExtension(contentType);

    const imageId = crypto.randomBytes(8).toString('hex');

    return `${folder}/${userId}/${imageId}.${ext}`;
  }

  private validateImageContentType(mimetype: string) {
    if (!ALLOWED_MIME.includes(mimetype)) {
      return {
        valid: false,
        message: `Invalid content type. Allowed types: ${ALLOWED_MIME.join(
          ', ',
        )}`,
      };
    }
    return {
      valid: true,
    };
  }

  private resolvePresignExpires(expiresInSeconds?: number): number {
    if (expiresInSeconds != null && expiresInSeconds > 0) {
      return Math.min(expiresInSeconds, 86400);
    }

    const fromEnv = Number(this.configService.get('R2_PRESIGN_EXPIRES'));

    if (Number.isFinite(fromEnv) && fromEnv > 0) {
      return Math.min(fromEnv, 86400);
    }

    return DEFAULT_PRESIGN_EXPIRES_SEC;
  }

  private getPresignedPutUrl(
    key: string,
    contentType: string,
    expiresInSeconds: number,
  ): Promise<string> {
    const command = new PutObjectCommand({
      Bucket: this.bucket,
      Key: key,
      ContentType: contentType,
    });

    return getSignedUrl(this.client, command, {
      expiresIn: expiresInSeconds,
    });
  }
}
