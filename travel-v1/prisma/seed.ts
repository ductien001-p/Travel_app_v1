// import { PrismaPg } from '@prisma/adapter-pg';
// import { Pool } from 'pg';
// import 'dotenv/config';
// import { PrismaClient } from '../src/generated/prisma/client';

// const connectionString = process.env.DATABASE_URL;

// if (!connectionString) {
//   throw new Error('DATABASE_URL is not configured');
// }

// const pool = new Pool({
//   connectionString,
// });

// const adapter = new PrismaPg(pool);

// const prisma = new PrismaClient({
//   adapter,
// });

// const interests = [
//   'Bãi biển & Đảo',
//   'Ẩm thực địa phương',
//   'Chụp ảnh & Check-in',
//   'Thiên nhiên',
//   'Núi & Trekking',
//   'Văn hóa & Lịch sử',
//   'Phiêu lưu',
//   'Cuộc sống về đêm',
//   'Mua sắm',
//   'Nghỉ dưỡng',
//   'Trải nghiệm địa phương',
//   'Gia đình',
// ];

// async function main() {
//   console.log('🌱 Seeding interests...');

//   for (const name of interests) {
//     const existing = await prisma.interest.findFirst({
//       where: {
//         name,
//       },
//     });

//     if (existing) {
//       console.log(`⏭️  Already exists: ${name}`);
//       continue;
//     }

//     const interest = await prisma.interest.create({
//       data: {
//         name,
//       },
//     });

//     console.log(`✅ Created: ${interest.name}`);
//   }

//   const count = await prisma.interest.count();

//   console.log('');
//   console.log('==============================');
//   console.log('Interest seed completed');
//   console.log(`Total interests: ${count}`);
//   console.log('==============================');
// }

// main()
//   .catch((error) => {
//     console.error('❌ Interest seed failed');
//     console.error(error);

//     process.exitCode = 1;
//   })
//   .finally(async () => {
//     await prisma.$disconnect();
//     await pool.end();
//   });

import 'dotenv/config';
import * as bcrypt from 'bcrypt';

import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';

import {
  PrismaClient,
  USER_ROLE,
  USER_STATUS,
  AUTH_PROVIDER,
  PlaceStatus,
  PLACE_CATEGORY,
} from '../src/generated/prisma/client';

// =========================================================
// DATABASE CONFIG
// =========================================================

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error('DATABASE_URL is not defined');
}

const pool = new Pool({
  connectionString,
});

const adapter = new PrismaPg(pool);

const prisma = new PrismaClient({
  adapter,
});

// =========================================================
// MAIN SEED
// =========================================================

