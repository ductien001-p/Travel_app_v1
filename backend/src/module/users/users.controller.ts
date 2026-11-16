import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Query,
} from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { UsersService } from './users.service';

import { UpdateUserDto } from './dto/update-user.dto';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

import {
  PublicUserEnvelopeResponseDto,
  MeUserEnvelopeResponseDto,
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
  // ME
  // =========================================================

  @Get('me')
  @ApiOkResponse({
    type: MeUserEnvelopeResponseDto,
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
    type: MeUserEnvelopeResponseDto,
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
