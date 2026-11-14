import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { AuthUser } from '../module/auth/type/auth-user.type';

export const CurrentUser = createParamDecorator(
  (data: keyof AuthUser, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    return request.user[data];
  },
);
