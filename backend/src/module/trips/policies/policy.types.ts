export type ISODate = string; // yyyy-MM-dd (calendar day)
export type ISODateTime = string; // ISO 8601 with explicit Z or +/-HH:mm, evaluated in UTC
export type TripRole = 'OWNER' | 'ADMIN' | 'MEMBER';
export type MemberStatus = 'ACTIVE' | 'LEFT' | 'KICKED';
export type TripStatus =
  'DRAFT' | 'UPCOMING' | 'ONGOING' | 'COMPLETED' | 'CANCELLED' | 'NOTCOMPLETED';

export interface TripRange {
  startDate: ISODate;
  endDate: ISODate;
}
export interface DestinationRange extends TripRange {
  id: string;
  order: number;
}
export interface ItineraryDayInput {
  id: string;
  tripId: string;
  destinationId: string;
  date: ISODate;
}
export interface ActivityInput {
  id?: string;
  tripId: string;
  dayId: string;
  placeId?: string | null;
  startTime?: ISODateTime | null;
  estimatedDuration?: number | null; // minutes
  isCheckin?: boolean;
}
export interface MembershipInput {
  userId: string;
  role: TripRole;
  status: MemberStatus;
}
