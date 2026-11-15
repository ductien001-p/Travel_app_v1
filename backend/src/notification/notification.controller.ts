import { Controller, Get, Param, Post, Query } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { CurrentUser } from '../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../common/contracts/api-standard-errors.decorator';
import { NotificationsService } from './notification.service';
import { ListNotificationsQueryDto } from './dto/list-notifications.query.dto';
import {
  NotificationListResponseDto,
  NotificationReadAllEnvelopeDto,
  NotificationReadEnvelopeDto,
} from './dto/notification-response.dto';

@ApiTags('Notifications')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Get()
  @ApiOkResponse({ type: NotificationListResponseDto })
  list(
    @CurrentUser('id') userId: string,
    @Query() query: ListNotificationsQueryDto,
  ) {
    return this.notificationsService.listForUser(
      userId,
      query.limit,
      query.cursor,
    );
  }

  @Post('read-all')
  @ApiOkResponse({ type: NotificationReadAllEnvelopeDto })
  async markAllRead(@CurrentUser('id') userId: string) {
    const data = await this.notificationsService.markAllRead(userId);
    return { data };
  }

  @Post(':id/read')
  @ApiOkResponse({ type: NotificationReadEnvelopeDto })
  async markRead(
    @CurrentUser('id') userId: string,
    @Param('id') notificationId: string,
  ) {
    const data = await this.notificationsService.markRead(
      userId,
      notificationId,
    );
    return { data };
  }
}
