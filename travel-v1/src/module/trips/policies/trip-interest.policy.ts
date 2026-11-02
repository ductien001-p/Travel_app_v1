import { BadRequestException } from '@nestjs/common';
import { Prisma } from '../../../generated/prisma/client';

export class TripInterestPolicy {
  static async validateIds(
    reader: Pick<Prisma.TransactionClient, 'interest'>,
    inputInterestIds: string[],
  ): Promise<string[]> {
    const interestIds = [...new Set(inputInterestIds)];
    if (interestIds.length === 0) return [];

    const validInterests = await reader.interest.findMany({
      where: { id: { in: interestIds } },
      select: { id: true },
    });
    if (validInterests.length !== interestIds.length) {
      const validIds = new Set(validInterests.map((interest) => interest.id));
      throw new BadRequestException({
        message: 'One or more interestIds are invalid',
        invalidInterestIds: interestIds.filter((id) => !validIds.has(id)),
      });
    }
    return interestIds;
  }
}
