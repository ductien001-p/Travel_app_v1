/* eslint-disable @typescript-eslint/unbound-method */
import { Test, TestingModule } from '@nestjs/testing';
import { TripsController } from './trips.controller';
import { TripsService } from './trips.service';
import { TripMemoriesService } from './trip-relations/trip-memories/trip-memories.service';
import { RecommendFriendsToTripService } from './trip-relations/trip-recommend-friend/recommend-friends-to-trip.service';
import { RouteService } from './route/route.service';
import { TripMembersService } from './trip-relations/trip-members/trip-member.service';
import { TripDetailService } from './trip-detail/trip-detail.service';
import { TripJoinRequestsService } from './trip-relations/trip-join-requests/trip-join-requests.service';
import { TripRecruitmentService } from './trip-relations/trip-recruitment/trip-recruitment.service';
import { TripDiscoverService } from './trip-discover/trip-discover.service';
import { DestinationCatalogPlacesService } from './destination-catalog-places.service';
import { CreateTripDto } from './dto/create-trip.dto';

jest.mock('nanoid', () => ({
  customAlphabet: jest.fn(() => jest.fn()),
}));

describe('TripsController', () => {
  let controller: TripsController;
  let tripsService: jest.Mocked<TripsService>;
  let tripMembersService: jest.Mocked<TripMembersService>;

  const mockTripsService = {
    createTrip: jest.fn(),
    queryTrip: jest.fn(),
    updateTrip: jest.fn(),
    deleteTrip: jest.fn(),
  };

  const mockTripDetailService = {
    getTripDetail: jest.fn(),
  };

  const mockTripMembersService = {
    leaveTrip: jest.fn(),
    kickMember: jest.fn(),
  };

  const mockTripJoinRequestsService = {
    requestToJoin: jest.fn(),
    requestToJoinByTripId: jest.fn(),
    previewByTripId: jest.fn(),
    previewByInviteCode: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TripsController],
      providers: [
        {
          provide: TripsService,
          useValue: mockTripsService,
        },
        {
          provide: TripMembersService,
          useValue: mockTripMembersService,
        },
        {
          provide: TripDetailService,
          useValue: mockTripDetailService,
        },
        {
          provide: TripMemoriesService,
          useValue: {
            createMemories: jest.fn(),
            getMemories: jest.fn(),
            deleteMemory: jest.fn(),
          },
        },
        {
          provide: RecommendFriendsToTripService,
          useValue: { getCompanionRecommendations: jest.fn() },
        },
        {
          provide: RouteService,
          useValue: { getRoute: jest.fn() },
        },
        {
          provide: TripJoinRequestsService,
          useValue: mockTripJoinRequestsService,
        },
        {
          provide: TripRecruitmentService,
          useValue: { summary: jest.fn(), mine: jest.fn() },
        },
        {
          provide: TripDiscoverService,
          useValue: { discover: jest.fn() },
        },
        {
          provide: DestinationCatalogPlacesService,
          useValue: { getCatalogPlaces: jest.fn() },
        },
      ],
    }).compile();

    controller = module.get<TripsController>(TripsController);
    tripsService = module.get(TripsService);
    tripMembersService = module.get(TripMembersService);

    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should create a trip', async () => {
      const userId = 'user-1';

      const createTripDto = {
        name: 'Da Lat Trip',
        description: 'Trip to Da Lat',
      } as CreateTripDto;

      const expectedResult = {
        id: 'trip-1',
        ownerId: userId,
        name: 'Da Lat Trip',
        description: 'Trip to Da Lat',
      };

      tripsService.createTrip.mockResolvedValue(expectedResult as any);

      const result = await controller.create(userId, createTripDto);

      expect(tripsService.createTrip).toHaveBeenCalledWith(
        userId,
        createTripDto,
      );

      expect(result).toEqual({
        data: expectedResult,
        message: 'Trip created successfully',
      });
    });
  });

  describe('findAll', () => {
    it('should return all trips based on query', async () => {
      const query = {
        search: 'Da Lat',
      };
      const userId = 'user-1';

      const expectedResult = {
        data: [
          { id: 'trip-1', name: 'Da Lat Trip' },
          { id: 'trip-2', name: 'Da Lat Adventure' },
        ],
      };

      tripsService.queryTrip.mockResolvedValue(expectedResult as any);

      const result = await controller.findAll(query, userId);

      expect(tripsService.queryTrip).toHaveBeenCalledWith(query, userId);

      expect(result).toEqual(expectedResult);
    });
  });

  describe('findOne', () => {
    it('should return a trip by id', async () => {
      const id = 'trip-1';
      const userId = 'user-1';

      const expectedResult = {
        id,
        name: 'Da Lat Trip',
      };

      mockTripDetailService.getTripDetail.mockResolvedValue(expectedResult);

      const result = await controller.findOne(id, userId);

      expect(mockTripDetailService.getTripDetail).toHaveBeenCalledWith(
        id,
        userId,
      );

      expect(result).toEqual({
        data: expectedResult,
        message: 'Trip retrieved successfully',
      });
    });
  });

  describe('update', () => {
    it('should update a trip', async () => {
      const userId = 'user-1';
      const tripId = 'trip-1';

      const updateTripDto = {
        name: 'Updated Da Lat Trip',
      };

      const expectedResult = {
        id: tripId,
        ownerId: userId,
        name: 'Updated Da Lat Trip',
      };

      tripsService.updateTrip.mockResolvedValue(expectedResult as any);

      const result = await controller.update(userId, tripId, updateTripDto);

      expect(tripsService.updateTrip).toHaveBeenCalledWith(
        tripId,
        userId,
        updateTripDto,
      );

      expect(result).toEqual({
        data: expectedResult,
        message: 'Trip updated successfully',
      });
    });
  });

  describe('deleteTrip', () => {
    it('should delete a trip', async () => {
      const userId = 'user-1';
      const tripId = 'trip-1';

      tripsService.deleteTrip.mockResolvedValue(undefined);

      const result = await controller.deleteTrip(userId, tripId);

      expect(tripsService.deleteTrip).toHaveBeenCalledWith(tripId, userId);

      expect(result).toEqual({
        success: true,
        message: 'Trip deleted successfully',
      });
    });
  });

  describe('join', () => {
    it('sends a join request with the note of the user', async () => {
      mockTripJoinRequestsService.requestToJoin.mockResolvedValue({
        status: 'PENDING',
      });

      const result = await controller.joinByInviteCode('user-1', 'CODE1234', {
        message: 'Cho mình đi với',
      });

      expect(mockTripJoinRequestsService.requestToJoin).toHaveBeenCalledWith(
        'CODE1234',
        'user-1',
        { message: 'Cho mình đi với' },
      );
      expect(result.message).toBe('Join request sent successfully');
    });

    it('reports an auto-approved request as joined', async () => {
      mockTripJoinRequestsService.requestToJoin.mockResolvedValue({
        status: 'APPROVED',
      });

      const result = await controller.joinByInviteCode(
        'user-1',
        'CODE1234',
        {},
      );

      expect(result.message).toBe('Joined trip successfully');
    });

    it('delegates join-by-tripId to TripJoinRequestsService', async () => {
      mockTripJoinRequestsService.requestToJoinByTripId.mockResolvedValue({
        status: 'PENDING',
      });

      const result = await controller.joinByTripId('user-1', 'trip-public', {
        message: 'Xin vào',
      });

      expect(
        mockTripJoinRequestsService.requestToJoinByTripId,
      ).toHaveBeenCalledWith('trip-public', 'user-1', {
        message: 'Xin vào',
      });
      expect(result.message).toBe('Join request sent successfully');
    });

    it('delegates join preview by tripId', async () => {
      mockTripJoinRequestsService.previewByTripId.mockResolvedValue({
        tripId: 'trip-public',
      });

      await controller.previewJoinByTripId('user-1', 'trip-public');

      expect(mockTripJoinRequestsService.previewByTripId).toHaveBeenCalledWith(
        'trip-public',
        'user-1',
      );
    });
  });

  describe('members', () => {
    it('delegates leave and kick to TripMembersService', async () => {
      tripMembersService.leaveTrip.mockResolvedValue({} as any);
      tripMembersService.kickMember.mockResolvedValue({} as any);

      await controller.leaveTrip('user-1', 'trip-1');
      await controller.kickMember('owner-1', 'trip-1', 'user-2');

      expect(tripMembersService.leaveTrip).toHaveBeenCalledWith(
        'trip-1',
        'user-1',
      );
      expect(tripMembersService.kickMember).toHaveBeenCalledWith(
        'trip-1',
        'user-2',
        'owner-1',
      );
    });
  });
});
