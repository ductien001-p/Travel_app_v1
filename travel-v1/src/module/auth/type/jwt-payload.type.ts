import { USER_ROLE } from '../../../generated/prisma/enums';

export interface JwtPayload {
  sub: string;
  email: string;
  role: USER_ROLE;
  type: 'access' | 'refresh';
  jti?: string;
  iat?: number;
  exp?: number;
}
