class CreateTripInvitationRequest {
  const CreateTripInvitationRequest({
    required this.tripId,
    required this.inviteeId,
  });
  final String tripId;
  final String inviteeId;
  Map<String, dynamic> toJson() => {'tripId': tripId, 'inviteeId': inviteeId};
}
