import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_expenses_models.freezed.dart';
part 'trip_expenses_models.g.dart';

/// `EXPENSE_CATEGORY` / `TripExpenseCategoryShareDto.category`.
enum TripExpensesCategory {
  @JsonValue('FOOD')
  food,
  @JsonValue('ACCOMMODATION')
  accommodation,
  @JsonValue('TRANSPORT')
  transport,
  @JsonValue('ACTIVITY')
  activity,
  @JsonValue('SHOPPING')
  shopping,
  @JsonValue('OTHER')
  other,
}

/// `CURRENCY`.
enum TripExpensesCurrency {
  @JsonValue('VND')
  vnd,
  @JsonValue('USD')
  usd,
}

/// `EXPENSE_SPLIT_TYPE`.
enum TripExpensesSplitType {
  @JsonValue('EQUAL')
  equal,
  @JsonValue('CUSTOM')
  custom,
}

/// `TripExpenseSettleStatusDto`.
enum TripExpensesSettleStatus {
  @JsonValue('SETTLED')
  settled,
  @JsonValue('PARTIAL')
  partial,
  @JsonValue('PENDING')
  pending,
}

/// `TripExpenseSettlementStatusDto`.
enum TripExpensesSettlementStatus {
  @JsonValue('ACTIONABLE')
  actionable,
  @JsonValue('PENDING')
  pending,
}

/// `TripExpenseOverviewDto` — `GET /trips/{tripId}/expenses`.
@freezed
abstract class TripExpensesOverview with _$TripExpensesOverview {
  const factory TripExpensesOverview({
    required String tripId,
    required String tripName,
    required int memberCount,
    required TripExpensesCurrency currency,
    required String viewerUserId,
    required TripExpensesSummary summary,
    @Default(<TripExpensesCategoryShare>[])
    List<TripExpensesCategoryShare> categories,
    @Default(<TripExpensesSettlement>[])
    List<TripExpensesSettlement> settlements,
    @Default(<TripExpensesEntry>[]) List<TripExpensesEntry> expenses,
  }) = _TripExpensesOverview;

  factory TripExpensesOverview.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesOverviewFromJson(json);
}

/// `TripExpenseOverviewSummaryDto`.
@freezed
abstract class TripExpensesSummary with _$TripExpensesSummary {
  const factory TripExpensesSummary({
    required num totalAmount,
    required num viewerPaidAmount,

    /// Positive = viewer should receive; negative = viewer still owes.
    required num viewerNetBalance,
  }) = _TripExpensesSummary;

  factory TripExpensesSummary.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesSummaryFromJson(json);
}

/// `TripExpenseCategoryShareDto`.
@freezed
abstract class TripExpensesCategoryShare with _$TripExpensesCategoryShare {
  const factory TripExpensesCategoryShare({
    required TripExpensesCategory category,
    required num amount,
    required int percent,
  }) = _TripExpensesCategoryShare;

  factory TripExpensesCategoryShare.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesCategoryShareFromJson(json);
}

/// `TripExpenseSettlementDto`.
@freezed
abstract class TripExpensesSettlement with _$TripExpensesSettlement {
  const factory TripExpensesSettlement({
    required String id,
    required String fromMemberId,
    required String fromDisplayName,
    required String fromInitials,
    @Default(false) bool fromIsViewer,
    required String toMemberId,
    required String toDisplayName,
    required bool toIsViewer,
    required num amount,
    String? note,
    required TripExpensesSettlementStatus status,
    String? expenseId,
    String? splitId,
  }) = _TripExpensesSettlement;

  factory TripExpensesSettlement.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesSettlementFromJson(json);
}

/// `TripExpenseReceiptDto`.
@freezed
abstract class TripExpenseReceipt with _$TripExpenseReceipt {
  const factory TripExpenseReceipt({
    required String mediaId,
    required String url,
    @Default(0) int sortOrder,
  }) = _TripExpenseReceipt;

  factory TripExpenseReceipt.fromJson(Map<String, dynamic> json) =>
      _$TripExpenseReceiptFromJson(json);
}

/// `TripExpenseListItemDto`.
@freezed
abstract class TripExpensesEntry with _$TripExpensesEntry {
  const factory TripExpensesEntry({
    required String id,
    required String tripId,
    String? description,
    required String amount,
    required TripExpensesCurrency currency,
    required TripExpensesCategory category,
    required TripExpensesSplitType splitType,
    required DateTime spentAt,
    String? locationNote,
    required DateTime createdAt,
    required String payerId,
    required bool payerIsViewer,
    required TripExpensesPayer payer,
    required int splitCount,
    num? amountPerPerson,
    String? splitNote,
    required int settledCount,
    required TripExpensesSettleStatus status,
    @Default(<TripExpensesSplitEntry>[]) List<TripExpensesSplitEntry> splits,
    @Default(<TripExpenseReceipt>[]) List<TripExpenseReceipt> receipts,
  }) = _TripExpensesEntry;

