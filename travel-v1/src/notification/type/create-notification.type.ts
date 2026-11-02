import { NOTIFICATION_TYPE } from '../../generated/prisma/enums';

export type CreateNotificationParams = {
  userId: string;
  actorId?: string;
  tripId?: string;
  type: NOTIFICATION_TYPE;
  title: string;
  message: string;
};
