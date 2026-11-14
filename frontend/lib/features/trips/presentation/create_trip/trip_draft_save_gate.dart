/// Shared by "Lưu nháp" and "Tiếp tục". A draft cannot skip the name,
/// destinations, or cover that the continue step already required.
enum TripDraftSaveBlock {
  invalidForm,
  missingDestinations,
  coverUploading,
  missingCover,
}

TripDraftSaveBlock? tripDraftSaveBlock({
  required bool formValid,
  required int destinationCount,
  required bool coverUploading,
  required String? coverMediaId,
}) {
  if (!formValid) return TripDraftSaveBlock.invalidForm;
  if (destinationCount == 0) return TripDraftSaveBlock.missingDestinations;
  if (coverUploading) return TripDraftSaveBlock.coverUploading;
  if (coverMediaId == null) return TripDraftSaveBlock.missingCover;
  return null;
}
