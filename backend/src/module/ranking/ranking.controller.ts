import { Controller, Get, Param, Post, Query } from '@nestjs/common';
import { RankingService } from './ranking.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import {
  RankingLeaderboardResponseDto,
  RankingMeEnvelopeResponseDto,
  RankingQuestClaimResponseDto,
  RankingQuestsResponseDto,
} from '../../common/contracts/extended-response.dto';
import {
  RankingLeaderboardQueryDto,
  RankingMeQueryDto,
} from './dto/ranking-period.dto';

@ApiTags('Ranking')
@ApiBearerAuth('access-token')
@Controller('ranking')
export class RankingController {
  constructor(private readonly rankingService: RankingService) {}

  @Get('leaderboard')
  @ApiOkResponse({ type: RankingLeaderboardResponseDto })
  leaderboard(@Query() query: RankingLeaderboardQueryDto) {
    return this.rankingService.leaderboard(query);
  }

  @Get('me')
  @ApiOkResponse({ type: RankingMeEnvelopeResponseDto })
  async getUserRanking(
    @CurrentUser('id') userId: string,
    @Query() query: RankingMeQueryDto,
  ) {
    const data = await this.rankingService.getUserRanking(userId, query);
    return {
      data,
      message: 'User ranking retrieved successfully',
    };
  }

  @Get('quests')
  @ApiOkResponse({ type: RankingQuestsResponseDto })
  listQuests(@CurrentUser('id') userId: string) {
    return this.rankingService.listQuests(userId);
  }

  @Post('quests/:questId/claim')
  @ApiOkResponse({ type: RankingQuestClaimResponseDto })
  async claimQuest(
    @CurrentUser('id') userId: string,
    @Param('questId') questId: string,
  ) {
    const data = await this.rankingService.claimQuest(userId, questId);
    return {
      data,
      message: 'Quest claimed successfully',
    };
  }
}
