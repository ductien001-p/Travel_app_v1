/**
 * Idempotent Social Feed E2E seed.
 *
 * Creates demo LOCAL authors (not real Google logins) + posts/stories/follows/
 * challenge/streak/notification/recruiting trip so the current Google viewer
 * can exercise GET /social/feed in the app.
 *
 * Viewer selection:
 *   SOCIAL_SEED_VIEWER_EMAIL=<email>  (optional)
 *   else newest ACTIVE GOOGLE user
 *
 * Run:
 *   npx tsx prisma/seed-social-feed.ts
 *   npm run seed:social
 */
import 'dotenv/config';
import * as bcrypt from 'bcrypt';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import {
  AUTH_PROVIDER,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  PLACE_CATEGORY,
  PlaceStatus,
  PrismaClient,
  RECRUITMENT_ORIGIN,
  RECRUITMENT_STATE,
  SocialPostTopic,
  SocialPostVisibility,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_TYPE,
  TRIP_VISIBILITY,
  USER_ROLE,
  USER_STATUS,
} from '../src/generated/prisma/client';

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error('DATABASE_URL is not configured');
}

const pool = new Pool({ connectionString });
const prisma = new PrismaClient({ adapter: new PrismaPg(pool) });

const SEED_MARKER = '[social-seed]';
const TRIP_INVITE_CODE = 'SOCIALSEED01';

type DemoAuthor = {
  email: string;
  username: string;
  displayname: string;
  profileBadge: string | null;
  isVerified: boolean;
  bio: string;
};

const DEMO_AUTHORS: DemoAuthor[] = [
  {
    email: 'social.seed.lanphuong@example.com',
    username: 'social_lan_phuong',
    displayname: 'Lan Phương',
    profileBadge: 'Local Guide',
    isVerified: true,
    bio: 'Đà Nẵng foodie — seed author',
  },
  {
    email: 'social.seed.minhanh@example.com',
    username: 'social_minh_anh',
    displayname: 'Minh Anh',
    profileBadge: 'Photo Spotter',
    isVerified: true,
    bio: 'Góc sống ảo — seed author',
  },
  {
    email: 'social.seed.hoangnam@example.com',
    username: 'social_hoang_nam',
    displayname: 'Hoàng Nam',
    profileBadge: 'Trip Host',
    isVerified: false,
    bio: 'Tìm buddy & host trip — seed author',
  },
  {
    email: 'social.seed.thaotrang@example.com',
    username: 'social_thao_trang',
    displayname: 'Thảo Trang',
    profileBadge: null,
    isVerified: false,
    bio: 'Story LIVE — seed author',
  },
];

async function resolveViewer() {
  const email = process.env.SOCIAL_SEED_VIEWER_EMAIL?.trim();
  if (email) {
    const user = await prisma.user.findUnique({
      where: { email },
      select: {
        id: true,
        email: true,
        displayname: true,
        username: true,
        provider: true,
        avatarId: true,
      },
    });
    if (!user) {
      throw new Error(`SOCIAL_SEED_VIEWER_EMAIL not found: ${email}`);
    }
    return user;
  }

  const google = await prisma.user.findFirst({
    where: { provider: AUTH_PROVIDER.GOOGLE, status: USER_STATUS.ACTIVE },
    orderBy: { createdAt: 'desc' },
    select: {
      id: true,
      email: true,
      displayname: true,
      username: true,
      provider: true,
      avatarId: true,
    },
  });
  if (!google) {
    throw new Error(
      'No ACTIVE GOOGLE user found. Login with Google once, or set SOCIAL_SEED_VIEWER_EMAIL.',
    );
  }
  return google;
}

