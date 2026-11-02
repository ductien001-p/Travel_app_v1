import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceInstallationService {
  static const String _installationIdKey = 'device_installation_id';

  final FlutterSecureStorage _storage;
  final Uuid _uuid;

  DeviceInstallationService({FlutterSecureStorage? storage, Uuid? uuid})
    : _storage = storage ?? const FlutterSecureStorage(),
      _uuid = uuid ?? const Uuid();

  Future<String> getInstallationId() async {
    final existingId = await _storage.read(key: _installationIdKey);

    if (existingId != null && existingId.isNotEmpty) {
      return existingId;
    }

    final newId = _uuid.v4();

    await _storage.write(key: _installationIdKey, value: newId);

    return newId;
  }
}
