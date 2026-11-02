import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/app/router/app_router.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/add_itinerary_activity_screen.dart';
import 'package:travel_frontend_v1/features/trips/presentation/create_trip/add_itinerary_activity_widgets.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/add_itinerary_activity_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/add_itinerary_activity_state.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';

void main() {
  test('router integration remains loadable', () {
    expect(routerProvider, isNotNull);
  });

  testWidgets('renders real route context and omits blocked content', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: AddItineraryActivityScreen(args: _args)),
      ),
    );

    expect(find.text('Thêm Hoạt Động Mới'), findsOneWidget);
    expect(
      find.textContaining('Ngày 2 • 05/10/2026 • Đà Nẵng, Việt Nam'),
      findsOneWidget,
    );
    expect(find.text('Thêm vào Ngày 2'), findsOneWidget);
    expect(find.text('Ghi chú (tùy chọn)'), findsOneWidget);
    expect(find.textContaining('Lưu vào kho nháp'), findsNothing);
    expect(find.textContaining('AI Gợi ý'), findsNothing);
  });

  testWidgets('selecting a place enables supported form flow', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: AddItineraryActivityScreen(args: _args)),
      ),
    );

    container
        .read(addItineraryActivityControllerProvider(_args).notifier)
        .selectPlace(_place);
    await tester.pump();

    expect(find.text('Bãi biển Mỹ Khê'), findsWidgets);
    expect(find.text('Đổi địa điểm khác'), findsOneWidget);
    expect(find.text('Thêm vào Ngày 2'), findsOneWidget);
  });

  testWidgets('numeric fields reject non-integer edits and show both errors', (
    tester,
  ) async {
    final title = TextEditingController();
    final duration = TextEditingController();
    final cost = TextEditingController();
    final notes = TextEditingController();
    addTearDown(title.dispose);
    addTearDown(duration.dispose);
    addTearDown(cost.dispose);
    addTearDown(notes.dispose);

    await tester.pumpWidget(
      _detailsSection(
        title: title,
        duration: duration,
        cost: cost,
        notes: notes,
        fieldErrors: const {
          'estimatedDuration': 'Duration error',
          'estimatedCost': 'Cost error',
        },
      ),
    );

    final durationField = find.widgetWithText(
      TextFormField,
      'Thời lượng (phút)',
    );
    await tester.enterText(durationField, '12');
    await tester.enterText(durationField, '12.5');

    expect(duration.text, '12');
    expect(find.text('Duration error'), findsOneWidget);
    expect(find.text('Cost error'), findsOneWidget);
  });

  testWidgets('start time is labelled and shown as UTC', (tester) async {
    final controllers = List.generate(4, (_) => TextEditingController());
    for (final controller in controllers) {
      addTearDown(controller.dispose);
    }

    await tester.pumpWidget(
      _detailsSection(
        title: controllers[0],
        duration: controllers[1],
        cost: controllers[2],
        notes: controllers[3],
        selectedTime: const TimeOfDay(hour: 9, minute: 5),
      ),
    );

    expect(find.text('Giờ bắt đầu (UTC)'), findsOneWidget);
    expect(find.text('09:05 • Buổi sáng (UTC)'), findsOneWidget);
  });

  testWidgets('invalid context offers a back action instead of retry', (
    tester,
  ) async {
    final invalidArgs = AddItineraryActivityArgs(
      tripId: '',
      dayId: 'day-2',
      destinationId: 'destination-1',
      dayNumber: 2,
      dayDate: DateTime(2026, 10, 5),
      city: 'Đà Nẵng',
      country: 'Việt Nam',
      insertionChoices: const [],
      canManageItinerary: true,
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: AddItineraryActivityScreen(args: invalidArgs)),
      ),
    );

    expect(find.text('Quay lại'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('unauthorized direct route shows access denied state', (
    tester,
  ) async {
    final args = AddItineraryActivityArgs(
      tripId: 'trip-1',
      dayId: 'day-2',
      destinationId: 'destination-1',
      dayNumber: 2,
      dayDate: DateTime(2026, 10, 5),
      city: 'Đà Nẵng',
      country: 'Việt Nam',
      insertionChoices: const [],
      canManageItinerary: false,
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: AddItineraryActivityScreen(args: args)),
      ),
    );

    expect(find.text('Không có quyền quản lý lịch trình'), findsOneWidget);
    expect(find.text('Thêm vào Ngày 2'), findsNothing);
  });
}

Widget _detailsSection({
  required TextEditingController title,
  required TextEditingController duration,
  required TextEditingController cost,
  required TextEditingController notes,
  TimeOfDay? selectedTime,
  Map<String, String> fieldErrors = const {},
}) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: ActivityDetailsSection(
          titleController: title,
          durationController: duration,
          costController: cost,
          notesController: notes,
          activities: const [],
          insertAfterActivityId: null,
          selectedTime: selectedTime,
          budgetCurrency: 'VND',
          fieldErrors: fieldErrors,
          onTitleChanged: (_) {},
          onChooseStartTime: () {},
          onDurationChanged: (_) {},
          onCostChanged: (_) {},
          onNotesChanged: (_) {},
          onChooseInsertion: () {},
          onSelectCostPreset: (_) {},
        ),
      ),
    ),
  );
}

final _args = AddItineraryActivityArgs(
  tripId: 'trip-1',
  dayId: 'day-2',
  destinationId: 'destination-1',
  dayNumber: 2,
  dayDate: DateTime(2026, 10, 5),
  city: 'Đà Nẵng',
  country: 'Việt Nam',
  insertionChoices: const [],
  canManageItinerary: true,
);

const _place = PlaceSearchResult(
  id: 'place-1',
  name: 'Bãi biển Mỹ Khê',
  description: 'Cách trung tâm 2 km',
  latitude: 16.0,
  longitude: 108.0,
  similarity: 0.95,
  distanceKm: 2,
);
