import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: {
    register: jest.Mock;
    login: jest.Mock;
    googleLogin: jest.Mock;
    refresh: jest.Mock;
    logoutOne: jest.Mock;
  };

  beforeEach(async () => {
    const mockAuthService = {
      register: jest.fn(),
      login: jest.fn(),
      googleLogin: jest.fn(),
      refresh: jest.fn(),
      logoutOne: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        {
          provide: AuthService,
          useValue: mockAuthService,
        },
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);
    authService = module.get(AuthService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('register', () => {
    it('should call authService.register with correct data', async () => {
      const dto = {
        email: 'test@gmail.com',
        password: '123456',
        username: 'Tien',
      };

      const expectedResult = {
        user: {
          id: 'user-1',
          email: dto.email,
          username: dto.username,
          role: 'CUSTOMER',
          status: 'ACTIVE',
        },
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      };

      authService.register.mockResolvedValue(expectedResult);

      const result = await controller.register(dto);

      expect(authService.register).toHaveBeenCalledWith({
        email: dto.email,
        password: dto.password,
        username: dto.username,
      });

      expect(result).toEqual({ message: 'User registered successfully' });
    });
  });

  describe('login', () => {
    it('should call authService.login with req.user', () => {
      const user = {
        id: 'user-1',
        email: 'test@gmail.com',
        role: 'CUSTOMER',
        status: 'ACTIVE',
      };

      const req = {
        user,
      };

      const expectedResult = {
        user: {
          id: 'user-1',
          email: 'test@gmail.com',
          role: 'CUSTOMER',
          status: 'ACTIVE',
        },
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      };

      authService.login.mockReturnValue(expectedResult);

      const result = controller.login(
        { email: user.email, password: 'password' },
        req,
      );

      expect(authService.login).toHaveBeenCalledWith(user);
      expect(result).toEqual(expectedResult);
    });
  });

  describe('googleAuth', () => {
    it('should be defined', async () => {
      const result = await controller.googleAuth();

      expect(result).toBeUndefined();
    });
  });

  describe('googleAuthRedirect', () => {
    it('should call authService.googleLogin with req.user', () => {
      const user = {
        id: 'google-user-1',
        email: 'google@gmail.com',
        role: 'CUSTOMER',
        status: 'ACTIVE',
      };

      const req = {
        user,
      };

      const expectedResult = {
        user: {
          id: 'google-user-1',
          email: 'google@gmail.com',
          role: 'CUSTOMER',
          status: 'ACTIVE',
        },
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      };

      authService.googleLogin.mockReturnValue(expectedResult);

      const result = controller.googleAuthRedirect(req);

      expect(authService.googleLogin).toHaveBeenCalledWith(user);
      expect(result).toEqual(expectedResult);
    });
  });

  describe('refresh', () => {
    it('should call authService.refresh with refreshToken', async () => {
      const dto = {
        refreshToken: 'refresh-token',
      };

      const expectedResult = {
        accessToken: 'new-access-token',
        refreshToken: 'new-refresh-token',
      };

      authService.refresh.mockResolvedValue(expectedResult);

      const result = await controller.refresh(dto);

      expect(authService.refresh).toHaveBeenCalledWith(dto.refreshToken);

      expect(result).toEqual(expectedResult);
    });
  });

  describe('logout', () => {
    it('should call authService.logout with userId', async () => {
      const userId = 'user-1';

      const dto = {
        refreshToken: 'refresh-token',
        deviceToken: 'device-token',
      };
      authService.logoutOne.mockResolvedValue(undefined);

      const result = await controller.logout(dto, userId);

      expect(authService.logoutOne).toHaveBeenCalledWith(dto, userId);
      expect(result).toEqual({
        message: 'Logged out successfully',
      });
    });
  });
});
