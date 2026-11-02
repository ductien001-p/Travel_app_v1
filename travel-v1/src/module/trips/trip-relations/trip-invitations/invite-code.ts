import { customAlphabet } from 'nanoid';

/** Unambiguous characters only (no 0/O, 1/I/L), so codes can be read aloud. */
export const generateInviteCode = customAlphabet(
  'ABCDEFGHJKLMNPQRSTUVWXYZ23456789',
  8,
);
