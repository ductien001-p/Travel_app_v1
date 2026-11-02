-- AlterEnum
ALTER TYPE "INVITATION_STATUS" ADD VALUE 'CANCELLED';

-- AlterEnum
ALTER TYPE "TRIP_STATUS" ADD VALUE 'DRAFT';

-- AlterTable
ALTER TABLE "trips" ADD COLUMN     "budgetCurrency" VARCHAR(3),
ADD COLUMN     "estimatedBudgetPerPerson" DECIMAL(14,2);
