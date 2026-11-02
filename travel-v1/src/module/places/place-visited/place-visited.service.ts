import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../prisma.service';

@Injectable()
export class PlaceVisitedService {
  constructor(private readonly prisma: PrismaService) {}
  async visitPlace(checkinId: string) {
    const checkin = await this.prisma.tripCheckin.findUnique({
      where: {
        id: checkinId,
      },
      select: {
        userId: true,
        placeId: true,
      },
    });
    if (!checkin) {
      throw new Error('Checkin not found');
    }
    const place = await this.prisma.place.findUnique({
      where: {
        id: checkin.placeId,
      },
      select: {
        id: true,
      },
    });
    if (!place) {
      throw new Error('Place not found');
    }
    await this.prisma.placeVisit.upsert({
      where: {
        userId_placeId: {
          userId: checkin.userId,
          placeId: checkin.placeId,
        },
      },
      update: {},
      create: {
        userId: checkin.userId,
        placeId: checkin.placeId,
      },
    });
    return { message: 'Place visited successfully' };
  }
}
