/*
  Warnings:

  - You are about to drop the column `userId` on the `TripCompletion` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `TripExpense` table. All the data in the column will be lost.
  - The `currency` column on the `TripExpense` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `category` to the `TripExpense` table without a default value. This is not possible if the table is not empty.
  - Added the required column `splitType` to the `TripExpense` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "CURRENCY" AS ENUM ('VND', 'USD');

-- CreateEnum
CREATE TYPE "EXPENSE_SPLIT_TYPE" AS ENUM ('EQUAL', 'INDIVIDUAL', 'CUSTOM');

-- DropForeignKey
ALTER TABLE "TripCompletion" DROP CONSTRAINT "TripCompletion_userId_fkey";

-- DropForeignKey
ALTER TABLE "TripExpense" DROP CONSTRAINT "TripExpense_userId_fkey";

-- AlterTable
ALTER TABLE "TripCompletion" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "TripExpense" DROP COLUMN "userId",
ADD COLUMN     "category" "EXPENSE_CATEGORY" NOT NULL,
ADD COLUMN     "splitType" "EXPENSE_SPLIT_TYPE" NOT NULL,
DROP COLUMN "currency",
ADD COLUMN     "currency" "CURRENCY" NOT NULL DEFAULT 'VND';

-- CreateTable
CREATE TABLE "TripExpenseSplit" (
    "id" TEXT NOT NULL,
    "expenseId" TEXT NOT NULL,
    "tripMemberId" TEXT NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "isSettled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "TripExpenseSplit_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TripExpenseSplit_expenseId_tripMemberId_key" ON "TripExpenseSplit"("expenseId", "tripMemberId");

-- AddForeignKey
ALTER TABLE "TripExpenseSplit" ADD CONSTRAINT "TripExpenseSplit_expenseId_fkey" FOREIGN KEY ("expenseId") REFERENCES "TripExpense"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripExpenseSplit" ADD CONSTRAINT "TripExpenseSplit_tripMemberId_fkey" FOREIGN KEY ("tripMemberId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;
