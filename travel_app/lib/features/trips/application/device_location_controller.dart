import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/location/device_location_service.dart';

final deviceLocationServiceProvider = Provider<DeviceLocationService>(
  (ref) => const GeolocatorDeviceLocationService(),
);

final deviceLocationControllerProvider =
    AsyncNotifierProvider<DeviceLocationController, DeviceCoordinate?>(
      DeviceLocationController.new,
    );

class DeviceLocationController extends AsyncNotifier<DeviceCoordinate?> {
  @override
  DeviceCoordinate? build() => null;

  Future<void> locate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(deviceLocationServiceProvider).current(),
    );
  }
}
