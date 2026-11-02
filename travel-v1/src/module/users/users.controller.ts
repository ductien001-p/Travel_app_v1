import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { UsersService } from './users.service';

import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PaginationDto } from './dto/pagination.dto';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

import {
  PublicUserEnvelopeResponseDto,
  PublicUsersPageResponseDto,
  CreateUserResponseDto,
  UserActionResponseDto,
  UserSearchPageResponseDto,
  ProfileShowcaseEnvelopeResponseDto,
} from '../../common/contracts/extended-response.dto';
import { SearchUsersDto } from './dto/search-user.dto';
import { ProfileShowcaseService } from './profile-showcase.service';

@ApiTags('Users')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly profileShowcaseService: ProfileShowcaseService,
  ) {}

  // =========================================================
  // CREATE
  // =========================================================

  @Post('create')
  @ApiCreatedResponse({
    type: CreateUserResponseDto,
  })
  async create(@Body() dto: CreateUserDto) {
    const data = await this.usersService.create(dto);

    return {
      data,
      message: 'User created successfully',
    };
  }
  // =========================================================
  // SEARCH USERS
  // =========================================================
  @Get('search')
  @ApiOkResponse({
    type: UserSearchPageResponseDto,
  })
  async searchUsers(
    @Query()
    dto: SearchUsersDto,

    @CurrentUser('id')
    userId: string,
  ) {
    return this.usersService.searchUsers(dto, userId);
  }

  // =========================================================
  // GET USERS
  // =========================================================

  @Get()
  @ApiOkResponse({
    type: PublicUsersPageResponseDto,
  })
  findAll(@Query() query: PaginationDto) {
    return this.usersService.findAll(query.page, query.limit);
  }

  // =========================================================
  // ME
  // =========================================================

  @Get('me')
  @ApiOkResponse({
    type: PublicUserEnvelopeResponseDto,
  })
  async findMe(@CurrentUser('id') userId: string) {
    const data = await this.usersService.findOne(userId);

    return {
      data,
      message: 'User retrieved successfully',
    };
  }

  @Get('me/showcase')
  @ApiOkResponse({
    type: ProfileShowcaseEnvelopeResponseDto,
  })
  async getShowcase(@CurrentUser('id') userId: string) {
    const data = await this.profileShowcaseService.getShowcase(userId);

    return {
      data,
      message: 'Profile showcase retrieved successfully',
    };
  }

  // =========================================================
  // PUBLIC PROFILE
  // =========================================================

  @Get(':id')
  @ApiOkResponse({
    type: PublicUserEnvelopeResponseDto,
  })
  async findOneById(@Param('id') id: string) {
    const data = await this.usersService.findOneById(id);

    return {
      data,
      message: 'User retrieved successfully',
    };
  }

  // =========================================================
  // UPDATE
  // =========================================================

  @Patch('update')
  @ApiOkResponse({
    type: PublicUserEnvelopeResponseDto,
  })
  async update(@CurrentUser('id') userId: string, @Body() dto: UpdateUserDto) {
    const data = await this.usersService.update(userId, dto);

    return {
      data,
      message: 'User updated successfully',
    };
  }

  // =========================================================
  // DELETE
  // =========================================================

  @Delete('delete')
  @ApiOkResponse({
    type: UserActionResponseDto,
  })
  async remove(@CurrentUser('id') userId: string) {
    await this.usersService.remove(userId);

    return {
      success: true,
      message: 'User deleted successfully',
    };
  }
}
