import { USER_ROLE } from '../../../generated/prisma/browser';

export interface AuthUser {
  id: string;
  email: string;
  role: USER_ROLE;
}
