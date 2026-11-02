/*
  Warnings:

  - A unique constraint covering the columns `[objectKey]` on the table `UploadedMedia` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "UploadedMedia_objectKey_key" ON "UploadedMedia"("objectKey");
