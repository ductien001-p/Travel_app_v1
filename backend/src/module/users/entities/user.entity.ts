import { USER_ROLE, USER_STATUS } from '../../../generated/prisma/enums';

export class User {
  id: string;
  username: string;
  email: string;
  phone: string;
  avatarId: string;
  gender: string;
  dateOfBirth: Date;
  address: string;
  bio: string;
  location: string;
  status: USER_STATUS;
  role: USER_ROLE;
  deletedAt: Date | null;
  createdAt: Date;
  updatedAt: Date;

  constructor() {
    this.id = '';
    this.username = '';
    this.email = '';
    this.phone = '';
    this.avatarId = '';
    this.gender = '';
    this.dateOfBirth = new Date();
    this.address = '';
    this.bio = '';
    this.location = '';
    this.status = USER_STATUS.ACTIVE;
    this.role = USER_ROLE.USER;
    this.deletedAt = null;
    this.createdAt = new Date();
    this.updatedAt = new Date();
  }
}
