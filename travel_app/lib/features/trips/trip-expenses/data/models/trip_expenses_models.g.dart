// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_expenses_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripExpensesOverview _$TripExpensesOverviewFromJson(
  Map<String, dynamic> json,
) => _TripExpensesOverview(
  tripId: json['tripId'] as String,
  tripName: json['tripName'] as String,
  memberCount: (json['memberCount'] as num).toInt(),
  currency: $enumDecode(_$TripExpensesCurrencyEnumMap, json['currency']),
  viewerUserId: json['viewerUserId'] as String,
  summary: TripExpensesSummary.fromJson(
    json['summary'] as Map<String, dynamic>,
  ),
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map(
            (e) =>
                TripExpensesCategoryShare.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <TripExpensesCategoryShare>[],
  settlements:
      (json['settlements'] as List<dynamic>?)
          ?.map(
            (e) => TripExpensesSettlement.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <TripExpensesSettlement>[],
  expenses:
      (json['expenses'] as List<dynamic>?)
          ?.map((e) => TripExpensesEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripExpensesEntry>[],
);

Map<String, dynamic> _$TripExpensesOverviewToJson(
  _TripExpensesOverview instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'tripName': instance.tripName,
  'memberCount': instance.memberCount,
  'currency': _$TripExpensesCurrencyEnumMap[instance.currency]!,
  'viewerUserId': instance.viewerUserId,
  'summary': instance.summary,
  'categories': instance.categories,
  'settlements': instance.settlements,
  'expenses': instance.expenses,
};

const _$TripExpensesCurrencyEnumMap = {
  TripExpensesCurrency.vnd: 'VND',
  TripExpensesCurrency.usd: 'USD',
};

_TripExpensesSummary _$TripExpensesSummaryFromJson(Map<String, dynamic> json) =>
    _TripExpensesSummary(
      totalAmount: json['totalAmount'] as num,
      viewerPaidAmount: json['viewerPaidAmount'] as num,
      viewerNetBalance: json['viewerNetBalance'] as num,
    );

Map<String, dynamic> _$TripExpensesSummaryToJson(
  _TripExpensesSummary instance,
) => <String, dynamic>{
  'totalAmount': instance.totalAmount,
  'viewerPaidAmount': instance.viewerPaidAmount,
  'viewerNetBalance': instance.viewerNetBalance,
};

_TripExpensesCategoryShare _$TripExpensesCategoryShareFromJson(
  Map<String, dynamic> json,
) => _TripExpensesCategoryShare(
  category: $enumDecode(_$TripExpensesCategoryEnumMap, json['category']),
  amount: json['amount'] as num,
  percent: (json['percent'] as num).toInt(),
);

Map<String, dynamic> _$TripExpensesCategoryShareToJson(
  _TripExpensesCategoryShare instance,
) => <String, dynamic>{
  'category': _$TripExpensesCategoryEnumMap[instance.category]!,
  'amount': instance.amount,
  'percent': instance.percent,
};

const _$TripExpensesCategoryEnumMap = {
  TripExpensesCategory.food: 'FOOD',
  TripExpensesCategory.accommodation: 'ACCOMMODATION',
  TripExpensesCategory.transport: 'TRANSPORT',
  TripExpensesCategory.activity: 'ACTIVITY',
  TripExpensesCategory.shopping: 'SHOPPING',
  TripExpensesCategory.other: 'OTHER',
};

_TripExpensesSettlement _$TripExpensesSettlementFromJson(
  Map<String, dynamic> json,
) => _TripExpensesSettlement(
  id: json['id'] as String,
  fromMemberId: json['fromMemberId'] as String,
  fromDisplayName: json['fromDisplayName'] as String,
  fromInitials: json['fromInitials'] as String,
  fromIsViewer: json['fromIsViewer'] as bool? ?? false,
  toMemberId: json['toMemberId'] as String,
  toDisplayName: json['toDisplayName'] as String,
  toIsViewer: json['toIsViewer'] as bool,
  amount: json['amount'] as num,
  note: json['note'] as String?,
  status: $enumDecode(_$TripExpensesSettlementStatusEnumMap, json['status']),
  expenseId: json['expenseId'] as String?,
  splitId: json['splitId'] as String?,
);

Map<String, dynamic> _$TripExpensesSettlementToJson(
  _TripExpensesSettlement instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromMemberId': instance.fromMemberId,
  'fromDisplayName': instance.fromDisplayName,
  'fromInitials': instance.fromInitials,
  'fromIsViewer': instance.fromIsViewer,
  'toMemberId': instance.toMemberId,
  'toDisplayName': instance.toDisplayName,
  'toIsViewer': instance.toIsViewer,
  'amount': instance.amount,
  'note': instance.note,
  'status': _$TripExpensesSettlementStatusEnumMap[instance.status]!,
  'expenseId': instance.expenseId,
  'splitId': instance.splitId,
};

const _$TripExpensesSettlementStatusEnumMap = {
  TripExpensesSettlementStatus.actionable: 'ACTIONABLE',
  TripExpensesSettlementStatus.pending: 'PENDING',
};

_TripExpenseReceipt _$TripExpenseReceiptFromJson(Map<String, dynamic> json) =>
    _TripExpenseReceipt(
      mediaId: json['mediaId'] as String,
      url: json['url'] as String,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TripExpenseReceiptToJson(_TripExpenseReceipt instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'url': instance.url,
      'sortOrder': instance.sortOrder,
    };

_TripExpensesEntry _$TripExpensesEntryFromJson(Map<String, dynamic> json) =>
    _TripExpensesEntry(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      description: json['description'] as String?,
      amount: json['amount'] as String,
      currency: $enumDecode(_$TripExpensesCurrencyEnumMap, json['currency']),
      category: $enumDecode(_$TripExpensesCategoryEnumMap, json['category']),
      splitType: $enumDecode(_$TripExpensesSplitTypeEnumMap, json['splitType']),
      spentAt: DateTime.parse(json['spentAt'] as String),
      locationNote: json['locationNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      payerId: json['payerId'] as String,
      payerIsViewer: json['payerIsViewer'] as bool,
      payer: TripExpensesPayer.fromJson(json['payer'] as Map<String, dynamic>),
      splitCount: (json['splitCount'] as num).toInt(),
      amountPerPerson: json['amountPerPerson'] as num?,
      splitNote: json['splitNote'] as String?,
      settledCount: (json['settledCount'] as num).toInt(),
      status: $enumDecode(_$TripExpensesSettleStatusEnumMap, json['status']),
      splits:
          (json['splits'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TripExpensesSplitEntry.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripExpensesSplitEntry>[],
      receipts:
          (json['receipts'] as List<dynamic>?)
              ?.map(
                (e) => TripExpenseReceipt.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripExpenseReceipt>[],
    );

Map<String, dynamic> _$TripExpensesEntryToJson(_TripExpensesEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'description': instance.description,
      'amount': instance.amount,
      'currency': _$TripExpensesCurrencyEnumMap[instance.currency]!,
      'category': _$TripExpensesCategoryEnumMap[instance.category]!,
      'splitType': _$TripExpensesSplitTypeEnumMap[instance.splitType]!,
      'spentAt': instance.spentAt.toIso8601String(),
      'locationNote': instance.locationNote,
      'createdAt': instance.createdAt.toIso8601String(),
      'payerId': instance.payerId,
      'payerIsViewer': instance.payerIsViewer,
      'payer': instance.payer,
      'splitCount': instance.splitCount,
      'amountPerPerson': instance.amountPerPerson,
      'splitNote': instance.splitNote,
      'settledCount': instance.settledCount,
      'status': _$TripExpensesSettleStatusEnumMap[instance.status]!,
      'splits': instance.splits,
      'receipts': instance.receipts,
    };

const _$TripExpensesSplitTypeEnumMap = {
  TripExpensesSplitType.equal: 'EQUAL',
  TripExpensesSplitType.custom: 'CUSTOM',
};

const _$TripExpensesSettleStatusEnumMap = {
  TripExpensesSettleStatus.settled: 'SETTLED',
  TripExpensesSettleStatus.partial: 'PARTIAL',
  TripExpensesSettleStatus.pending: 'PENDING',
};

_TripExpensesPayer _$TripExpensesPayerFromJson(Map<String, dynamic> json) =>
    _TripExpensesPayer(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      title: json['title'] as String?,
      user: TripExpensesUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripExpensesPayerToJson(_TripExpensesPayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'title': instance.title,
      'user': instance.user,
    };

_TripExpensesUser _$TripExpensesUserFromJson(Map<String, dynamic> json) =>
    _TripExpensesUser(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarId: json['avatarId'] as String?,
    );

Map<String, dynamic> _$TripExpensesUserToJson(_TripExpensesUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarId': instance.avatarId,
    };

_TripExpensesSplitEntry _$TripExpensesSplitEntryFromJson(
  Map<String, dynamic> json,
) => _TripExpensesSplitEntry(
  id: json['id'] as String,
  expenseId: json['expenseId'] as String,
  tripMemberId: json['tripMemberId'] as String,
  amount: json['amount'] as String,
  isSettled: json['isSettled'] as bool,
);

Map<String, dynamic> _$TripExpensesSplitEntryToJson(
  _TripExpensesSplitEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'expenseId': instance.expenseId,
  'tripMemberId': instance.tripMemberId,
  'amount': instance.amount,
  'isSettled': instance.isSettled,
};

_CreateTripExpenseRequest _$CreateTripExpenseRequestFromJson(
  Map<String, dynamic> json,
) => _CreateTripExpenseRequest(
  amount: json['amount'] as num,
  currency:
      $enumDecodeNullable(_$TripExpensesCurrencyEnumMap, json['currency']) ??
      TripExpensesCurrency.vnd,
  category: $enumDecode(_$TripExpensesCategoryEnumMap, json['category']),
  splitType: $enumDecode(_$TripExpensesSplitTypeEnumMap, json['splitType']),
  description: json['description'] as String?,
  payerTripMemberId: json['payerTripMemberId'] as String?,
  spentAt: json['spentAt'] == null
      ? null
      : DateTime.parse(json['spentAt'] as String),
  locationNote: json['locationNote'] as String?,
  receiptMediaIds:
      (json['receiptMediaIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  splits:
      (json['splits'] as List<dynamic>?)
          ?.map(
            (e) => CreateTripExpenseSplit.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <CreateTripExpenseSplit>[],
);

Map<String, dynamic> _$CreateTripExpenseRequestToJson(
  _CreateTripExpenseRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': _$TripExpensesCurrencyEnumMap[instance.currency]!,
  'category': _$TripExpensesCategoryEnumMap[instance.category]!,
  'splitType': _$TripExpensesSplitTypeEnumMap[instance.splitType]!,
  'description': instance.description,
  'payerTripMemberId': instance.payerTripMemberId,
  'spentAt': instance.spentAt?.toIso8601String(),
  'locationNote': instance.locationNote,
  'receiptMediaIds': instance.receiptMediaIds,
  'splits': instance.splits,
};

_CreateTripExpenseSplit _$CreateTripExpenseSplitFromJson(
  Map<String, dynamic> json,
) => _CreateTripExpenseSplit(
  tripMemberId: json['tripMemberId'] as String,
  amount: json['amount'] as num,
);

Map<String, dynamic> _$CreateTripExpenseSplitToJson(
  _CreateTripExpenseSplit instance,
) => <String, dynamic>{
  'tripMemberId': instance.tripMemberId,
  'amount': instance.amount,
};

_TripExpenseCreated _$TripExpenseCreatedFromJson(Map<String, dynamic> json) =>
    _TripExpenseCreated(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      payerId: json['payerId'] as String,
      amount: json['amount'] as String,
      currency: $enumDecode(_$TripExpensesCurrencyEnumMap, json['currency']),
      category: $enumDecode(_$TripExpensesCategoryEnumMap, json['category']),
      splitType: $enumDecode(_$TripExpensesSplitTypeEnumMap, json['splitType']),
      description: json['description'] as String?,
      spentAt: DateTime.parse(json['spentAt'] as String),
      locationNote: json['locationNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      payer: TripExpensesMember.fromJson(json['payer'] as Map<String, dynamic>),
      splits:
          (json['splits'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TripExpenseCreatedSplit.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripExpenseCreatedSplit>[],
      receipts:
          (json['receipts'] as List<dynamic>?)
              ?.map(
                (e) => TripExpenseReceipt.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripExpenseReceipt>[],
    );

Map<String, dynamic> _$TripExpenseCreatedToJson(_TripExpenseCreated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'payerId': instance.payerId,
      'amount': instance.amount,
      'currency': _$TripExpensesCurrencyEnumMap[instance.currency]!,
      'category': _$TripExpensesCategoryEnumMap[instance.category]!,
      'splitType': _$TripExpensesSplitTypeEnumMap[instance.splitType]!,
      'description': instance.description,
      'spentAt': instance.spentAt.toIso8601String(),
      'locationNote': instance.locationNote,
      'createdAt': instance.createdAt.toIso8601String(),
      'payer': instance.payer,
      'splits': instance.splits,
      'receipts': instance.receipts,
    };

_TripExpensesMember _$TripExpensesMemberFromJson(Map<String, dynamic> json) =>
    _TripExpensesMember(
      id: json['id'] as String,
      userId: json['userId'] as String,
      user: TripExpensesUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripExpensesMemberToJson(_TripExpensesMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
    };

_TripExpenseCreatedSplit _$TripExpenseCreatedSplitFromJson(
  Map<String, dynamic> json,
) => _TripExpenseCreatedSplit(
  id: json['id'] as String,
  expenseId: json['expenseId'] as String,
  tripMemberId: json['tripMemberId'] as String,
  amount: json['amount'] as String,
  isSettled: json['isSettled'] as bool,
  member: TripExpensesMember.fromJson(json['member'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripExpenseCreatedSplitToJson(
  _TripExpenseCreatedSplit instance,
) => <String, dynamic>{
  'id': instance.id,
  'expenseId': instance.expenseId,
  'tripMemberId': instance.tripMemberId,
  'amount': instance.amount,
  'isSettled': instance.isSettled,
  'member': instance.member,
};
