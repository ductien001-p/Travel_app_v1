import { Injectable } from '@nestjs/common';
import * as nodemailer from 'nodemailer';

@Injectable()
export class MailService {
  private readonly transporter: nodemailer.Transporter;

  constructor() {
    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.MAIL_USER,
        pass: process.env.MAIL_PASSWORD,
      },
    });
  }

  async sendVerificationCode(email: string, code: string) {
    await this.transporter.sendMail({
      from: 'AppTravel',
      to: email,
      subject: 'Verify your account',
      text: `Your verification code is: ${code}`,
      html: `
      <h2>Welcome to AppTravel</h2>

      <p>Your verification code is:</p>

      <h1>${code}</h1>

      <p>This code will expire in 5 minutes.</p>
    `,
    });
  }
}
