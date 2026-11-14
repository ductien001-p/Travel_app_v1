import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expenses_action_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expenses_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expenses_create_form.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/datamock/trip_expenses_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/datasources/trip_expenses_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/models/trip_expenses_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/repositories/trip_expenses_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/provider/trip_expenses_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/utils/trip_expenses_formatters.dart';

void main() {
  final overview = TripExpensesOverview.fromJson(
    Map<String, dynamic>.from(tripExpensesDatamock),
  );

  group('viewerRelatedSettlements', () {
    test('keeps only rows where viewer is debtor or creditor', () {
      final related = viewerRelatedSettlements(overview.settlements);

      expect(related.map((s) => s.id), [
        'split-cruise-phuong',
        'split-hotel-alex',
      ]);
      expect(related.every((s) => s.fromIsViewer || s.toIsViewer), isTrue);
    });
  });

  group('settle labels and gating', () {
    test('creditor CTA and confirm copy', () {
      final row = overview.settlements.firstWhere((s) => s.toIsViewer);

      expect(canViewerSettleSettlement(row), isTrue);
      expect(settlementActionLabel(row), 'Xác nhận đã nhận');
      expect(settlementConfirmTitle(row), 'Xác nhận đã nhận tiền?');
      expect(settlementConfirmPrimaryLabel(row), 'Xác nhận');
      expect(settlementConfirmMessage(row), contains('đã nhận'));
    });

    test('debtor CTA and confirm copy', () {
      final row = overview.settlements.firstWhere((s) => s.fromIsViewer);

      expect(canViewerSettleSettlement(row), isTrue);
      expect(settlementActionLabel(row), 'Đã chuyển tiền');
      expect(settlementConfirmTitle(row), 'Ghi nhận đã chuyển tiền?');
      expect(settlementConfirmPrimaryLabel(row), 'Ghi nhận');
      expect(settlementConfirmMessage(row), contains('đã chuyển'));
    });

    test('pending third-party row is not settleable by viewer', () {
      final row = overview.settlements.firstWhere(
        (s) => !s.fromIsViewer && !s.toIsViewer,
      );

      expect(canViewerSettleSettlement(row), isFalse);
      expect(settlementActionLabel(row), 'Chờ xác nhận');
    });
  });

  group('validateTripExpensesCreateForm', () {
    test('rejects non-positive amount', () {
      final result = validateTripExpensesCreateForm(
        const TripExpensesCreateFormState(amountText: '0'),
        memberIds: const ['m1', 'm2'],
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, isNotNull);
    });

    test('EQUAL passes without splits', () {
      final result = validateTripExpensesCreateForm(
        const TripExpensesCreateFormState(amountText: '100000'),
        memberIds: const ['m1', 'm2'],
      );

      expect(result.isValid, isTrue);
      final request = buildCreateTripExpenseRequest(
        const TripExpensesCreateFormState(amountText: '100000'),
        memberIds: const ['m1', 'm2'],
      );
      expect(request, isNotNull);
      expect(request!.splitType, TripExpensesSplitType.equal);
      expect(request.splits, isEmpty);
      expect(request.currency, TripExpensesCurrency.vnd);
    });

    test('keeps selected currency on create request', () {
      final request = buildCreateTripExpenseRequest(
        const TripExpensesCreateFormState(
          amountText: '12.50',
          currency: TripExpensesCurrency.usd,
        ),
        memberIds: const ['m1'],
      );

      expect(request, isNotNull);
      expect(request!.currency, TripExpensesCurrency.usd);
      expect(request.amount, 12.50);
    });

    test('formatExpenseAmountInput inserts thousand separators for VND', () {
      expect(formatExpenseAmountInput('1250000'), '1.250.000');
      expect(formatExpenseAmountInput('1.250.000'), '1.250.000');
      expect(formatExpenseAmountInput(''), '');
      expect(
        formatExpenseAmountInput('12.50', currency: TripExpensesCurrency.usd),
        '12.50',
      );
    });

    test('CUSTOM requires sum equal to amount', () {
      const form = TripExpensesCreateFormState(
        amountText: '100000',
        splitType: TripExpensesSplitType.custom,
        customAmounts: {'m1': '40000', 'm2': '50000'},
      );

      final invalid = validateTripExpensesCreateForm(
        form,
        memberIds: const ['m1', 'm2'],
      );
      expect(invalid.isValid, isFalse);
      expect(invalid.splitsError, contains('bằng số tiền'));

      const validForm = TripExpensesCreateFormState(
        amountText: '100000',
        splitType: TripExpensesSplitType.custom,
        customAmounts: {'m1': '40000', 'm2': '60000'},
      );
      final valid = validateTripExpensesCreateForm(
        validForm,
        memberIds: const ['m1', 'm2'],
      );
      expect(valid.isValid, isTrue);

      final request = buildCreateTripExpenseRequest(
        validForm,
        memberIds: const ['m1', 'm2'],
      );
      expect(request!.splits.length, 2);
      expect(request.splits.map((s) => s.amount).toList(), [40000, 60000]);
    });

    test('rejects payer outside trip members', () {
      final result = validateTripExpensesCreateForm(
        const TripExpensesCreateFormState(
          amountText: '100000',
          payerTripMemberId: 'outsider',
        ),
        memberIds: const ['m1', 'm2'],
      );
      expect(result.isValid, isFalse);
      expect(result.payerError, isNotNull);
    });

    test('rejects more than max receipts and long location', () {
      final result = validateTripExpensesCreateForm(
        TripExpensesCreateFormState(
          amountText: '100000',
          receiptMediaIds: List.generate(6, (i) => 'media-$i'),
          locationNote: 'x' * 201,
        ),
        memberIds: const ['m1'],
      );
      expect(result.isValid, isFalse);
      expect(result.receiptsError, isNotNull);
      expect(result.locationError, isNotNull);
    });

    test('forwards payer spentAt location and receipts on create request', () {
      final spentAt = DateTime.utc(2025, 7, 18, 12, 30);
      final request = buildCreateTripExpenseRequest(
        TripExpensesCreateFormState(
          amountText: '100000',
          payerTripMemberId: 'm2',
          spentAt: spentAt,
          locationNote: 'Quán hải sản',
          receiptMediaIds: const ['r1', 'r2'],
        ),
        memberIds: const ['m1', 'm2'],
        defaultPayerTripMemberId: 'm1',
      );

      expect(request, isNotNull);
      expect(request!.payerTripMemberId, 'm2');
      expect(request.spentAt, spentAt);
      expect(request.locationNote, 'Quán hải sản');
      expect(request.receiptMediaIds, ['r1', 'r2']);
    });
  });

  group('TripExpensesActionController', () {
    late _FakeTripExpensesDataSource dataSource;
    late ProviderContainer container;
    const tripId = 'trip-demo-summer-2025';

    setUp(() {
      dataSource = _FakeTripExpensesDataSource(overview);
      container = ProviderContainer(
        overrides: [
          tripExpensesRepositoryProvider.overrideWithValue(
            TripExpensesRepository(dataSource: dataSource),
          ),
        ],
      );
      addTearDown(container.dispose);
      container.listen(tripExpensesControllerProvider(tripId), (_, _) {});
      container.listen(tripExpensesActionControllerProvider(tripId), (_, _) {});
    });

    test('createExpense invalidates overview', () async {
      await container.read(tripExpensesControllerProvider(tripId).future);
      expect(dataSource.getCount, 1);

      await container
          .read(tripExpensesActionControllerProvider(tripId).notifier)
          .createExpense(
            const CreateTripExpenseRequest(
              amount: 50000,
              category: TripExpensesCategory.food,
              splitType: TripExpensesSplitType.equal,
            ),
          );

      expect(dataSource.createCalls, 1);
      // invalidate → rebuild loads again
      await container.read(tripExpensesControllerProvider(tripId).future);
      expect(dataSource.getCount, greaterThan(1));
    });

    test('settleSplit records ids and invalidates', () async {
      await container.read(tripExpensesControllerProvider(tripId).future);

      final split = await container
          .read(tripExpensesActionControllerProvider(tripId).notifier)
          .settleSplit(
            expenseId: 'expense-cruise',
            splitId: 'split-cruise-phuong',
          );

      expect(split.id, 'split-cruise-phuong');
      expect(
        container
            .read(tripExpensesActionControllerProvider(tripId))
            .lastSettledSplitId,
        'split-cruise-phuong',
      );
      expect(dataSource.settleCalls.single, (
        expenseId: 'expense-cruise',
        splitId: 'split-cruise-phuong',
      ));
    });
  });

  test('page 2 keeps the full summary while appending expenses', () async {
    final pageTwoExpense = overview.expenses.first;
    final source = _PagingExpenses(overview, pageTwoExpense);
    final container = ProviderContainer(
      overrides: [
        tripExpensesRepositoryProvider.overrideWithValue(
          TripExpensesRepository(dataSource: source),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(tripExpensesControllerProvider('trip-1'), (_, _) {});

    final first = await container.read(
      tripExpensesControllerProvider('trip-1').future,
    );
    expect(first.overview.summary, overview.summary);
    expect(first.meta.hasNextPage, isTrue);

    await container
        .read(tripExpensesControllerProvider('trip-1').notifier)
        .loadMore();
    final loaded = container
        .read(tripExpensesControllerProvider('trip-1'))
        .requireValue;

    expect(loaded.overview.summary, overview.summary);
    expect(loaded.overview.categories, overview.categories);
    expect(loaded.overview.settlements, overview.settlements);
    expect(
      loaded.overview.expenses.length,
      overview.expenses.length + 1,
    );
    expect(loaded.meta.page, 2);
    expect(source.pages, [1, 2]);
  });
}

class _PagingExpenses implements TripExpensesDataSource {
  _PagingExpenses(this.overview, this.pageTwoExpense);

  final TripExpensesOverview overview;
  final TripExpensesEntry pageTwoExpense;
  final pages = <int>[];

  @override
  Future<TripExpensesPage> getExpenses(
    String tripId, {
    int page = 1,
    int limit = 20,
  }) async {
    pages.add(page);
    final visible = page == 1 ? overview.expenses : [pageTwoExpense];
    return TripExpensesPage(
      overview: overview.copyWith(expenses: visible),
      meta: PageMeta(
        page: page,
        limit: limit,
        total: overview.expenses.length + 1,
        totalPages: 2,
        hasNextPage: page == 1,
        hasPreviousPage: page > 1,
      ),
    );
  }

  @override
  Future<TripExpenseCreated> createExpense(
    String tripId,
    CreateTripExpenseRequest request,
  ) =>
      throw UnimplementedError();

  @override
  Future<TripExpenseCreatedSplit> settleSplit({
    required String tripId,
    required String expenseId,
    required String splitId,
  }) =>
      throw UnimplementedError();
}

class _FakeTripExpensesDataSource implements TripExpensesDataSource {
  _FakeTripExpensesDataSource(this.overview);

  final TripExpensesOverview overview;
  int getCount = 0;
  int createCalls = 0;
  final settleCalls = <({String expenseId, String splitId})>[];

  @override
  Future<TripExpensesPage> getExpenses(
    String tripId, {
    int page = 1,
    int limit = 20,
  }) async {
    getCount++;
    return TripExpensesPage(
      overview: overview,
      meta: PageMeta(
        page: page,
        limit: limit,
        total: overview.expenses.length,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );
  }

  @override
  Future<TripExpenseCreated> createExpense(
    String tripId,
    CreateTripExpenseRequest request,
  ) async {
    createCalls++;
    return TripExpenseCreated(
      id: 'expense-new',
      tripId: tripId,
      payerId: 'member-alex',
      amount: request.amount.toString(),
      currency: request.currency,
      category: request.category,
      splitType: request.splitType,
      description: request.description,
      spentAt: request.spentAt ?? DateTime.utc(2025, 7, 18),
      locationNote: request.locationNote,
      createdAt: DateTime.utc(2025, 7, 18),
      payer: const TripExpensesMember(
        id: 'member-alex',
        userId: 'user-alex',
        user: TripExpensesUser(id: 'user-alex', username: 'alex'),
      ),
      splits: const [],
      receipts: const [],
    );
  }

  @override
  Future<TripExpenseCreatedSplit> settleSplit({
    required String tripId,
    required String expenseId,
    required String splitId,
  }) async {
    settleCalls.add((expenseId: expenseId, splitId: splitId));
    return TripExpenseCreatedSplit(
      id: splitId,
      expenseId: expenseId,
      tripMemberId: 'member-phuong',
      amount: '320000',
      isSettled: true,
      member: const TripExpensesMember(
        id: 'member-phuong',
        userId: 'user-phuong',
        user: TripExpensesUser(id: 'user-phuong', username: 'phuong'),
      ),
    );
  }
}
