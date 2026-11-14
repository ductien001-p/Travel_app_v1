import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { PLACE_CATEGORY } from '../../generated/prisma/enums';
import ollama from 'ollama';

export const EMBEDDING_CONFIG = {
  provider: 'ollama',
  model: 'embeddinggemma',
  dimensions: 768,
};
@Injectable()
export class PlaceEmbeddingService {
  constructor(private readonly prisma: PrismaService) {}

  async generateForPlace(placeId: string) {
    const place = await this.prisma.place.findUnique({
      where: {
        id: placeId,
      },
    });

    if (!place) {
      throw new Error('Place not found');
    }

    const text = this.buildPlaceText(place);

    const embedding = await this.createEmbedding(text);

    await this.prisma.$executeRaw`
      UPDATE "Place"
      SET "embedding" = ${this.toVector(embedding)}::vector
      WHERE "id" = ${placeId}
    `;

    return {
      placeId,
      success: true,
    };
  }

  async createEmbedding(text: string): Promise<number[]> {
    const response = await ollama.embed({
      model: EMBEDDING_CONFIG.model,
      input: text,
    });

    const embedding = response.embeddings[0];

    if (embedding.length !== EMBEDDING_CONFIG.dimensions) {
      throw new Error(
        `Invalid embedding dimension: expected ${EMBEDDING_CONFIG.dimensions}, got ${embedding.length}`,
      );
    }

    return embedding;
  }

  private buildPlaceText(place: {
    name: string;
    description: string | null;
    category: PLACE_CATEGORY | null;
  }) {
    return `
      Place name: ${place.name}
      Description: ${place.description ?? ''}
      Category: ${place.category ?? ''}
    `.trim();
  }

  private toVector(embedding: number[]) {
    return `[${embedding.join(',')}]`;
  }
}