async function main() {
  console.log('');
  console.log('======================================');
  console.log('🌱 START DATABASE SEED');
  console.log('======================================');
  console.log('');

  // =======================================================
  // 1. CREATE ADMIN
  // =======================================================

  const adminEmail = 'admin@example.com';
  const adminPassword = 'Admin@123456';

  const hashedPassword = await bcrypt.hash(adminPassword, 10);

  const admin = await prisma.user.upsert({
    where: {
      email: adminEmail,
    },

    update: {
      displayname: 'Administrator',
      username: 'admin',

      role: USER_ROLE.ADMIN,

      status: USER_STATUS.ACTIVE,

      provider: AUTH_PROVIDER.LOCAL,
    },

    create: {
      email: adminEmail,

      password: hashedPassword,

      displayname: 'Administrator',

      username: 'admin',

      role: USER_ROLE.ADMIN,

      status: USER_STATUS.ACTIVE,

      provider: AUTH_PROVIDER.LOCAL,
    },

    select: {
      id: true,
      email: true,
      displayname: true,
      username: true,
      role: true,
      status: true,
    },
  });

  console.log('✅ Admin ready');
  console.log(`   ID: ${admin.id}`);
  console.log(`   Email: ${admin.email}`);

  // =======================================================
  // 2. DESTINATION CATALOG - HÀ NỘI
  // =======================================================

  const hanoiDestination = await prisma.destinationCatalog.upsert({
    where: {
      name_country: {
        name: 'Hà Nội',
        country: 'Việt Nam',
      },
    },

    update: {
      lat: 21.028511,
      lng: 105.804817,

      type: 'CITY',

      highlights: ['Hồ Hoàn Kiếm', 'Phố cổ Hà Nội', 'Văn Miếu - Quốc Tử Giám'],

      isActive: true,
    },

    create: {
      name: 'Hà Nội',

      country: 'Việt Nam',

      lat: 21.028511,
      lng: 105.804817,

      type: 'CITY',

      highlights: ['Hồ Hoàn Kiếm', 'Phố cổ Hà Nội', 'Văn Miếu - Quốc Tử Giám'],

      isActive: true,
    },
  });

  console.log('');
  console.log('✅ DestinationCatalog ready');
  console.log(`   ${hanoiDestination.name}`);
  console.log(`   ID: ${hanoiDestination.id}`);

  // =======================================================
  // 3. DESTINATION CATALOG - ĐÀ NẴNG
  // =======================================================

  const danangDestination = await prisma.destinationCatalog.upsert({
    where: {
      name_country: {
        name: 'Đà Nẵng',
        country: 'Việt Nam',
      },
    },

    update: {
      lat: 16.054407,
      lng: 108.202164,

      type: 'CITY',

      highlights: ['Bãi biển Mỹ Khê', 'Cầu Rồng', 'Bà Nà Hills'],

      isActive: true,
    },

    create: {
      name: 'Đà Nẵng',

      country: 'Việt Nam',

      lat: 16.054407,
      lng: 108.202164,

      type: 'CITY',

      highlights: ['Bãi biển Mỹ Khê', 'Cầu Rồng', 'Bà Nà Hills'],

      isActive: true,
    },
  });

  console.log('');
  console.log('✅ DestinationCatalog ready');
  console.log(`   ${danangDestination.name}`);
  console.log(`   ID: ${danangDestination.id}`);

  // =======================================================
  // 4. PLACE - HỒ HOÀN KIẾM
  // =======================================================

  let hoanKiemPlace = await prisma.place.findFirst({
    where: {
      name: 'Hồ Hoàn Kiếm',
      city: 'Hà Nội',
      country: 'Việt Nam',
    },
  });

  if (!hoanKiemPlace) {
    hoanKiemPlace = await prisma.place.create({
      data: {
        name: 'Hồ Hoàn Kiếm',

        category: PLACE_CATEGORY.BEACH,

        city: 'Hà Nội',

        country: 'Việt Nam',

        address: 'Hồ Hoàn Kiếm, Hoàn Kiếm, Hà Nội, Việt Nam',

        latitude: 21.028511,
        longitude: 105.852188,

        status: PlaceStatus.APPROVED,

        createdByUserId: admin.id,
      },
    });

    console.log('');
    console.log('✅ Created Place');
    console.log(`   ${hoanKiemPlace.name}`);
  } else {
    console.log('');
    console.log('ℹ️ Place already exists');
    console.log(`   ${hoanKiemPlace.name}`);
  }

  // =======================================================
  // 5. PLACE - VĂN MIẾU QUỐC TỬ GIÁM
  // =======================================================

  let vanMieuPlace = await prisma.place.findFirst({
    where: {
      name: 'Văn Miếu - Quốc Tử Giám',
      city: 'Hà Nội',
      country: 'Việt Nam',
    },
  });

  if (!vanMieuPlace) {
    vanMieuPlace = await prisma.place.create({
      data: {
        name: 'Văn Miếu - Quốc Tử Giám',

        category: PLACE_CATEGORY.CASTLE,

        city: 'Hà Nội',

        country: 'Việt Nam',

        address: '58 Quốc Tử Giám, Đống Đa, Hà Nội, Việt Nam',

        latitude: 21.027653,
        longitude: 105.835432,

        status: PlaceStatus.APPROVED,

        createdByUserId: admin.id,
      },
    });

    console.log('');
    console.log('✅ Created Place');
    console.log(`   ${vanMieuPlace.name}`);
  } else {
    console.log('');
    console.log('ℹ️ Place already exists');
    console.log(`   ${vanMieuPlace.name}`);
  }

  // =======================================================
  // 6. RESULT
  // =======================================================

  console.log('');
  console.log('======================================');
  console.log('🌱 SEED COMPLETED');
  console.log('======================================');

  console.log('');
  console.log('ADMIN');
  console.log('--------------------------------------');

  console.log(`Email:    ${adminEmail}`);
  console.log(`Password: ${adminPassword}`);
  console.log(`ID:       ${admin.id}`);

  console.log('');
  console.log('DESTINATIONS');
  console.log('--------------------------------------');

  console.log(`${hanoiDestination.name} -> ${hanoiDestination.id}`);

  console.log(`${danangDestination.name} -> ${danangDestination.id}`);

  console.log('');
  console.log('PLACES');
  console.log('--------------------------------------');

  console.log(`${hoanKiemPlace.name} -> ${hoanKiemPlace.id}`);

  console.log(`${vanMieuPlace.name} -> ${vanMieuPlace.id}`);

  console.log('');
}

// =========================================================
// RUN SEED
// =========================================================

main()
  .catch((error) => {
    console.error('');
    console.error('❌ DATABASE SEED FAILED');
    console.error(error);

    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });
