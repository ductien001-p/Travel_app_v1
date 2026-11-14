import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from '../../../decoration/role.decoriation';
import { USER_ROLE } from '../../../generated/prisma/enums';
import { UsersController } from '../../users/users.controller';
import { RolesGuard } from './roles.guard';

describe('RolesGuard POST /users/create', () => {
  const reflector = new Reflector();

  function contextFor(role: string) {
    return {
      getHandler: () => UsersController.prototype.create,
      getClass: () => UsersController,
      switchToHttp: () => ({
        getRequest: () => ({ user: { role } }),
      }),
    } as never;
  }

  it('allows only ADMIN through the create-user route', () => {
    const guard = new RolesGuard(reflector);

    expect(guard.canActivate(contextFor(USER_ROLE.USER))).toBe(false);
    expect(guard.canActivate(contextFor(USER_ROLE.HOST))).toBe(false);
    expect(guard.canActivate(contextFor(USER_ROLE.ADMIN))).toBe(true);
    expect(reflector.get(ROLES_KEY, UsersController.prototype.create)).toEqual([
      USER_ROLE.ADMIN,
    ]);
  });
});
