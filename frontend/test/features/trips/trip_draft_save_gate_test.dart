import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/trip_draft_save_gate.dart';

void main() {
  test('a draft without a name is blocked the same way as continue', () {
    final block = tripDraftSaveBlock(
      formValid: false,
      destinationCount: 1,
      coverUploading: false,
      coverMediaId: 'cover-1',
    );

    expect(block, TripDraftSaveBlock.invalidForm);
  });

  test('destinations and cover are required before either save path', () {
    expect(
      tripDraftSaveBlock(
        formValid: true,
        destinationCount: 0,
        coverUploading: false,
        coverMediaId: 'cover-1',
      ),
      TripDraftSaveBlock.missingDestinations,
    );
    expect(
      tripDraftSaveBlock(
        formValid: true,
        destinationCount: 1,
        coverUploading: true,
        coverMediaId: null,
      ),
      TripDraftSaveBlock.coverUploading,
    );
    expect(
      tripDraftSaveBlock(
        formValid: true,
        destinationCount: 1,
        coverUploading: false,
        coverMediaId: null,
      ),
      TripDraftSaveBlock.missingCover,
    );
    expect(
      tripDraftSaveBlock(
        formValid: true,
        destinationCount: 1,
        coverUploading: false,
        coverMediaId: 'cover-1',
      ),
      isNull,
    );
  });
}
