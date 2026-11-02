import { SetMetadata, Type } from '@nestjs/common';

export const LOAD_RESOURCE_KEY = 'load_resource';

export const LoadResource = (loader: Type) =>
  SetMetadata(LOAD_RESOURCE_KEY, loader);
