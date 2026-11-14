import 'package:geolocator/geolocator.dart';

enum DeviceLocationFailure {
  serviceDisabled,
  denied,
  deniedForever,
  unavailable,
}

class DeviceCoordinate {
  const DeviceCoordinate({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;
}

class DeviceLocationException implements Exception {
  const DeviceLocationException(this.failure);
  final DeviceLocationFailure failure;
}

abstract interface class DeviceLocationService {
  Future<DeviceCoordinate> current();
}

class GeolocatorDeviceLocationService implements DeviceLocationService {
  const GeolocatorDeviceLocationService();

  @override
  Future<DeviceCoordinate> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const DeviceLocationException(
        DeviceLocationFailure.serviceDisabled,
      );
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw const DeviceLocationException(DeviceLocationFailure.denied);
    }
    if (permission == LocationPermission.deniedForever) {
      throw const DeviceLocationException(DeviceLocationFailure.deniedForever);
    }
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return DeviceCoordinate(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      throw const DeviceLocationException(DeviceLocationFailure.unavailable);
    }
  }
}
