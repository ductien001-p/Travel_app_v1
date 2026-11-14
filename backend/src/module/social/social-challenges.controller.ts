import { Controller, Param, Post } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiProperty,
  ApiTags,
} from '@nestjs/swagger';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { SocialChallengesService } from './social-challenges.service';

class SocialChallengeResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  eyebrow!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  rewardLabel!: string;

  @ApiProperty()
  progressLabel!: string;

  @ApiProperty()
  progressRatio!: number;

  @ApiProperty()
  daysLeftLabel!: string;

  @ApiProperty()
  badgeLabel!: string;

  @ApiProperty()
  ctaLabel!: string;
}

class SocialChallengeEnvelopeResponseDto {
  @ApiProperty({ type: SocialChallengeResponseDto })
  data!: SocialChallengeResponseDto;

  @ApiProperty()
  message!: string;
}

@ApiTags('Social Challenges')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/challenges')
export class SocialChallengesController {
  constructor(private readonly challengesService: SocialChallengesService) {}

  @Post(':challengeId/join')
  @ApiOkResponse({ type: SocialChallengeEnvelopeResponseDto })
  async join(
    @CurrentUser('id') userId: string,
    @Param('challengeId') challengeId: string,
  ) {
    const data = await this.challengesService.join(userId, challengeId);
    return {
      data,
      message: 'Joined challenge successfully',
    };
  }
}
