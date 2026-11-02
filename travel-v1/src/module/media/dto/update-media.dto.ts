import { PartialType } from '@nestjs/mapped-types';
import { CompleteUploadDto } from './complete-media.dto';

export class UpdateMediaDto extends PartialType(CompleteUploadDto) {}
