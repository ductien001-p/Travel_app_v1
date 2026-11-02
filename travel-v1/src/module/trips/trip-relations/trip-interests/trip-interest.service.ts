import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { SetTripInterestsDto } from './dto/setTripInterest.dto';
import { TripAccessPolicy, TripInterestPolicy } from '../../policies';
import { PrismaService } from '../../../../prisma.service';
import { CreateInterestDto } from './dto/creatInterest.dto';
import { UpdateInterestDto } from './dto/updateInterest.dto';
import { Prisma } from '../../../../generated/prisma/client';

function rethrowDuplicateName(error: unknown, name: string): never {
  if (
    error instanceof Prisma.PrismaClientKnownRequestError &&
    error.code === 'P2002'
  ) {
    throw new ConflictException(`Interest with name "${name}" already exists`);
  }
  throw error;
}

@Injectable()
export class TripInterestService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * API:
   * PUT/PATCH /trips/:tripId/interests
   *
   * Dùng khi Trip đã tồn tại và user muốn thay đổi interests.
   */
  async setTripInterests(
    tripId: string,
    dto: SetTripInterestsDto,
    userId: string,
  ) {
    // Check quyền ở public service method
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_INTERESTS',
    );

    return this.prisma.$transaction(async (tx) => {
      return this.replaceTripInterests(tx, tripId, dto.interestIds);
    });
  }

  /**
   * Hàm dùng nội bộ.
   *
   * Có thể được createTrip/updateTrip gọi trong transaction hiện tại.
   */
  async replaceTripInterests(
    tx: Prisma.TransactionClient,
    tripId: string,
    inputInterestIds: string[],
  ) {
    const interestIds = [...new Set(inputInterestIds)];

    /*
     * Validate interests tồn tại
     */
    await TripInterestPolicy.validateIds(tx, interestIds);

    /*
     * Xóa relations cũ
     */
    await tx.tripInterest.deleteMany({
      where: {
        tripId,
      },
    });

    /*
     * Tạo relations mới
     */
    if (interestIds.length > 0) {
      await tx.tripInterest.createMany({
        data: interestIds.map((interestId) => ({
          tripId,
          interestId,
        })),

        skipDuplicates: true,
      });
    }

    /*
     * Trả Interest[] thay vì TripInterest[]
     */
    return tx.interest.findMany({
      where: {
        id: {
          in: interestIds,
        },
      },

      orderBy: {
        name: 'asc',
      },
    });
  }

  // =============================
  // INTEREST MASTER DATA
  // =============================

  // GET /interests
  async findAll() {
    return this.prisma.interest.findMany({
      orderBy: {
        name: 'asc',
      },
    });
  }

  async findOneOrThrow(id: string) {
    const interest = await this.prisma.interest.findUnique({
      where: {
        id,
      },
    });

    if (!interest) {
      throw new NotFoundException(`Interest with id ${id} not found`);
    }

    return interest;
  }

  // POST /interests — ADMIN
  async create(dto: CreateInterestDto) {
    // The DTO already trims; trimming again guards internal callers.
    const name = dto.name.trim();
    if (!name) {
      throw new BadRequestException('Interest name is required');
    }

    try {
      return await this.prisma.interest.create({ data: { name } });
    } catch (error) {
      rethrowDuplicateName(error, name);
    }
  }

  // PATCH /interests/:id — ADMIN
  async update(id: string, dto: UpdateInterestDto) {
    const interest = await this.findOneOrThrow(id);

    if (dto.name === undefined) {
      return interest;
    }

    const name = dto.name.trim();
    if (!name) {
      throw new BadRequestException('Interest name is required');
    }

    try {
      return await this.prisma.interest.update({
        where: { id },
        data: { name },
      });
    } catch (error) {
      rethrowDuplicateName(error, name);
    }
  }

  // DELETE /interests/:id — ADMIN
  async remove(id: string) {
    await this.findOneOrThrow(id);

    await this.prisma.interest.delete({
      where: {
        id,
      },
    });

    return {
      success: true,
    };
  }
}
