import { IsEmail, IsNotEmpty } from 'class-validator';

export class SendVerifyEmailDto {
  @IsEmail()
  @IsNotEmpty()
  email!: string;
}

export class VerifyEmailDto {
  @IsNotEmpty()
  token!: string;

  @IsEmail()
  @IsNotEmpty()
  email!: string;
}
