-- Publisher opt-in. Existing posts stay non-urgent.
ALTER TABLE "trip_recruitments" ADD COLUMN "urgent" BOOLEAN NOT NULL DEFAULT false;
