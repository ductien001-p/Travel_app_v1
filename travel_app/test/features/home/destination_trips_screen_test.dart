import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/application/destination_trips_controller.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/datamock/destination_trips_datamock.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/datasources/destination_trips_datasource.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/models/destination_trips_models.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/repositories/destination_trips_repository.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/presentation/screen/destination_trips_screen.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/provider/destination_trips_provider.dart';

class _FakeDestinationTripsDataSource implements DestinationTripsDataSource {
  @override
  Future<DestinationTripsPage> load(DestinationTripsQuery query) async {
    return DestinationTripsPage.fromJson(
      jsonDecode(jsonEncode(destinationTripsDatamock['daLat']))
          as Map<String, dynamic>,
    );
  }
}

void main() {
  testWidgets('shows Da Lat trips and the urgent filter narrows the list', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        destinationTripsRepositoryProvider.overrideWithValue(
          DestinationTripsRepository(
            dataSource: _FakeDestinationTripsDataSource(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: DestinationTripsScreen(cityName: 'Đà Lạt'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('THÀNH PHỐ NGÀN HOA'), findsOneWidget);
    expect(
      find.text('Săn Mây Đồi Đa Phú & Acoustic Đêm Đà Lạt 3N2Đ'),
      findsOneWidget,
    );
    expect(find.text('Tạo chuyến đi tới Đà Lạt'), findsOneWidget);

    const args = DestinationTripsArgs(cityName: 'Đà Lạt');
    await tester.tap(find.text('Đang tuyển gấp'));
    await tester.pump();
    await tester.pump();

    final urgent = container
        .read(destinationTripsControllerProvider(args))
        .requireValue;
    expect(urgent.selectedFilterId, 'urgent');
    expect(urgent.visibleTrips, hasLength(2));

    await tester.tap(find.text('Đặt lại'));
    await tester.pump();
    await tester.pump();
    expect(
      container
          .read(destinationTripsControllerProvider(args))
          .requireValue
          .selectedFilterId,
      'all',
    );
  });
}
