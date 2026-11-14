import { Controller, Get } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { CurrentUser } from '../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { ChatsHubService } from './chats-hub.service';
import { ChatsHubEnvelopeResponseDto } from './dto/chats-hub-response.dto';

@ApiTags('Chats')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('chats')
export class ChatsController {
  constructor(private readonly chatsHubService: ChatsHubService) {}

  @Get('hub')
  @ApiOkResponse({ type: ChatsHubEnvelopeResponseDto })
  async getHub(@CurrentUser('id') userId: string) {
    const data = await this.chatsHubService.getHub(userId);

    return {
      data,
      message: 'Chat hub retrieved successfully',
    };
  }
}
