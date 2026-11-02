import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/application/trip_cover_controller.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/trip_cover_picker.dart';

final _pngBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=',
);

void main() {
  Future<void> pump(
    WidgetTester tester,
    TripCoverState state, {
    VoidCallback? onPick,
    VoidCallback? onRetry,
    VoidCallback? onRemove,
  }) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: TripCoverPicker(
            state: state,
            onPick: onPick ?? () {},
            onRetry: onRetry ?? () {},
            onRemove: onRemove ?? () {},
          ),
        ),
      ),
    ),
  );

  testWidgets('empty state asks the user to add a cover', (tester) async {
    var picked = 0;
    await pump(tester, const TripCoverState(), onPick: () => picked++);

    await tester.tap(find.text('Thêm ảnh bìa'));

    expect(picked, 1);
  });

  testWidgets('uploading state shows progress and allows cancelling', (
    tester,
  ) async {
    var removed = 0;
    await pump(
      tester,
      TripCoverState(
        status: TripCoverStatus.uploading,
        previewBytes: _pngBytes,
        progress: 0.4,
      ),
      onRemove: () => removed++,
    );

    expect(find.text('Đang tải lên 40%'), findsOneWidget);
    await tester.tap(find.text('Hủy tải'));
    expect(removed, 1);
  });

  testWidgets('failed state offers a retry', (tester) async {
    var retried = 0;
    await pump(
      tester,
      TripCoverState(
        status: TripCoverStatus.failed,
        previewBytes: _pngBytes,
        errorMessage: 'Tải ảnh bìa thất bại. Vui lòng thử lại.',
      ),
      onRetry: () => retried++,
    );

    expect(
      find.text('Tải ảnh bìa thất bại. Vui lòng thử lại.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Thử lại'));
    expect(retried, 1);
  });

  testWidgets('uploaded state shows a confirmation badge', (tester) async {
    await pump(
      tester,
      TripCoverState(
        status: TripCoverStatus.uploaded,
        previewBytes: _pngBytes,
        progress: 1,
      ),
    );

    expect(find.text('Đã tải lên'), findsOneWidget);
    expect(find.text('Xóa ảnh'), findsOneWidget);
  });
}
