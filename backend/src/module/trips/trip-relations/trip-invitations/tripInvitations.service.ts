import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import {
  INVITATION_STATUS,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_ROLE,
  TRIP_STATUS,
  USER_STATUS,
} from '../../../../generated/prisma/browser';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripGateway } from '../../../../websocket/gateway';
import { CreateTripInvitationDto } from '../../dto/trip-invitation.dto';
import { PrismaService } from '../../../../prisma.service';
import { NotificationsService } from '../../../../notification/notification.service';
import { PushNotificationsService } from '../../../../notification/push-notification.service';
import { Prisma } from '../../../../generated/prisma/client';
import { createPaginationMeta } from '../../../../common/contracts/pagination-meta.dto';
import { GetTripInvitationsDto } from './dto/get-invitation.sto';
import { GetReceivedInvitationsDto } from './dto/get-received-invitations.dto';
import { TripAccessPolicy, TripResourcePolicy } from '../../policies';

@Injectable()
export class TripInvitationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly notificationsService: NotificationsService,
    private readonly pushNotificationsService: PushNotificationsService,
    private readonly tripTimelineService: TripTimelineService,
    private readonly tripGateway: TripGateway,
  ) {}
  async createInvitation(dto: CreateTripInvitationDto, inviterId: string) {
    const { inviteeId, tripId } = dto;

    TripResourcePolicy.assertDifferentUsers(
      inviterId,
      inviteeId,
      'You cannot invite yourself',
    );

    const result = await this.prisma.$transaction(async (tx) => {
      const trip = await tx.trip.findUnique({
        where: { id: tripId },
        select: {
          id: true,
          name: true,
          status: true,
          maxMembers: true,
          members: {
            where: { userId: inviterId },
            select: {
              role: true,
              status: true,
              user: { select: { username: true } },
            },
            take: 1,
          },
        },
      });
      if (!trip) {
        throw new NotFoundException('Trip not found');
      }

      const inviter = trip.members[0];
      TripAccessPolicy.assertAllowed(inviter, 'INVITE_MEMBER');

      if (trip.status !== TRIP_STATUS.UPCOMING) {
        throw new ConflictException('Trip is not open for new members');
      }
      const activeMemberCount = await tx.tripMember.count({
        where: { tripId, status: MEMBER_STATUS.ACTIVE },
      });
      if (trip.maxMembers !== null && activeMemberCount >= trip.maxMembers) {
        throw new ConflictException('Trip is full');
      }

      const invitee = await tx.user.findFirst({
        where: { id: inviteeId, deletedAt: null, status: USER_STATUS.ACTIVE },
        select: { id: true },
      });
      if (!invitee) {
        throw new NotFoundException('User to invite not found');
      }

      const member = await tx.tripMember.findUnique({
        where: { tripId_userId: { tripId, userId: inviteeId } },
        select: { status: true },
      });
      if (member?.status === MEMBER_STATUS.ACTIVE) {
        throw new ConflictException('User is already a member of this trip');
      }

      // A previous invitation that was rejected, cancelled, or accepted by
      // someone who has since left is reopened instead of duplicated.
      const existingInvitation = await tx.tripInvitation.findUnique({
        where: { tripId_inviteeId: { tripId, inviteeId } },
        select: { id: true, status: true },
      });
      if (existingInvitation?.status === INVITATION_STATUS.PENDING) {
        throw new ConflictException('Invitation is already pending');
      }

      const invitation = existingInvitation
        ? await tx.tripInvitation.update({
            where: { id: existingInvitation.id },
            data: { inviterId, status: INVITATION_STATUS.PENDING },
          })
        : await tx.tripInvitation.create({
            data: {
              tripId,
              inviterId,
              inviteeId,
              status: INVITATION_STATUS.PENDING,
            },
          });

      const message = `${inviter.user.username} đã mời bạn tham gia chuyến đi "${trip.name}"`;
      await this.notificationsService.create(tx, {
        userId: inviteeId,
        actorId: inviterId,
        tripId,
        type: NOTIFICATION_TYPE.TRIP_INVITATION,
        title: 'Lời mời tham gia chuyến đi',
        message,
      });

      return { invitation, message };
    });

    // Transaction đã commit → gửi push (fire-and-forget), lỗi push không ảnh hưởng lời mời
    this.pushNotificationsService
      .sendToUser(inviteeId, {
        title: 'Lời mời tham gia chuyến đi',
        body: result.message,
        data: {
          type: NOTIFICATION_TYPE.TRIP_INVITATION,
          tripId,
          invitationId: result.invitation.id,
        },
      })
      .catch((err) => {
        console.error('Failed to send push notification:', err);
      });

    return result.invitation;
  }
  async acceptInvitation(invitationId: string, userId: string) {
    const result = await this.prisma
      .$transaction(
        async (tx) => {
          const invitation = await tx.tripInvitation.findUnique({
            where: { id: invitationId },
            include: {
              trip: {
                select: {
                  id: true,
                  name: true,
                  status: true,
                  maxMembers: true,
                },
              },
              invitee: { select: { id: true, username: true } },
            },
          });

          if (!invitation) {
            throw new NotFoundException('Invitation not found');
          }
          TripResourcePolicy.assertOwnedBy(
            invitation.inviteeId,
            userId,
            'Only the invitee can accept this invitation',
          );
          if (invitation.status !== INVITATION_STATUS.PENDING) {
            throw new BadRequestException('Invitation is no longer pending');
          }
          if (invitation.trip.status !== TRIP_STATUS.UPCOMING) {
            throw new ConflictException('Trip is not open for joining');
          }

          const existingMember = await tx.tripMember.findUnique({
            where: {
              tripId_userId: {
                tripId: invitation.tripId,
                userId: invitation.inviteeId,
              },
            },
            select: { id: true, status: true },
          });
          if (existingMember?.status === MEMBER_STATUS.ACTIVE) {
            throw new ConflictException(
              'User is already a member of this trip',
            );
          }

          const activeMemberCount = await tx.tripMember.count({
            where: {
              tripId: invitation.tripId,
              status: MEMBER_STATUS.ACTIVE,
            },
          });
          if (
            invitation.trip.maxMembers !== null &&
            activeMemberCount >= invitation.trip.maxMembers
          ) {
            throw new ConflictException('Trip is full');
          }
          const accepted = await tx.tripInvitation.updateMany({
            where: {
              id: invitationId,
              inviteeId: userId,
              status: INVITATION_STATUS.PENDING,
            },
            data: { status: INVITATION_STATUS.ACCEPTED },
          });
          if (accepted.count !== 1) {
            throw new ConflictException('Invitation is no longer pending');
          }

          const member = await tx.tripMember.upsert({
            where: {
              tripId_userId: {
                tripId: invitation.tripId,
                userId: invitation.inviteeId,
              },
            },
            update: {
              role: TRIP_ROLE.MEMBER,
              status: MEMBER_STATUS.ACTIVE,
              leftAt: null,
              joinedAt: new Date(),
            },
            create: {
              tripId: invitation.tripId,
              userId: invitation.inviteeId,
              status: MEMBER_STATUS.ACTIVE,
            },
          });

          const timelineEvent = await this.tripTimelineService.createEvent(
            tx,
            invitation.tripId,
            invitation.inviteeId,
            {
              type: TIMELINE_EVENT_TYPE.MEMBER_JOINED,
              content: 'Đã tham gia chuyến đi',
              metadata: { via: 'INVITATION' },
              target: { type: TIMELINE_TARGET_TYPE.MEMBER, id: member.id },
            },
          );

          await this.notificationsService.create(tx, {
            userId: invitation.inviterId,
            actorId: invitation.inviteeId,
            tripId: invitation.tripId,
            type: NOTIFICATION_TYPE.TRIP_INVITATION_ACCEPTED,
            title: 'Lời mời đã được chấp nhận',
            message: `${invitation.invitee.username} đã chấp nhận lời mời tham gia chuyến đi "${invitation.trip.name}"`,
          });

          const updatedInvitation = await tx.tripInvitation.findUnique({
            where: { id: invitationId },
          });
          return { updatedInvitation, invitation, timelineEvent };
        },
        { isolationLevel: 'Serializable' },
      )
      .catch((error: unknown) => {
        if (
          error instanceof Prisma.PrismaClientKnownRequestError &&
          (error.code === 'P2002' || error.code === 'P2034')
        ) {
          throw new ConflictException(
            'Trip membership changed while accepting; please retry',
          );
        }
        throw error;
      });

    this.tripGateway.emitTimelineEvent(
      result.invitation.tripId,
      result.timelineEvent,
    );

    // Transaction đã commit thành công → giờ mới gửi push, an toàn để fail riêng lẻ
    // không await để không block response trả về cho client (fire-and-forget)
    this.pushNotificationsService
      .sendToUser(result.invitation.inviterId, {
        title: 'Lời mời đã được chấp nhận',
        body: `${result.invitation.invitee.username} đã chấp nhận lời mời tham gia chuyến đi "${result.invitation.trip.name}"`,
        data: {
          type: NOTIFICATION_TYPE.TRIP_INVITATION_ACCEPTED,
          tripId: result.invitation.tripId,
          invitationId: result.invitation.id,
        },
      })
      .catch((err) => {
        // log lỗi nhưng không throw — notification trong DB đã lưu thành công,
        // user vẫn thấy được khi mở app, chỉ là không có push tức thời
        console.error('Failed to send push notification:', err);
      });

    return result.updatedInvitation;
  }

  async rejectInvitation(invitationId: string, userId: string) {
    const invitation = await this.prisma.tripInvitation.findUnique({
      where: { id: invitationId },
      include: {
        trip: { select: { id: true, name: true } },
        invitee: { select: { id: true, username: true } },
      },
    });

    if (!invitation) {
      throw new NotFoundException('Invitation not found');
    }

    TripResourcePolicy.assertOwnedBy(
      invitation.inviteeId,
      userId,
      'Only the invitee can reject this invitation',
    );

    if (invitation.status !== INVITATION_STATUS.PENDING) {
      throw new BadRequestException('Invitation is no longer pending');
    }

    const result = await this.prisma.$transaction(async (tx) => {
      const rejected = await tx.tripInvitation.updateMany({
        where: {
          id: invitationId,
          inviteeId: userId,
          status: INVITATION_STATUS.PENDING,
        },
        data: { status: INVITATION_STATUS.REJECTED },
      });
      if (rejected.count !== 1) {
        throw new ConflictException('Invitation is no longer pending');
      }
      const updatedInvitation = await tx.tripInvitation.findUniqueOrThrow({
        where: { id: invitationId },
      });

      await this.notificationsService.create(tx, {
        userId: invitation.inviterId,
        actorId: invitation.inviteeId,
        tripId: invitation.tripId,
        type: NOTIFICATION_TYPE.TRIP_INVITATION_REJECTED,
        title: 'Lời mời đã bị từ chối',
        message: `${invitation.invitee.username} đã từ chối lời mời tham gia chuyến đi "${invitation.trip.name}"`,
      });

      return updatedInvitation;
    });

    // Transaction đã commit thành công → giờ mới gửi push, an toàn để fail riêng lẻ
    // không await để không block response trả về cho client (fire-and-forget)
    this.pushNotificationsService
      .sendToUser(invitation.inviterId, {
        title: 'Lời mời đã bị từ chối',
        body: `${invitation.invitee.username} đã từ chối lời mời tham gia chuyến đi "${invitation.trip.name}"`,
        data: {
          type: NOTIFICATION_TYPE.TRIP_INVITATION_REJECTED,
          tripId: invitation.tripId,
          invitationId: invitation.id,
        },
      })
      .catch((err) => {
        // log lỗi nhưng không throw — notification trong DB đã lưu thành công,
        // user vẫn thấy được khi mở app, chỉ là không có push tức thời
        console.error('Failed to send push notification:', err);
      });

    return result;
  }

  async getSendingInvitationsForTrip(
    userId: string,
    dto: GetTripInvitationsDto,
  ) {
    /*
     * 1. Check trip exists
     */
    const trip = await this.prisma.trip.findUnique({
      where: {
        id: dto.tripId,
      },

      select: {
        id: true,
      },
    });

    if (!trip) {
      throw new NotFoundException('Trip not found');
    }

    /*
     * 2. OWNER / ADMIN mới được xem
     */
    const membership = await this.prisma.tripMember.findUnique({
      where: {
        tripId_userId: {
          tripId: dto.tripId,
          userId,
        },
      },

      select: {
        role: true,
        status: true,
      },
    });

    TripAccessPolicy.assertAllowed(membership, 'MANAGE_INVITATIONS');

    /*
     * 3. Pagination
     */
    const page = Math.max(dto.page, 1);

    const limit = Math.min(Math.max(dto.limit, 1), 100);

    const skip = (page - 1) * limit;

    /*
     * 4. Status filter: pending by default, like the received list
     */
    const where = {
      tripId: dto.tripId,
      status: dto.status ?? INVITATION_STATUS.PENDING,
    };

    /*
     * 5. Query
     */
    const [invitations, total] = await this.prisma.$transaction([
      this.prisma.tripInvitation.findMany({
        where,

        skip,
        take: limit,

        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],

        select: {
          id: true,
          status: true,
          createdAt: true,
          updatedAt: true,

          invitee: {
            select: {
              id: true,
              username: true,
              displayname: true,
              avatarId: true,
            },
          },
        },
      }),

      this.prisma.tripInvitation.count({
        where,
      }),
    ]);

    return {
      data: invitations,

      meta: createPaginationMeta(page, limit, total),
    };
  }

  async getReceivedInvitations(userId: string, dto: GetReceivedInvitationsDto) {
    const { page, limit } = dto;
    const where: Prisma.TripInvitationWhereInput = {
      inviteeId: userId,
      status: dto.status ?? INVITATION_STATUS.PENDING,
    };

    const [invitations, total] = await this.prisma.$transaction([
      this.prisma.tripInvitation.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        select: {
          id: true,
          tripId: true,
          inviterId: true,
          inviteeId: true,
          status: true,
          createdAt: true,
          updatedAt: true,
          inviter: { select: { id: true, username: true, avatarId: true } },
          trip: {
            select: {
              id: true,
              name: true,
              status: true,
              startDate: true,
              endDate: true,
            },
          },
        },
      }),
      this.prisma.tripInvitation.count({ where }),
    ]);

    return {
      data: invitations,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  async cancelInvitation(tripId: string, invitationId: string, userId: string) {
    /*
     * 1. Check OWNER / ADMIN
     */
    const membership = await this.prisma.tripMember.findUnique({
      where: {
        tripId_userId: {
          tripId,
          userId,
        },
      },

      select: {
        role: true,
        status: true,
      },
    });

    TripAccessPolicy.assertAllowed(membership, 'MANAGE_INVITATIONS');

    /*
     * 2. Find invitation
     */
    const invitation = await this.prisma.tripInvitation.findFirst({
      where: {
        id: invitationId,
        tripId,
      },
    });

    if (!invitation) {
      throw new NotFoundException('Invitation not found');
    }

    /*
     * 3. Chỉ PENDING mới cancel được
     */
    if (invitation.status !== INVITATION_STATUS.PENDING) {
      throw new BadRequestException(
        `Cannot cancel invitation with status ${invitation.status}`,
      );
    }

    /*
     * 4. Update status (chỉ khi vẫn PENDING, tránh ghi đè lời mời vừa được accept)
     */
    const cancelled = await this.prisma.tripInvitation.updateMany({
      where: {
        id: invitation.id,
        status: INVITATION_STATUS.PENDING,
      },
      data: {
        status: INVITATION_STATUS.CANCELLED,
      },
    });
    if (cancelled.count !== 1) {
      throw new ConflictException('Invitation is no longer pending');
    }

    return this.prisma.tripInvitation.findUniqueOrThrow({
      where: {
        id: invitation.id,
      },

      select: {
        id: true,
        status: true,
        createdAt: true,
        updatedAt: true,

        invitee: {
          select: {
            id: true,
            username: true,
            displayname: true,
            avatarId: true,
          },
        },
      },
    });
  }
}
