import { Module } from '@nestjs/common';

import { PostLikesController } from './post-likes.controller';
import { PostLikesService } from './post-likes.service';

import { PostCommentsController } from './post-comments.controller';
import { PostCommentsService } from './post-comments.service';

import { PostSharesController } from './post-shares.controller';
import { PostSharesService } from './post-shares.service';
import { PostsService } from './post.service';
import { PrismaModule } from '../../prisma.module';
import { PostsController } from './post.controller';

@Module({
  imports: [PrismaModule],
  controllers: [
    PostLikesController,
    PostCommentsController,
    PostSharesController,
    PostsController,
  ],

  providers: [
    PostsService,
    PostLikesService,
    PostCommentsService,
    PostSharesService,
  ],

  exports: [
    PostsService,
    PostLikesService,
    PostCommentsService,
    PostSharesService,
  ],
})
export class PostsModule {}
