import { ArrayMaxSize, ArrayMinSize, ValidateNested } from 'class-validator';

import { Type } from 'class-transformer';

import { CreateItineraryItemDto } from './create-itinerary-item.dto';

export class CreateItineraryItemsBatchDto {
  @ArrayMinSize(1)
  @ArrayMaxSize(100)
  @ValidateNested({ each: true })
  @Type(() => CreateItineraryItemDto)
  items!: CreateItineraryItemDto[];
}
