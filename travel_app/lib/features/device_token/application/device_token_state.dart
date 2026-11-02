enum DeviceTokenStatus {
  idle,
  registered,
  permissionDenied,
  waitingForApns,
  unavailable,
  unregistered,
}

class DeviceTokenState {
  const DeviceTokenState({required this.status, this.installationId});

  const DeviceTokenState.idle()
    : status = DeviceTokenStatus.idle,
      installationId = null;

  final DeviceTokenStatus status;
  final String? installationId;

  bool get isRegistered => status == DeviceTokenStatus.registered;

  DeviceTokenState copyWith({
    DeviceTokenStatus? status,
    String? installationId,
  }) {
    return DeviceTokenState(
      status: status ?? this.status,
      installationId: installationId ?? this.installationId,
    );
  }
}
