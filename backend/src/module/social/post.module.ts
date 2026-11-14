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
import { S3Module } from '../../uploads/s3/s3.module';
import { PostSavesController } from './post-saves.controller';
import { PostSavesService } from './post-saves.service';
import { SocialStoriesController } from './social-stories.controller';
import { SocialStoriesService } from './social-stories.service';
import { SocialChallengesController } from './social-challenges.controller';
import { SocialChallengesService } from './social-challenges.service';
import { SocialFeedController } from './social-feed.controller';
import { SocialFeedService } from './social-feed.service';
import { UserTravelStreakService } from './user-travel-streak.service';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [
    SocialFeedController,
    SocialStoriesController,
    SocialChallengesController,
    PostLikesController,
    PostSavesController,
    PostCommentsController,
    PostSharesController,
    PostsController,
  ],

  providers: [
    PostsService,
    PostLikesService,
    PostSavesService,
    PostCommentsService,
    PostSharesService,
    SocialStoriesService,
    SocialChallengesService,
    SocialFeedService,
    UserTravelStreakService,
  ],

  exports: [
    PostsService,
    PostLikesService,
    PostSavesService,
    PostCommentsService,
    PostSharesService,
    SocialFeedService,
    SocialStoriesService,
    SocialChallengesService,
  ],
})
export class PostsModule {}