  factory TripExpensesEntry.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesEntryFromJson(json);
}

/// `TripExpenseListPayerDto`.
@freezed
abstract class TripExpensesPayer with _$TripExpensesPayer {
  const factory TripExpensesPayer({
    required String id,
    required String userId,
    required String displayName,
    String? title,
    required TripExpensesUser user,
  }) = _TripExpensesPayer;

  factory TripExpensesPayer.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesPayerFromJson(json);
}

/// `TripExpenseUserResponseDto`.
@freezed
abstract class TripExpensesUser with _$TripExpensesUser {
  const factory TripExpensesUser({
    required String id,
    required String username,
    String? avatarId,
  }) = _TripExpensesUser;

  factory TripExpensesUser.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesUserFromJson(json);
}

/// `TripExpenseListSplitDto` (overview feed) / settle payload without `member`.
@freezed
abstract class TripExpensesSplitEntry with _$TripExpensesSplitEntry {
  const factory TripExpensesSplitEntry({
    required String id,
    required String expenseId,
    required String tripMemberId,
    required String amount,
    required bool isSettled,
  }) = _TripExpensesSplitEntry;

  factory TripExpensesSplitEntry.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesSplitEntryFromJson(json);
}

/// `CreateExpenseDto` — `POST /trips/{tripId}/expenses`.
@freezed
abstract class CreateTripExpenseRequest with _$CreateTripExpenseRequest {
  const factory CreateTripExpenseRequest({
    required num amount,
    @Default(TripExpensesCurrency.vnd) TripExpensesCurrency currency,
    required TripExpensesCategory category,
    required TripExpensesSplitType splitType,
    String? description,
    String? payerTripMemberId,
    DateTime? spentAt,
    String? locationNote,
    @Default(<String>[]) List<String> receiptMediaIds,
    @Default(<CreateTripExpenseSplit>[]) List<CreateTripExpenseSplit> splits,
  }) = _CreateTripExpenseRequest;

  factory CreateTripExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTripExpenseRequestFromJson(json);
}

/// `ExpenseSplitDto`.
@freezed
abstract class CreateTripExpenseSplit with _$CreateTripExpenseSplit {
  const factory CreateTripExpenseSplit({
    required String tripMemberId,
    required num amount,
  }) = _CreateTripExpenseSplit;

  factory CreateTripExpenseSplit.fromJson(Map<String, dynamic> json) =>
      _$CreateTripExpenseSplitFromJson(json);
}

/// `TripExpenseResponseDto` — create expense response body (`data`).
@freezed
abstract class TripExpenseCreated with _$TripExpenseCreated {
  const factory TripExpenseCreated({
    required String id,
    required String tripId,
    required String payerId,
    required String amount,
    required TripExpensesCurrency currency,
    required TripExpensesCategory category,
    required TripExpensesSplitType splitType,
    String? description,
    required DateTime spentAt,
    String? locationNote,
    required DateTime createdAt,
    required TripExpensesMember payer,
    @Default(<TripExpenseCreatedSplit>[]) List<TripExpenseCreatedSplit> splits,
    @Default(<TripExpenseReceipt>[]) List<TripExpenseReceipt> receipts,
  }) = _TripExpenseCreated;

  factory TripExpenseCreated.fromJson(Map<String, dynamic> json) =>
      _$TripExpenseCreatedFromJson(json);
}

/// `TripExpenseMemberResponseDto`.
@freezed
abstract class TripExpensesMember with _$TripExpensesMember {
  const factory TripExpensesMember({
    required String id,
    required String userId,
    required TripExpensesUser user,
  }) = _TripExpensesMember;

  factory TripExpensesMember.fromJson(Map<String, dynamic> json) =>
      _$TripExpensesMemberFromJson(json);
}

/// `TripExpenseSplitResponseDto`.
@freezed
abstract class TripExpenseCreatedSplit with _$TripExpenseCreatedSplit {
  const factory TripExpenseCreatedSplit({
    required String id,
    required String expenseId,
    required String tripMemberId,
    required String amount,
    required bool isSettled,
    required TripExpensesMember member,
  }) = _TripExpenseCreatedSplit;

  factory TripExpenseCreatedSplit.fromJson(Map<String, dynamic> json) =>
      _$TripExpenseCreatedSplitFromJson(json);
}
