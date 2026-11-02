import { IsString, MaxLength, MinLength } from 'class-validator';
import { PaginationDto } from './pagination.dto';

export class SearchUsersDto extends PaginationDto {
  @IsString()
  @MinLength(1)
  @MaxLength(100)
  q!: string;
}
