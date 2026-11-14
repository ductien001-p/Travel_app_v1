import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { TripGateway } from '../../websocket/gateway';
import {
  FRIEND_REQUEST_STATUS,
  MEMBER_STATUS,
  TRIP_STATUS,
  USER_STATUS,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';
import {
  dnaSimilarity,
  topTravelPersona,
  travelPersonaLabel,
  type TravelDnaScore,
} from '../trips/trip-relations/trip-join-requests/join-request-match';
import { TRAVEL_DNA_CONFIG } from '../travelDNA/travel.constant';
import {
  FindFriendsActionDto,
  FindFriendsBadgeToneDto,
  FindFriendsContactChipToneDto,
  FindFriendsPageResponseDto,
  FindFriendsQueryDto,
  FindFriendsUserResponseDto,
  FindFriendsNearbySuggestionResponseDto,
  FindFriendsBadgeResponseDto,
} from './dto/find-friends.dto';
import {
  DiscoveryLocationResponseDto,
  UpdateDiscoveryLocationDto,
} from './dto/discovery-location.dto';

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

type MediaUrlSource = { objectKey: string; deletedAt: Date | null } | null;

const RESULTS_LIMIT = 20;
const NEARBY_LIMIT = 12;
const NEARBY_RADIUS_KM = 5;
const DNA_DISCOVERY_LIMIT = 20;

const DNA_BANNER = {
  badgeLabel: 'TRAVEL DNA MATCH',
  title: 'Tìm Bạn Đồng Hành Hợp Gu 95%+',
  subtitle:
    'Khám phá những người có cùng tốc độ du lịch, sở thích trekking và phong cách ẩm thực quanh bạn.',
  ctaLabel: 'Quét DNA ngay',
} as const;

@Injectable()
export class FindFriendsService {
  private readonly logger = new Logger(FindFriendsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly tripGateway: TripGateway,
  ) {}

  async updateDiscoveryLocation(
    userId: string,
    dto: UpdateDiscoveryLocationDto,
  ): Promise<DiscoveryLocationResponseDto> {
    const share = dto.shareLocationForDiscovery ?? true;
    const updated = await this.prisma.user.update({
      where: { id: userId },
      data: {
        discoveryLat: dto.lat,
        discoveryLng: dto.lng,
        discoveryLocatedAt: new Date(),
        shareLocationForDiscovery: share,
      },
      select: {
        discoveryLat: true,
        discoveryLng: true,
        discoveryLocatedAt: true,
        shareLocationForDiscovery: true,
      },
    });

    return {
      discoveryLat: updated.discoveryLat,
      discoveryLng: updated.discoveryLng,
      discoveryLocatedAt: updated.discoveryLocatedAt,
      shareLocationForDiscovery: updated.shareLocationForDiscovery,
    };
  }

  async find(
    viewerId: string,
    query: FindFriendsQueryDto,
  ): Promise<FindFriendsPageResponseDto> {
    const q = query.q?.trim() ?? '';
    const viewerDna = await this.loadDnaMap([viewerId]);
    const viewerScores = viewerDna.get(viewerId) ?? [];

    const candidateIds = q
      ? await this.searchUserIds(viewerId, q)
      : await this.discoveryUserIds(viewerId, viewerScores);

    const friendIds = await this.friendIdsOf(viewerId);
    const enriched = await this.enrichUsers(
      viewerId,
      candidateIds,
      viewerScores,
      friendIds,
    );

    const nearbyOrigin = await this.resolveNearbyOrigin(viewerId, query);
    const nearbySuggestions = nearbyOrigin
      ? await this.loadNearbySuggestions(
          viewerId,
          nearbyOrigin.lat,
          nearbyOrigin.lng,
          friendIds,
          viewerScores,
        )
      : [];

    const dnaBanner = await this.buildDnaBanner(viewerId, viewerScores);

    return {
      query: q,
      matchCount: enriched.length,
      matchCountLabel: `${enriched.length} tìm kiếm khớp`,
      recentSearches: [],
      dnaBanner,
      results: enriched,
      nearbySuggestions,
    };
  }

  private async searchUserIds(viewerId: string, q: string): Promise<string[]> {
    const normalizedUsername = q.replace(/^@/, '');
    const users = await this.prisma.user.findMany({
      where: {
        status: USER_STATUS.ACTIVE,
        deletedAt: null,
        id: { not: viewerId },
        OR: [
          {
            displayname: {
              startsWith: q,
              mode: 'insensitive',
            },
          },
          {
            username: {
              startsWith: normalizedUsername,
              mode: 'insensitive',
            },
          },
        ],
      },
      select: { id: true },
      take: RESULTS_LIMIT,
      orderBy: { displayname: 'asc' },
    });
    return users.map((u) => u.id);
  }

  /** Empty query: non-friend users ranked by DNA similarity to the viewer. */
  private async discoveryUserIds(
    viewerId: string,
    viewerScores: TravelDnaScore[],
  ): Promise<string[]> {
    const friendIds = await this.friendIdsOf(viewerId);
    const exclude = new Set([viewerId, ...friendIds]);

    if (viewerScores.length === 0) {
      const fallback = await this.prisma.user.findMany({
        where: {
          status: USER_STATUS.ACTIVE,
          deletedAt: null,
          id: { notIn: [...exclude] },
        },
        select: { id: true },
        take: DNA_DISCOVERY_LIMIT,
        orderBy: { createdAt: 'desc' },
      });
      return fallback.map((u) => u.id);
    }


    const dnaRows = await this.prisma.userTravelDNA.findMany({
      where: {
        score: { gt: 0 },
        userId: { notIn: [...exclude] },
        user: { status: USER_STATUS.ACTIVE, deletedAt: null },
      },
      select: { userId: true, type: true, score: true },
      take: 2000,
    });

    const byUser = new Map<string, TravelDnaScore[]>();
    for (const row of dnaRows) {
      const list = byUser.get(row.userId) ?? [];
      list.push({ type: row.type, score: row.score });
      byUser.set(row.userId, list);
    }

    const ranked = [...byUser.entries()]
      .map(([userId, scores]) => ({
        userId,
        match: dnaSimilarity(viewerScores, scores) ?? 0,
      }))
      .filter((row) => row.match >= 50)
      .sort((a, b) => b.match - a.match)
      .slice(0, DNA_DISCOVERY_LIMIT)
      .map((row) => row.userId);

    if (ranked.length > 0) return ranked;

    const fallback = await this.prisma.user.findMany({
      where: {
        status: USER_STATUS.ACTIVE,
        deletedAt: null,
        id: { notIn: [...exclude] },
      },
      select: { id: true },
      take: DNA_DISCOVERY_LIMIT,
      orderBy: { createdAt: 'desc' },
    });
    return fallback.map((u) => u.id);
  }

  private async enrichUsers(
    viewerId: string,
    userIds: string[],
    viewerScores: TravelDnaScore[],
    friendIds: Set<string>,
  ): Promise<FindFriendsUserResponseDto[]> {
    if (userIds.length === 0) return [];

    const [users, dnaMap, relation, sharedMap, followSet, conversationMap] =
      await Promise.all([
        this.prisma.user.findMany({
          where: { id: { in: userIds } },
          select: {
            id: true,
            username: true,
            displayname: true,
            isVerified: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        }),
        this.loadDnaMap(userIds),
        this.loadRelationMaps(viewerId, userIds),
        this.loadSharedTripCounts(viewerId, userIds),
        this.loadFollowingSet(viewerId, userIds),
        this.loadConversationIds(viewerId, userIds.filter((id) => friendIds.has(id))),
      ]);

    const online = await this.onlineSet(userIds);
    const byId = new Map(users.map((u) => [u.id, u]));

    const results: FindFriendsUserResponseDto[] = [];
    for (const id of userIds) {
      const user = byId.get(id);
      if (!user) continue;

      const scores = dnaMap.get(id) ?? [];
      const dnaMatchPercent = dnaSimilarity(viewerScores, scores);
      const persona = topTravelPersona(scores);
      const travelPersona = persona
        ? TRAVEL_DNA_CONFIG[persona.personaType].name
        : null;
      const sharedTripsCount = sharedMap.get(id) ?? 0;
      const status = relation.status.get(id) ?? 'NOT_FRIENDS';
      const isFollowing = followSet.has(id);

      const action = this.resolveAction({ status, isFollowing });

      const badges = this.buildBadges({
        travelPersona,
        personaIcon: persona ? TRAVEL_DNA_CONFIG[persona.personaType].icon : null,
        dnaMatchPercent,
        sharedTripsCount,
        status,
      });

      const { metaIcon, metaLine } = this.buildMetaLine({
        sharedTripsCount,
        locationHint: null,
        dnaMatchPercent,
      });

      results.push({
        id: user.id,
        displayName: user.displayname,
        username: user.username,
        avatarUrl: this.toPublicUrl(user.avatar),
        isOnline: online.has(user.id),
        verified: user.isVerified,
        action,
        friendRequestId:
          action === FindFriendsActionDto.REQUEST_SENT
            ? (relation.sentRequestIds.get(user.id) ?? null)
            : null,
        conversationId:
          action === FindFriendsActionDto.MESSAGE
            ? (conversationMap.get(user.id) ?? null)
            : null,
        badges,
        metaIcon,
        metaLine,
        travelPersona,
        dnaMatchPercent,
        sharedTripsCount: sharedTripsCount > 0 ? sharedTripsCount : null,
      });
    }

    return results;
  }

  private resolveAction(input: {
    status: string;
    isFollowing: boolean;
  }): FindFriendsActionDto {
    if (input.status === 'FRIENDS') return FindFriendsActionDto.MESSAGE;
    if (input.status === 'REQUEST_SENT') return FindFriendsActionDto.REQUEST_SENT;
    if (input.isFollowing) return FindFriendsActionDto.FOLLOWING;
    // Primary discovery CTA is always Kết bạn for non-friends.
    return FindFriendsActionDto.ADD_FRIEND;
  }

  private buildBadges(input: {
    travelPersona: string | null;
    personaIcon: string | null;
    dnaMatchPercent: number | null;
    sharedTripsCount: number;
    status: string;
  }): FindFriendsBadgeResponseDto[] {
    const badges: FindFriendsBadgeResponseDto[] = [];
    if (input.dnaMatchPercent != null && input.dnaMatchPercent >= 70) {
      badges.push({
        label: `${input.dnaMatchPercent}% tương thích DNA`,
        tone: FindFriendsBadgeToneDto.TEAL,
        icon: 'bolt',
      });
    }
    if (input.status === 'FRIENDS') {
      badges.push({
        label: 'Bạn bè thân thiết',
        tone: FindFriendsBadgeToneDto.PRIMARY_SOFT,
        icon: 'how_to_reg',
      });
    }
    if (input.travelPersona) {
      const label = input.personaIcon
        ? `${input.personaIcon} ${input.travelPersona}`
        : input.travelPersona;
      badges.push({
        label,
        tone: FindFriendsBadgeToneDto.AMBER,
        icon: null,
      });
    }
    if (input.sharedTripsCount > 0 && input.status !== 'FRIENDS') {
      badges.push({
        label: 'Cùng sở thích leo núi',
        tone: FindFriendsBadgeToneDto.PRIMARY,
        icon: 'hiking',
      });
    }
    return badges.slice(0, 3);
  }

  private buildMetaLine(input: {
    sharedTripsCount: number;
    locationHint: string | null;
    dnaMatchPercent: number | null;
  }): { metaIcon: string | null; metaLine: string | null } {
    if (input.sharedTripsCount > 0) {
      return {
        metaIcon: 'luggage',
        metaLine: `Đã cùng đi ${input.sharedTripsCount} chuyến`,
      };
    }
    if (input.locationHint) {
      return {
        metaIcon: 'location_on',
        metaLine: input.locationHint,
      };
    }
    if (input.dnaMatchPercent != null) {
      return {
        metaIcon: 'group',
        metaLine: `Độ hợp Travel DNA ${input.dnaMatchPercent}%`,
      };
    }
    return { metaIcon: null, metaLine: null };
  }

  private async buildDnaBanner(viewerId: string, viewerScores: TravelDnaScore[]) {
    const friendIds = [...(await this.friendIdsOf(viewerId))];
    if (friendIds.length === 0 || viewerScores.length === 0) {
      return {
        ...DNA_BANNER,
        extraCount: 0,
        previewAvatars: [] as string[],
      };
    }

    const dnaMap = await this.loadDnaMap(friendIds);
    const ranked = friendIds
      .map((id) => ({
        id,
        match: dnaSimilarity(viewerScores, dnaMap.get(id) ?? []) ?? 0,
      }))
      .filter((row) => row.match >= 70)
      .sort((a, b) => b.match - a.match);

    const previewIds = ranked.slice(0, 3).map((r) => r.id);
    const users = await this.prisma.user.findMany({
      where: { id: { in: previewIds } },
      select: { id: true, avatar: { select: MEDIA_URL_SELECT } },
    });
    const urlById = new Map(
      users.map((u) => [u.id, this.toPublicUrl(u.avatar)]),
    );
    const previewAvatars = previewIds
      .map((id) => urlById.get(id))
      .filter((url): url is string => !!url);

    return {
      ...DNA_BANNER,
      extraCount: Math.max(0, ranked.length - previewAvatars.length),
      previewAvatars,
    };
  }

  private async resolveNearbyOrigin(
    viewerId: string,
    query: FindFriendsQueryDto,
  ): Promise<{ lat: number; lng: number } | null> {
    if (query.lat != null && query.lng != null) {
      return { lat: query.lat, lng: query.lng };
    }
    const viewer = await this.prisma.user.findUnique({
      where: { id: viewerId },
      select: {
        discoveryLat: true,
        discoveryLng: true,
        shareLocationForDiscovery: true,
      },
    });
    if (
      viewer?.shareLocationForDiscovery &&
      viewer.discoveryLat != null &&
      viewer.discoveryLng != null
    ) {
      return { lat: viewer.discoveryLat, lng: viewer.discoveryLng };
    }
    return null;
  }

  private async loadNearbySuggestions(
    viewerId: string,
    lat: number,
    lng: number,
    friendIds: Set<string>,
    viewerScores: TravelDnaScore[],
  ): Promise<FindFriendsNearbySuggestionResponseDto[]> {
    const latDelta = NEARBY_RADIUS_KM / 111;
    const cos = Math.cos((lat * Math.PI) / 180);
    const lngDelta = NEARBY_RADIUS_KM / (111 * Math.max(cos, 0.01));

    const candidates = await this.prisma.user.findMany({
      where: {
        status: USER_STATUS.ACTIVE,
        deletedAt: null,
        shareLocationForDiscovery: true,
        discoveryLat: {
          gte: lat - latDelta,
          lte: lat + latDelta,
        },
        discoveryLng: {
          gte: lng - lngDelta,
          lte: lng + lngDelta,
        },
        id: { not: viewerId },
      },
      select: {
        id: true,
        displayname: true,
        discoveryLat: true,
        discoveryLng: true,
        avatar: { select: MEDIA_URL_SELECT },
      },
      take: 80,
    });

    const withDistance = candidates
      .filter((u) => !friendIds.has(u.id))
      .map((u) => ({
        ...u,
        distanceKm: haversineKm(
          lat,
          lng,
          u.discoveryLat as number,
          u.discoveryLng as number,
        ),
      }))
      .filter((u) => u.distanceKm <= NEARBY_RADIUS_KM)
      .sort((a, b) => a.distanceKm - b.distanceKm)
      .slice(0, NEARBY_LIMIT);

    if (withDistance.length === 0) return [];

    const ids = withDistance.map((u) => u.id);
    const [relation, dnaMap, mutualMap, followSet] = await Promise.all([
      this.loadRelationMaps(viewerId, ids),
      this.loadDnaMap(ids),
      this.loadMutualFriendCounts(viewerId, ids),
      this.loadFollowingSet(viewerId, ids),
    ]);

    return withDistance.map((u) => {
      const status = relation.status.get(u.id) ?? 'NOT_FRIENDS';
      const scores = dnaMap.get(u.id) ?? [];
      const dnaMatch = dnaSimilarity(viewerScores, scores);
      const persona = travelPersonaLabel(scores);
      const mutual = mutualMap.get(u.id) ?? 0;
      const action = this.resolveAction({
        status,
        isFollowing: followSet.has(u.id),
      });

      let chipLabel = 'Gần bạn';
      let chipTone = FindFriendsContactChipToneDto.SECONDARY;
      if (mutual > 0) {
        chipLabel = `${mutual} bạn chung`;
        chipTone = FindFriendsContactChipToneDto.PRIMARY;
      } else if (persona) {
        chipLabel = `Cùng thích ${persona.split(' ')[0] ?? 'du lịch'}`;
      }

      return {
        id: u.id,
        displayName: u.displayname,
        avatarUrl: this.toPublicUrl(u.avatar),
        subtitle: `Đang ở gần bạn (${u.distanceKm.toFixed(1)}km)`,
        chipLabel,
        chipTone,
        action,
        friendRequestId:
          action === FindFriendsActionDto.REQUEST_SENT
            ? (relation.sentRequestIds.get(u.id) ?? null)
            : null,
        distanceKm: Number(u.distanceKm.toFixed(2)),
      };
    });
  }

  private async friendIdsOf(userId: string): Promise<Set<string>> {
    const rows = await this.prisma.friendship.findMany({
      where: { userId },
      select: { friendId: true },
    });
    return new Set(rows.map((r) => r.friendId));
  }

  private async loadDnaMap(
    userIds: string[],
  ): Promise<Map<string, TravelDnaScore[]>> {
    if (userIds.length === 0) return new Map();
    const rows = await this.prisma.userTravelDNA.findMany({
      where: { userId: { in: userIds } },
      select: { userId: true, type: true, score: true },
    });
    const map = new Map<string, TravelDnaScore[]>();
    for (const row of rows) {
      const list = map.get(row.userId) ?? [];
      list.push({ type: row.type, score: row.score });
      map.set(row.userId, list);
    }
    return map;
  }

  private async loadRelationMaps(
    viewerId: string,
    userIds: string[],
  ): Promise<{
    status: Map<string, string>;
    sentRequestIds: Map<string, string>;
  }> {
    const status = new Map<string, string>();
    const sentRequestIds = new Map<string, string>();
    if (userIds.length === 0) return { status, sentRequestIds };

    const [friendships, sent, received] = await Promise.all([
      this.prisma.friendship.findMany({
        where: { userId: viewerId, friendId: { in: userIds } },
        select: { friendId: true },
      }),
      this.prisma.friendRequest.findMany({
        where: {
          fromUserId: viewerId,
          toUserId: { in: userIds },
          status: FRIEND_REQUEST_STATUS.PENDING,
        },
        select: { id: true, toUserId: true },
      }),
      this.prisma.friendRequest.findMany({
        where: {
          toUserId: viewerId,
          fromUserId: { in: userIds },
          status: FRIEND_REQUEST_STATUS.PENDING,
        },
        select: { fromUserId: true },
      }),
    ]);

    for (const id of userIds) status.set(id, 'NOT_FRIENDS');
    for (const row of friendships) status.set(row.friendId, 'FRIENDS');
    for (const row of sent) {
      if (status.get(row.toUserId) !== 'FRIENDS') {
        status.set(row.toUserId, 'REQUEST_SENT');
        sentRequestIds.set(row.toUserId, row.id);
      }
    }
    for (const row of received) {
      if (status.get(row.fromUserId) === 'NOT_FRIENDS') {
        status.set(row.fromUserId, 'REQUEST_RECEIVED');
      }
    }
    return { status, sentRequestIds };
  }

  private async loadSharedTripCounts(
    viewerId: string,
    userIds: string[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    if (userIds.length === 0) return map;

    const myTripIds = (
      await this.prisma.tripMember.findMany({
        where: { userId: viewerId, status: MEMBER_STATUS.ACTIVE },
        select: { tripId: true },
      })
    ).map((m) => m.tripId);

    if (myTripIds.length === 0) return map;

    const shared = await this.prisma.tripMember.findMany({
      where: {
        userId: { in: userIds },
        status: MEMBER_STATUS.ACTIVE,
        tripId: { in: myTripIds },
        trip: {
          status: {
            in: [
              TRIP_STATUS.UPCOMING,
              TRIP_STATUS.ONGOING,
              TRIP_STATUS.COMPLETED,
            ],
          },
        },
      },
      select: { userId: true },
    });

    for (const row of shared) {
      map.set(row.userId, (map.get(row.userId) ?? 0) + 1);
    }
    return map;
  }

  private async loadFollowingSet(
    viewerId: string,
    userIds: string[],
  ): Promise<Set<string>> {
    if (userIds.length === 0) return new Set();
    const rows = await this.prisma.userFollow.findMany({
      where: { followerId: viewerId, followingId: { in: userIds } },
      select: { followingId: true },
    });
    return new Set(rows.map((r) => r.followingId));
  }

  private async loadConversationIds(
    viewerId: string,
    friendIds: string[],
  ): Promise<Map<string, string>> {
    const map = new Map<string, string>();
    if (friendIds.length === 0) return map;

    const pairs = friendIds.map((friendId) => {
      const [user1Id, user2Id] =
        viewerId < friendId ? [viewerId, friendId] : [friendId, viewerId];
      return { user1Id, user2Id, friendId };
    });

    const conversations = await this.prisma.friendConversation.findMany({
      where: {
        OR: pairs.map((p) => ({
          user1Id: p.user1Id,
          user2Id: p.user2Id,
        })),
      },
      select: { id: true, user1Id: true, user2Id: true },
    });

    for (const conv of conversations) {
      const peerId =
        conv.user1Id === viewerId ? conv.user2Id : conv.user1Id;
      map.set(peerId, conv.id);
    }
    return map;
  }

  private async loadMutualFriendCounts(
    viewerId: string,
    userIds: string[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    if (userIds.length === 0) return map;

    const myFriends = await this.friendIdsOf(viewerId);
    if (myFriends.size === 0) return map;

    const theirFriendships = await this.prisma.friendship.findMany({
      where: {
        userId: { in: userIds },
        friendId: { in: [...myFriends] },
      },
      select: { userId: true },
    });

    for (const row of theirFriendships) {
      map.set(row.userId, (map.get(row.userId) ?? 0) + 1);
    }
    return map;
  }

  private async onlineSet(userIds: string[]): Promise<Set<string>> {
    if (userIds.length === 0) return new Set();
    try {
      return await this.tripGateway.getConnectedUserIds(userIds);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence batch: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      return new Set();
    }
  }

  private toPublicUrl(media: MediaUrlSource): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }
}

function haversineKm(
  lat1: number,
  lng1: number,
  lat2: number,
  lng2: number,
): number {
  const toRad = (deg: number) => (deg * Math.PI) / 180;
  const dLat = toRad(lat2 - lat1);
  const dLng = toRad(lng2 - lng1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLng / 2) ** 2;
  return 2 * 6371 * Math.asin(Math.sqrt(a));
}