async function upsertDemoAuthor(author: DemoAuthor, passwordHash: string) {
  return prisma.user.upsert({
    where: { email: author.email },
    update: {
      displayname: author.displayname,
      username: author.username,
      status: USER_STATUS.ACTIVE,
      role: USER_ROLE.USER,
      provider: AUTH_PROVIDER.LOCAL,
      password: passwordHash,
      isVerified: author.isVerified,
      profileBadge: author.profileBadge,
      bio: author.bio,
      deletedAt: null,
    },
    create: {
      email: author.email,
      username: author.username,
      displayname: author.displayname,
      password: passwordHash,
      status: USER_STATUS.ACTIVE,
      role: USER_ROLE.USER,
      provider: AUTH_PROVIDER.LOCAL,
      isVerified: author.isVerified,
      profileBadge: author.profileBadge,
      bio: author.bio,
    },
    select: {
      id: true,
      email: true,
      username: true,
      displayname: true,
      avatarId: true,
    },
  });
}

async function ensureAvatar(
  userId: string,
  objectKey: string,
  currentAvatarId: string | null,
) {
  if (currentAvatarId) return currentAvatarId;

  const media = await prisma.uploadedMedia.upsert({
    where: { objectKey },
    update: { userId, deletedAt: null },
    create: {
      userId,
      objectKey,
      mimeType: 'image/jpeg',
    },
    select: { id: true },
  });

  await prisma.user.update({
    where: { id: userId },
    data: { avatarId: media.id },
  });
  return media.id;
}

async function ensureMedia(userId: string, objectKey: string) {
  return prisma.uploadedMedia.upsert({
    where: { objectKey },
    update: { userId, deletedAt: null },
    create: {
      userId,
      objectKey,
      mimeType: 'image/jpeg',
    },
    select: { id: true, objectKey: true },
  });
}

async function ensurePlace(input: {
  name: string;
  city: string;
  country: string;
  address: string;
  latitude: number;
  longitude: number;
  category: (typeof PLACE_CATEGORY)[keyof typeof PLACE_CATEGORY];
  createdByUserId: string;
}) {
  const existing = await prisma.place.findFirst({
    where: {
      name: input.name,
      city: input.city,
      country: input.country,
    },
  });
  if (existing) {
    return prisma.place.update({
      where: { id: existing.id },
      data: {
        status: PlaceStatus.APPROVED,
        latitude: input.latitude,
        longitude: input.longitude,
        address: input.address,
        category: input.category,
      },
    });
  }
  return prisma.place.create({
    data: {
      name: input.name,
      description: `${SEED_MARKER} place for social nearby/feed`,
      category: input.category,
      city: input.city,
      country: input.country,
      address: input.address,
      latitude: input.latitude,
      longitude: input.longitude,
      status: PlaceStatus.APPROVED,
      createdByUserId: input.createdByUserId,
    },
  });
}

async function clearPreviousSeedContent(authorIds: string[]) {
  const seededPosts = await prisma.post.findMany({
    where: {
      OR: [
        { caption: { contains: SEED_MARKER } },
        { authorId: { in: authorIds } },
      ],
    },
    select: { id: true },
  });
  const postIds = seededPosts.map((p) => p.id);
  if (postIds.length > 0) {
    await prisma.postMedia.deleteMany({ where: { postId: { in: postIds } } });
    await prisma.socialPostLike.deleteMany({
      where: { postId: { in: postIds } },
    });
    await prisma.socialPostComment.deleteMany({
      where: { postId: { in: postIds } },
    });
    await prisma.socialPostSave.deleteMany({
      where: { postId: { in: postIds } },
    });
    await prisma.socialPostShare.deleteMany({
      where: { postId: { in: postIds } },
    });
    await prisma.post.deleteMany({ where: { id: { in: postIds } } });
  }

  await prisma.socialStory.deleteMany({
    where: { authorId: { in: authorIds } },
  });
}

