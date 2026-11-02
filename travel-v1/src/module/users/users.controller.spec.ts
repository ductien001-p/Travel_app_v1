import { Test } from '@nestjs/testing';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
import { ProfileShowcaseService } from './profile-showcase.service';

describe('UsersController', () => {
  const usersService = {
    findOne: jest.fn(),
  };
  const profileShowcaseService = {
    getShowcase: jest.fn(),
  };

  async function controller() {
    const moduleRef = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [
        { provide: UsersService, useValue: usersService },
        { provide: ProfileShowcaseService, useValue: profileShowcaseService },
      ],
    }).compile();
    return moduleRef.get(UsersController);
  }

  it('returns the current-user envelope', async () => {
    const users = await controller();
    usersService.findOne.mockResolvedValue({ id: 'user-1', visitedCount: 0 });
    await expect(users.findMe('user-1')).resolves.toEqual({
      data: { id: 'user-1', visitedCount: 0 },
      message: 'User retrieved successfully',
    });
  });

  it('returns the profile showcase envelope for the current user', async () => {
    const users = await controller();
    profileShowcaseService.getShowcase.mockResolvedValue({
      hostStatus: 'NONE',
    });
    await expect(users.getShowcase('user-1')).resolves.toEqual({
      data: { hostStatus: 'NONE' },
      message: 'Profile showcase retrieved successfully',
    });
    expect(profileShowcaseService.getShowcase).toHaveBeenCalledWith('user-1');
  });
});
