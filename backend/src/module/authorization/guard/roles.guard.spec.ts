import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from '../../../decoration/role.decoriation';
import { USER_ROLE } from '../../../generated/prisma/enums';
import { PlacesController } from '../../places/places.controller';
import { RolesGuard } from './roles.guard';

describe('RolesGuard POST /places/admin/create', () => {
  const reflector = new Reflector();

  function contextFor(role: string) {
    return {
      getHandler: () => PlacesController.prototype.createByAdmin,
      getClass: () => PlacesController,
      switchToHttp: () => ({
        getRequest: () => ({ user: { role } }),
      }),
    } as never;
  }

  it('allows only ADMIN through the admin place route', () => {
    const guard = new RolesGuard(reflector);

    expect(guard.canActivate(contextFor(USER_ROLE.USER))).toBe(false);
    expect(guard.canActivate(contextFor(USER_ROLE.HOST))).toBe(false);
    expect(guard.canActivate(contextFor(USER_ROLE.ADMIN))).toBe(true);
    expect(
      reflector.get(ROLES_KEY, PlacesController.prototype.createByAdmin),
    ).toEqual([USER_ROLE.ADMIN]);
  });
});