async function main() {
  console.log('');
  console.log('======================================');
  console.log('🌱 SOCIAL FEED E2E SEED');
  console.log('======================================');

  const viewer = await resolveViewer();
  console.log(`👁  Viewer: ${viewer.displayname} <${viewer.email}> (${viewer.id})`);

  const passwordHash = await bcrypt.hash('SocialSeed@123456', 10);
  const authors: Awaited<ReturnType<typeof upsertDemoAuthor>>[] = [];
  for (const demo of DEMO_AUTHORS) {
    const user = await upsertDemoAuthor(demo, passwordHash);
    authors.push(user);
    console.log(`✅ Author ready: ${user.displayname} <${user.email}>`);
  }

  const [lan, minh, nam, thao] = authors;

  // Unique seed keys only — never overwrite real Google/place objectKeys.
  await ensureAvatar(lan.id, `social-seed/avatars/${lan.id}.jpg`, lan.avatarId);
  await ensureAvatar(
    minh.id,
    `social-seed/avatars/${minh.id}.jpg`,
    minh.avatarId,
  );
  await ensureAvatar(nam.id, `social-seed/avatars/${nam.id}.jpg`, nam.avatarId);
  await ensureAvatar(
    thao.id,
    `social-seed/avatars/${thao.id}.jpg`,
    thao.avatarId,
  );

  // Prefer existing real S3 media rows for post/story images when present.
  const realMedia = await prisma.uploadedMedia.findMany({
    where: { deletedAt: null },
    take: 4,
    orderBy: { createdAt: 'asc' },
    select: { id: true },
  });
  const mediaIdOrCreate = async (
    userId: string,
    objectKey: string,
    index: number,
  ) => {
    if (realMedia[index]) return realMedia[index];
    return ensureMedia(userId, objectKey);
  };

  const postMediaA = await mediaIdOrCreate(
    lan.id,
    `social-seed/posts/lan-1.jpg`,
    1,
  );
  const postMediaB = await mediaIdOrCreate(
    lan.id,
    `social-seed/posts/lan-2.jpg`,
    2,
  );
  const postMediaC = await mediaIdOrCreate(
    minh.id,
    `social-seed/posts/minh-1.jpg`,
    0,
  );
  const storyMediaLan = await mediaIdOrCreate(
    lan.id,
    `social-seed/stories/lan.jpg`,
    1,
  );
  const storyMediaMinh = await mediaIdOrCreate(
    minh.id,
    `social-seed/stories/minh.jpg`,
    2,
  );
  const storyMediaThao = await mediaIdOrCreate(
    thao.id,
    `social-seed/stories/thao.jpg`,
    0,
  );
  const storyMediaNam = await mediaIdOrCreate(
    nam.id,
    `social-seed/stories/nam.jpg`,
    3,
  );

  const sonTraCafe = await ensurePlace({
    name: 'Cafe View Biển Sơn Trà',
    city: 'Đà Nẵng',
    country: 'Việt Nam',
    address: 'Sơn Trà, Đà Nẵng',
    latitude: 16.1065,
    longitude: 108.276,
    category: PLACE_CATEGORY.CAFE,
    createdByUserId: lan.id,
  });
  const myKhe = await ensurePlace({
    name: 'Bãi biển Mỹ Khê',
    city: 'Đà Nẵng',
    country: 'Việt Nam',
    address: 'Mỹ Khê, Sơn Trà, Đà Nẵng',
    latitude: 16.059,
    longitude: 108.245,
    category: PLACE_CATEGORY.BEACH,
    createdByUserId: minh.id,
  });
  const hoanKiem =
    (await prisma.place.findFirst({
      where: { name: 'Hồ Hoàn Kiếm', city: 'Hà Nội' },
    })) ??
    (await ensurePlace({
      name: 'Hồ Hoàn Kiếm',
      city: 'Hà Nội',
      country: 'Việt Nam',
      address: 'Hoàn Kiếm, Hà Nội',
      latitude: 21.028511,
      longitude: 105.852188,
      category: PLACE_CATEGORY.PARK,
      createdByUserId: nam.id,
    }));

  console.log('✅ Places ready (Đà Nẵng + Hà Nội)');

  await clearPreviousSeedContent(authors.map((a) => a.id));
  console.log('🧹 Cleared previous social-seed posts/stories');

  // Viewer follows demo authors → Following tab + story chrome
  for (const author of authors) {
    await prisma.userFollow.upsert({
      where: {
        followerId_followingId: {
          followerId: viewer.id,
          followingId: author.id,
        },
      },
      update: {},
      create: {
        followerId: viewer.id,
        followingId: author.id,
      },
    });
  }
  // One mutual follow so following badge > 0 feels real
  await prisma.userFollow.upsert({
    where: {
      followerId_followingId: {
        followerId: lan.id,
        followingId: viewer.id,
      },
    },
    update: {},
    create: {
      followerId: lan.id,
      followingId: viewer.id,
    },
  });
  console.log('✅ Follows ready');

  await prisma.userTravelStreak.upsert({
    where: { userId: viewer.id },
    update: {
      currentDays: 7,
      lastActiveDate: new Date(),
    },
    create: {
      userId: viewer.id,
      currentDays: 7,
      lastActiveDate: new Date(),
    },
  });
  console.log('✅ Viewer streak = 7 days');

  const unreadExists = await prisma.notification.findFirst({
    where: {
      userId: viewer.id,
      title: { contains: SEED_MARKER },
      isRead: false,
    },
  });
  if (!unreadExists) {
    await prisma.notification.create({
      data: {
        userId: viewer.id,
        actorId: lan.id,
        type: NOTIFICATION_TYPE.POST_LIKE,
        title: `${SEED_MARKER} Lan Phương đã thích bài viết của bạn`,
        message: 'Mở Bảng Tin để xem tương tác mới.',
        isRead: false,
      },
    });
  }
  console.log('✅ Unread notification ready');

  const challengeEnds = new Date();
  challengeEnds.setDate(challengeEnds.getDate() + 5);
  let challenge = await prisma.socialChallenge.findFirst({
    where: {
      isActive: true,
      title: 'Khám phá 3 Quán Cà Phê View Biển Sơn Trà',
    },
  });
  if (!challenge) {
    challenge = await prisma.socialChallenge.create({
      data: {
        eyebrow: 'THỬ THÁCH TUẦN NÀY',
        title: 'Khám phá 3 Quán Cà Phê View Biển Sơn Trà',
        rewardLabel: '+150 Xu',
        badgeLabel: '🌊 Nhận huy hiệu độc quyền: Biển Xanh 2025',
        targetCount: 3,
        endsAt: challengeEnds,
        isActive: true,
      },
    });
  } else {
    challenge = await prisma.socialChallenge.update({
      where: { id: challenge.id },
      data: { endsAt: challengeEnds, isActive: true },
    });
  }
  await prisma.socialChallengeProgress.upsert({
    where: {
      challengeId_userId: {
        challengeId: challenge.id,
        userId: viewer.id,
      },
    },
    update: { progressCount: 1 },
    create: {
      challengeId: challenge.id,
      userId: viewer.id,
      progressCount: 1,
    },
  });
  console.log(`✅ Challenge ready: ${challenge.id}`);

  const now = Date.now();
  const postLan = await prisma.post.create({
    data: {
      authorId: lan.id,
      placeId: sonTraCafe.id,
      caption: `${SEED_MARKER} Sáng nay ngồi view biển Sơn Trà, latte nóng + gió mặn — đúng bài chill trước khi đi phượt.`,
      visibility: SocialPostVisibility.PUBLIC,
      tipTitle: 'Mẹo săn ghế đẹp',
      tipBody: 'Đến trước 7:30, xin bàn gần lan can tầng 2.',
      topic: SocialPostTopic.HIDDEN_EATS,
      placeDetail: 'Tầng 2 · View biển',
      likesCount: 42,
      commentsCount: 1,
      savesCount: 8,
      createdAt: new Date(now - 2 * 60 * 60 * 1000),
      postMedias: {
        create: [
          { mediaId: postMediaA.id, orderIndex: 0 },
          { mediaId: postMediaB.id, orderIndex: 1 },
        ],
      },
      comments: {
        create: [
          {
            userId: minh.id,
            content: 'View này quá đỉnh, tối nay mình cũng qua!',
          },
        ],
      },
    },
  });

  const postMinh = await prisma.post.create({
    data: {
      authorId: minh.id,
      placeId: myKhe.id,
      caption: `${SEED_MARKER} Golden hour Mỹ Khê — góc này luôn full slot sống ảo.`,
      visibility: SocialPostVisibility.PUBLIC,
      tipTitle: 'Góc máy đẹp',
      tipBody: 'Đứng gần hàng dừa thứ 3 từ lối xuống biển.',
      topic: SocialPostTopic.PHOTO_SPOTS,
      placeDetail: 'Hoàng hôn · Mỹ Khê',
      likesCount: 88,
      commentsCount: 0,
      savesCount: 21,
      createdAt: new Date(now - 5 * 60 * 60 * 1000),
      postMedias: {
        create: [{ mediaId: postMediaC.id, orderIndex: 0 }],
      },
    },
  });

  const postNam = await prisma.post.create({
    data: {
      authorId: nam.id,
      placeId: hoanKiem.id,
      caption: `${SEED_MARKER} Ai rảnh cuối tuần đi Hà Nội 2N1Đ cùng mình không? Cần 2 buddy thân thiện.`,
      visibility: SocialPostVisibility.PUBLIC,
      tipTitle: 'Lịch gợi ý',
      tipBody: 'Ngày 1 phố cổ · Ngày 2 Tây Hồ + cà phê.',
      topic: SocialPostTopic.FIND_BUDDY,
      placeDetail: 'Xuất phát Hồ Gươm',
      likesCount: 15,
      commentsCount: 0,
      savesCount: 4,
      createdAt: new Date(now - 26 * 60 * 60 * 1000),
    },
  });

  const postFollowersOnly = await prisma.post.create({
    data: {
      authorId: lan.id,
      placeId: sonTraCafe.id,
      caption: `${SEED_MARKER} (FOLLOWERS) Spot bí mật chỉ chia với người theo dõi — thử tab Đang theo dõi.`,
      visibility: SocialPostVisibility.FOLLOWERS,
      tipTitle: 'Hidden alley',
      tipBody: 'Rẽ trái sau chợ Sơn Trà 50m.',
      topic: SocialPostTopic.ITINERARY_2N1D,
      likesCount: 6,
      commentsCount: 0,
      savesCount: 2,
      createdAt: new Date(now - 90 * 60 * 1000),
    },
  });

  // Viewer liked/saved one post for optimistic-toggle E2E
  await prisma.socialPostLike.create({
    data: { postId: postLan.id, userId: viewer.id },
  });
  await prisma.socialPostSave.create({
    data: { postId: postMinh.id, userId: viewer.id },
  });
  console.log('✅ Posts ready:', {
    postLan: postLan.id,
    postMinh: postMinh.id,
    postNam: postNam.id,
    postFollowersOnly: postFollowersOnly.id,
  });

  const expiresAt = new Date();
  expiresAt.setHours(expiresAt.getHours() + 20);
  await prisma.socialStory.createMany({
    data: [
      {
        authorId: lan.id,
        mediaId: storyMediaLan.id,
        label: 'Lan Phương',
        isLive: false,
        expiresAt,
      },
      {
        authorId: minh.id,
        mediaId: storyMediaMinh.id,
        label: 'Minh Anh',
        isLive: false,
        expiresAt,
      },
      {
        authorId: thao.id,
        mediaId: storyMediaThao.id,
        label: 'Thảo Trang',
        isLive: true,
        expiresAt,
      },
      {
        authorId: nam.id,
        mediaId: storyMediaNam.id,
        label: 'Hoàng Nam',
        isLive: false,
        expiresAt,
      },
    ],
  });
  console.log('✅ Stories ready (incl. LIVE)');

  // Recruiting trip owned by Nam (not viewer) so TRIP_RECRUIT appears
  const startDate = new Date();
  startDate.setDate(startDate.getDate() + 10);
  startDate.setHours(5, 0, 0, 0);
  const endDate = new Date(startDate);
  endDate.setDate(endDate.getDate() + 3);
  const recruitExpires = new Date();
  recruitExpires.setDate(recruitExpires.getDate() + 7);

  const existingTrip = await prisma.trip.findFirst({
    where: { inviteCode: TRIP_INVITE_CODE },
    select: { id: true },
  });
  if (existingTrip) {
    await prisma.tripRecruitment.deleteMany({
      where: { tripId: existingTrip.id },
    });
    await prisma.tripDestination.deleteMany({
      where: { tripId: existingTrip.id },
    });
    await prisma.tripMember.deleteMany({ where: { tripId: existingTrip.id } });
    await prisma.trip.delete({ where: { id: existingTrip.id } });
  }

  const trip = await prisma.trip.create({
    data: {
      ownerId: nam.id,
      name: 'Đà Nẵng · Hội An 3N2Đ',
      description: `${SEED_MARKER} Chuyến cộng đồng đang tuyển thêm bạn đồng hành.`,
      startDate,
      endDate,
      maxMembers: 6,
      inviteCode: TRIP_INVITE_CODE,
      tripType: TRIP_TYPE.FRIENDS,
      visibility: TRIP_VISIBILITY.PUBLIC,
      status: TRIP_STATUS.UPCOMING,
      estimatedBudgetPerPerson: 2500000,
      budgetCurrency: 'VND',
      destinations: {
        create: [
          {
            city: 'Đà Nẵng',
            country: 'Việt Nam',
            lat: 16.054407,
            lng: 108.202164,
            order: 1,
            startDate,
            endDate: new Date(startDate.getTime() + 2 * 86_400_000),
          },
          {
            city: 'Hội An',
            country: 'Việt Nam',
            lat: 15.8801,
            lng: 108.338,
            order: 2,
            startDate: new Date(startDate.getTime() + 2 * 86_400_000),
            endDate,
          },
        ],
      },
      members: {
        create: [
          {
            userId: nam.id,
            role: TRIP_ROLE.OWNER,
            status: MEMBER_STATUS.ACTIVE,
          },
          {
            userId: lan.id,
            role: TRIP_ROLE.MEMBER,
            status: MEMBER_STATUS.ACTIVE,
          },
          {
            userId: minh.id,
            role: TRIP_ROLE.MEMBER,
            status: MEMBER_STATUS.ACTIVE,
          },
        ],
      },
      recruitment: {
        create: {
          state: RECRUITMENT_STATE.OPEN,
          requirements:
            'Thích ăn uống, chịu đi sớm săn bình minh Mỹ Khê. Budget ~2.5tr/người.',
          estimatedBudgetPerPerson: 2500000,
          publishedAt: new Date(),
          expiresAt: recruitExpires,
          urgent: true,
          origin: RECRUITMENT_ORIGIN.EXISTING_TRIP,
          previousVisibility: TRIP_VISIBILITY.PUBLIC,
        },
      },
    },
    select: { id: true, name: true },
  });
  console.log(`✅ Recruiting trip ready: ${trip.name} (${trip.id})`);

  console.log('');
  console.log('==============================');
  console.log('Social feed seed completed');
  console.log(`Viewer email: ${viewer.email}`);
  console.log('Demo LOCAL logins (optional, not Google):');
  for (const a of DEMO_AUTHORS) {
    console.log(`  ${a.email} / SocialSeed@123456`);
  }
  console.log('Open app tab Social → pull to refresh');
  console.log('==============================');
}

main()
  .catch((error) => {
    console.error('❌ Social feed seed failed');
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });
