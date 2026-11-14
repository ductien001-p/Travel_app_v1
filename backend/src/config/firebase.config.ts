// src/config/firebase.config.ts
import * as admin from 'firebase-admin';
import { cert, getApps } from 'firebase-admin';

export function initFirebaseAdmin() {
  const existingApps = getApps();
  if (existingApps.length > 0) {
    return existingApps[0];
  }

  return admin.initializeApp({
    credential: cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      // private key trong .env thường bị escape \n, cần replace lại
      privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n'),
    }),
  });
}
