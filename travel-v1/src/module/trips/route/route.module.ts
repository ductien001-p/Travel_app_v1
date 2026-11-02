import { Module } from '@nestjs/common';
import { GoogleRoutesProvider } from './google-routes.provider';
import { RouteService } from './route.service';
import { ROUTE_PROVIDER } from './route.types';

@Module({
  providers: [
    GoogleRoutesProvider,
    RouteService,
    { provide: ROUTE_PROVIDER, useExisting: GoogleRoutesProvider },
  ],
  exports: [RouteService],
})
export class RouteModule {}
