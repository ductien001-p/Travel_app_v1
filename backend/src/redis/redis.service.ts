import { Inject, Injectable } from '@nestjs/common';
import Redis from 'ioredis';

@Injectable()
export class RedisService {
  constructor(
    @Inject('REDIS_CLIENT')
    private readonly redis: Redis,
  ) {}

  async set(key: string, value: string, ttl?: number): Promise<void> {
    if (ttl) {
      await this.redis.set(key, value, 'EX', ttl);
      return;
    }

    await this.redis.set(key, value);
  }

  async get(key: string): Promise<string | null> {
    return this.redis.get(key);
  }

  async delete(key: string): Promise<void> {
    await this.redis.del(key);
  }

  /**
   * Increments a counter that expires `ttlSeconds` after its first increment.
   * The key is created with its TTL before incrementing, so it never outlives
   * the window even if the process stops between the two commands.
   */
  async incrementWithTtl(key: string, ttlSeconds: number): Promise<number> {
    await this.redis.set(key, 0, 'EX', ttlSeconds, 'NX');
    return this.redis.incr(key);
  }
}
