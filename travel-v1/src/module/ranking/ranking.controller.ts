import { Controller, Get, Query } from '@nestjs/common';
import { RankingService } from './ranking.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { PaginationDto } from '../users/dto/pagination.dto';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { RankingResponseDto } from '../../common/contracts/extended-response.dto';

@ApiTags('Ranking')
@ApiBearerAuth('access-token')
@Controller('ranking')
export class RankingController {
  constructor(private readonly rankingService: RankingService) {}

  @Get('leaderboard')
  @ApiOkResponse({ type: [RankingResponseDto] })
  leaderboard(@Query() page: PaginationDto) {
    return this.rankingService.leaderboard(page);
  }
  @Get('me')
  @ApiOkResponse({ type: RankingResponseDto })
  async getUserRanking(@CurrentUser('id') userId: string) {
    const data = await this.rankingService.getUserRanking(userId);
    return {
      data,
      message: 'User ranking retrieved successfully',
    };
  }
}
