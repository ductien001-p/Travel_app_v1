import 'reflect-metadata';
import { BadRequestException, ConflictException } from '@nestjs/common';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { Prisma } from '../../../../generated/prisma/client';
import { TripInterestService } from './trip-interest.service';
import { CreateInterestDto } from './dto/creatInterest.dto';
import { UpdateInterestDto } from './dto/updateInterest.dto';

describe('Interest DTOs', () => {
  it('trims the name on create', async () => {
    const dto = plainToInstance(CreateInterestDto, { name: '  Beach  ' });
    expect(await validate(dto)).toHaveLength(0);
    expect(dto.name).toBe('Beach');
  });

  it.each([CreateInterestDto, UpdateInterestDto])(
    '%p rejects a whitespace-only name',
    async (Dto) => {
      const errors = await validate(plainToInstance(Dto, { name: '   ' }));
      expect(errors.map((error) => error.property)).toContain('name');
    },
  );

  it('rejects null on update but allows omitting the name', async () => {
    expect(
      await validate(plainToInstance(UpdateInterestDto, { name: null })),
    ).toHaveLength(1);
    expect(await validate(plainToInstance(UpdateInterestDto, {}))).toHaveLength(
      0,
    );
  });
});

describe('TripInterestService master data', () => {
  const duplicate = new Prisma.PrismaClientKnownRequestError('duplicate', {
    code: 'P2002',
    clientVersion: 'test',
  });

  function setup() {
    const prisma = {
      interest: {
        findUnique: jest.fn().mockResolvedValue({ id: 'i1', name: 'Beach' }),
        create: jest.fn().mockResolvedValue({ id: 'i2', name: 'Food' }),
        update: jest.fn().mockResolvedValue({ id: 'i1', name: 'Sea' }),
      },
    };
    return { service: new TripInterestService(prisma as never), prisma };
  }

  it('maps a concurrent duplicate name on create to 409', async () => {
    const { service, prisma } = setup();
    prisma.interest.create.mockRejectedValue(duplicate);

    await expect(service.create({ name: 'Food' })).rejects.toBeInstanceOf(
      ConflictException,
    );
  });

  it('maps a duplicate name on update to 409', async () => {
    const { service, prisma } = setup();
    prisma.interest.update.mockRejectedValue(duplicate);

    await expect(service.update('i1', { name: 'Food' })).rejects.toBeInstanceOf(
      ConflictException,
    );
  });

  it('never writes an empty name', async () => {
    const { service, prisma } = setup();

    await expect(service.update('i1', { name: '   ' })).rejects.toBeInstanceOf(
      BadRequestException,
    );
    expect(prisma.interest.update).not.toHaveBeenCalled();
  });

  it('returns the interest unchanged when no name is given', async () => {
    const { service, prisma } = setup();

    await expect(service.update('i1', {})).resolves.toEqual({
      id: 'i1',
      name: 'Beach',
    });
    expect(prisma.interest.update).not.toHaveBeenCalled();
  });
});
