import { ApiProperty } from '@nestjs/swagger';
import { ArrayMinSize, ArrayUnique, IsArray, IsString } from 'class-validator';

export class ReorderItineraryItemsDto {
  @ApiProperty({
    type: [String],
    example: ['item-id-3', 'item-id-1', 'item-id-2'],
  })
  @IsArray()
  @ArrayMinSize(1)
  @ArrayUnique()
  @IsString({ each: true })
  orderedItemIds!: string[];
}
