import { Injectable, UnauthorizedException } from '@nestjs/common';

import { OAuth2Client } from 'google-auth-library';

import { ConfigService } from '@nestjs/config';
import { GoogleIdentity } from './type/google-identity.type';

@Injectable()
export class GoogleTokenVerifierService {
  private readonly client = new OAuth2Client();

  private readonly webClientId: string;

  constructor(private readonly configService: ConfigService) {
    this.webClientId = this.configService.getOrThrow<string>(
      'GOOGLE_WEB_CLIENT_ID',
    );
  }

  async verify(idToken: string): Promise<GoogleIdentity> {
    try {
      const ticket = await this.client.verifyIdToken({
        idToken,
        audience: this.webClientId,
      });

      const payload = ticket.getPayload();

      if (!payload) {
        throw new UnauthorizedException('Invalid Google ID token');
      }

      const googleId = payload.sub;

      const email = payload.email;

      const emailVerified = payload.email_verified;

      if (!googleId) {
        throw new UnauthorizedException('Google account identifier is missing');
      }

      if (!email) {
        throw new UnauthorizedException('Google email is missing');
      }

      if (!emailVerified) {
        throw new UnauthorizedException('Google email is not verified');
      }

      return {
        googleId,
        email: email.toLowerCase(),

        emailVerified: true,

        name: payload.name,

        picture: payload.picture,
      };
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }

      throw new UnauthorizedException('Invalid or expired Google ID token');
    }
  }
}
