// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_expenses_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripExpensesOverview {

 String get tripId; String get tripName; int get memberCount; TripExpensesCurrency get currency; String get viewerUserId; TripExpensesSummary get summary; List<TripExpensesCategoryShare> get categories; List<TripExpensesSettlement> get settlements; List<TripExpensesEntry> get expenses;
/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesOverviewCopyWith<TripExpensesOverview> get copyWith => _$TripExpensesOverviewCopyWithImpl<TripExpensesOverview>(this as TripExpensesOverview, _$identity);

  /// Serializes this TripExpensesOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesOverview&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.tripName, _this.tripName) || other.tripName == _this.tripName)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.viewerUserId, _this.viewerUserId) || other.viewerUserId == _this.viewerUserId)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.settlements, _this.settlements)&&const DeepCollectionEquality().equals(other.expenses, _this.expenses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesOverview;
  return Object.hash(runtimeType,_this.tripId,_this.tripName,_this.memberCount,_this.currency,_this.viewerUserId,_this.summary,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.settlements),const DeepCollectionEquality().hash(_this.expenses));
}

@override
String toString() {
  final _this = this as TripExpensesOverview;
  return 'TripExpensesOverview(tripId: ${_this.tripId}, tripName: ${_this.tripName}, memberCount: ${_this.memberCount}, currency: ${_this.currency}, viewerUserId: ${_this.viewerUserId}, summary: ${_this.summary}, categories: ${_this.categories}, settlements: ${_this.settlements}, expenses: ${_this.expenses})';
}


}

/// @nodoc
abstract mixin class $TripExpensesOverviewCopyWith<$Res>  {
  factory $TripExpensesOverviewCopyWith(TripExpensesOverview value, $Res Function(TripExpensesOverview) _then) = _$TripExpensesOverviewCopyWithImpl;
@useResult
$Res call({
 String tripId, String tripName, int memberCount, TripExpensesCurrency currency, String viewerUserId, TripExpensesSummary summary, List<TripExpensesCategoryShare> categories, List<TripExpensesSettlement> settlements, List<TripExpensesEntry> expenses
});


$TripExpensesSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$TripExpensesOverviewCopyWithImpl<$Res>
    implements $TripExpensesOverviewCopyWith<$Res> {
  _$TripExpensesOverviewCopyWithImpl(this._self, this._then);

  final TripExpensesOverview _self;
  final $Res Function(TripExpensesOverview) _then;

/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? tripName = null,Object? memberCount = null,Object? currency = null,Object? viewerUserId = null,Object? summary = null,Object? categories = null,Object? settlements = null,Object? expenses = null,}) {
  return _then(TripExpensesOverview(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,viewerUserId: null == viewerUserId ? _self.viewerUserId : viewerUserId // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TripExpensesSummary,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<TripExpensesCategoryShare>,settlements: null == settlements ? _self.settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<TripExpensesSettlement>,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<TripExpensesEntry>,
  ));
}
/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesSummaryCopyWith<$Res> get summary {
  
  return $TripExpensesSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpensesOverview].
extension TripExpensesOverviewPatterns on TripExpensesOverview {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesOverview() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesOverview value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesOverview():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesOverview value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesOverview() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String tripName,  int memberCount,  TripExpensesCurrency currency,  String viewerUserId,  TripExpensesSummary summary,  List<TripExpensesCategoryShare> categories,  List<TripExpensesSettlement> settlements,  List<TripExpensesEntry> expenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesOverview() when $default != null:
return $default(_that.tripId,_that.tripName,_that.memberCount,_that.currency,_that.viewerUserId,_that.summary,_that.categories,_that.settlements,_that.expenses);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String tripName,  int memberCount,  TripExpensesCurrency currency,  String viewerUserId,  TripExpensesSummary summary,  List<TripExpensesCategoryShare> categories,  List<TripExpensesSettlement> settlements,  List<TripExpensesEntry> expenses)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesOverview():
return $default(_that.tripId,_that.tripName,_that.memberCount,_that.currency,_that.viewerUserId,_that.summary,_that.categories,_that.settlements,_that.expenses);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String tripName,  int memberCount,  TripExpensesCurrency currency,  String viewerUserId,  TripExpensesSummary summary,  List<TripExpensesCategoryShare> categories,  List<TripExpensesSettlement> settlements,  List<TripExpensesEntry> expenses)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesOverview() when $default != null:
return $default(_that.tripId,_that.tripName,_that.memberCount,_that.currency,_that.viewerUserId,_that.summary,_that.categories,_that.settlements,_that.expenses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesOverview implements TripExpensesOverview {
  const _TripExpensesOverview({required this.tripId, required this.tripName, required this.memberCount, required this.currency, required this.viewerUserId, required this.summary,  List<TripExpensesCategoryShare> categories = const <TripExpensesCategoryShare>[],  List<TripExpensesSettlement> settlements = const <TripExpensesSettlement>[],  List<TripExpensesEntry> expenses = const <TripExpensesEntry>[]}): _categories = categories,_settlements = settlements,_expenses = expenses;
  factory _TripExpensesOverview.fromJson(Map<String, dynamic> json) => _$TripExpensesOverviewFromJson(json);

@override final  String tripId;
@override final  String tripName;
@override final  int memberCount;
@override final  TripExpensesCurrency currency;
@override final  String viewerUserId;
@override final  TripExpensesSummary summary;
 final  List<TripExpensesCategoryShare> _categories;
@override@JsonKey() List<TripExpensesCategoryShare> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<TripExpensesSettlement> _settlements;
@override@JsonKey() List<TripExpensesSettlement> get settlements {
  if (_settlements is EqualUnmodifiableListView) return _settlements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settlements);
}

 final  List<TripExpensesEntry> _expenses;
@override@JsonKey() List<TripExpensesEntry> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}


/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesOverviewCopyWith<_TripExpensesOverview> get copyWith => __$TripExpensesOverviewCopyWithImpl<_TripExpensesOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesOverview&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripName, tripName) || other.tripName == tripName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.viewerUserId, viewerUserId) || other.viewerUserId == viewerUserId)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.settlements, _settlements)&&const DeepCollectionEquality().equals(other.expenses, _expenses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,tripName,memberCount,currency,viewerUserId,summary,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_settlements),const DeepCollectionEquality().hash(_expenses));
}

@override
String toString() {
    return 'TripExpensesOverview(tripId: $tripId, tripName: $tripName, memberCount: $memberCount, currency: $currency, viewerUserId: $viewerUserId, summary: $summary, categories: $categories, settlements: $settlements, expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesOverviewCopyWith<$Res> implements $TripExpensesOverviewCopyWith<$Res> {
  factory _$TripExpensesOverviewCopyWith(_TripExpensesOverview value, $Res Function(_TripExpensesOverview) _then) = __$TripExpensesOverviewCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String tripName, int memberCount, TripExpensesCurrency currency, String viewerUserId, TripExpensesSummary summary, List<TripExpensesCategoryShare> categories, List<TripExpensesSettlement> settlements, List<TripExpensesEntry> expenses
});


@override $TripExpensesSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$TripExpensesOverviewCopyWithImpl<$Res>
    implements _$TripExpensesOverviewCopyWith<$Res> {
  __$TripExpensesOverviewCopyWithImpl(this._self, this._then);

  final _TripExpensesOverview _self;
  final $Res Function(_TripExpensesOverview) _then;

/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? tripName = null,Object? memberCount = null,Object? currency = null,Object? viewerUserId = null,Object? summary = null,Object? categories = null,Object? settlements = null,Object? expenses = null,}) {
  return _then(_TripExpensesOverview(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,viewerUserId: null == viewerUserId ? _self.viewerUserId : viewerUserId // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TripExpensesSummary,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<TripExpensesCategoryShare>,settlements: null == settlements ? _self._settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<TripExpensesSettlement>,expenses: null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<TripExpensesEntry>,
  ));
}

/// Create a copy of TripExpensesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesSummaryCopyWith<$Res> get summary {
  
  return $TripExpensesSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$TripExpensesSummary {

 num get totalAmount; num get viewerPaidAmount;/// Positive = viewer should receive; negative = viewer still owes.
 num get viewerNetBalance;
/// Create a copy of TripExpensesSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesSummaryCopyWith<TripExpensesSummary> get copyWith => _$TripExpensesSummaryCopyWithImpl<TripExpensesSummary>(this as TripExpensesSummary, _$identity);

  /// Serializes this TripExpensesSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesSummary&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount)&&(identical(other.viewerPaidAmount, _this.viewerPaidAmount) || other.viewerPaidAmount == _this.viewerPaidAmount)&&(identical(other.viewerNetBalance, _this.viewerNetBalance) || other.viewerNetBalance == _this.viewerNetBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesSummary;
  return Object.hash(runtimeType,_this.totalAmount,_this.viewerPaidAmount,_this.viewerNetBalance);
}

@override
String toString() {
  final _this = this as TripExpensesSummary;
  return 'TripExpensesSummary(totalAmount: ${_this.totalAmount}, viewerPaidAmount: ${_this.viewerPaidAmount}, viewerNetBalance: ${_this.viewerNetBalance})';
}


}

/// @nodoc
abstract mixin class $TripExpensesSummaryCopyWith<$Res>  {
  factory $TripExpensesSummaryCopyWith(TripExpensesSummary value, $Res Function(TripExpensesSummary) _then) = _$TripExpensesSummaryCopyWithImpl;
@useResult
$Res call({
 num totalAmount, num viewerPaidAmount, num viewerNetBalance
});




}
/// @nodoc
class _$TripExpensesSummaryCopyWithImpl<$Res>
    implements $TripExpensesSummaryCopyWith<$Res> {
  _$TripExpensesSummaryCopyWithImpl(this._self, this._then);

  final TripExpensesSummary _self;
  final $Res Function(TripExpensesSummary) _then;

/// Create a copy of TripExpensesSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAmount = null,Object? viewerPaidAmount = null,Object? viewerNetBalance = null,}) {
  return _then(TripExpensesSummary(
totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num,viewerPaidAmount: null == viewerPaidAmount ? _self.viewerPaidAmount : viewerPaidAmount // ignore: cast_nullable_to_non_nullable
as num,viewerNetBalance: null == viewerNetBalance ? _self.viewerNetBalance : viewerNetBalance // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpensesSummary].
extension TripExpensesSummaryPatterns on TripExpensesSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesSummary value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num totalAmount,  num viewerPaidAmount,  num viewerNetBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesSummary() when $default != null:
return $default(_that.totalAmount,_that.viewerPaidAmount,_that.viewerNetBalance);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num totalAmount,  num viewerPaidAmount,  num viewerNetBalance)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSummary():
return $default(_that.totalAmount,_that.viewerPaidAmount,_that.viewerNetBalance);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num totalAmount,  num viewerPaidAmount,  num viewerNetBalance)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSummary() when $default != null:
return $default(_that.totalAmount,_that.viewerPaidAmount,_that.viewerNetBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesSummary implements TripExpensesSummary {
  const _TripExpensesSummary({required this.totalAmount, required this.viewerPaidAmount, required this.viewerNetBalance});
  factory _TripExpensesSummary.fromJson(Map<String, dynamic> json) => _$TripExpensesSummaryFromJson(json);

@override final  num totalAmount;
@override final  num viewerPaidAmount;
/// Positive = viewer should receive; negative = viewer still owes.
@override final  num viewerNetBalance;

/// Create a copy of TripExpensesSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesSummaryCopyWith<_TripExpensesSummary> get copyWith => __$TripExpensesSummaryCopyWithImpl<_TripExpensesSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesSummary&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.viewerPaidAmount, viewerPaidAmount) || other.viewerPaidAmount == viewerPaidAmount)&&(identical(other.viewerNetBalance, viewerNetBalance) || other.viewerNetBalance == viewerNetBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalAmount,viewerPaidAmount,viewerNetBalance);
}

@override
String toString() {
    return 'TripExpensesSummary(totalAmount: $totalAmount, viewerPaidAmount: $viewerPaidAmount, viewerNetBalance: $viewerNetBalance)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesSummaryCopyWith<$Res> implements $TripExpensesSummaryCopyWith<$Res> {
  factory _$TripExpensesSummaryCopyWith(_TripExpensesSummary value, $Res Function(_TripExpensesSummary) _then) = __$TripExpensesSummaryCopyWithImpl;
@override @useResult
$Res call({
 num totalAmount, num viewerPaidAmount, num viewerNetBalance
});




}
/// @nodoc
class __$TripExpensesSummaryCopyWithImpl<$Res>
    implements _$TripExpensesSummaryCopyWith<$Res> {
  __$TripExpensesSummaryCopyWithImpl(this._self, this._then);

  final _TripExpensesSummary _self;
  final $Res Function(_TripExpensesSummary) _then;

/// Create a copy of TripExpensesSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAmount = null,Object? viewerPaidAmount = null,Object? viewerNetBalance = null,}) {
  return _then(_TripExpensesSummary(
totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num,viewerPaidAmount: null == viewerPaidAmount ? _self.viewerPaidAmount : viewerPaidAmount // ignore: cast_nullable_to_non_nullable
as num,viewerNetBalance: null == viewerNetBalance ? _self.viewerNetBalance : viewerNetBalance // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$TripExpensesCategoryShare {

 TripExpensesCategory get category; num get amount; int get percent;
/// Create a copy of TripExpensesCategoryShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesCategoryShareCopyWith<TripExpensesCategoryShare> get copyWith => _$TripExpensesCategoryShareCopyWithImpl<TripExpensesCategoryShare>(this as TripExpensesCategoryShare, _$identity);

  /// Serializes this TripExpensesCategoryShare to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesCategoryShare;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesCategoryShare&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.percent, _this.percent) || other.percent == _this.percent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesCategoryShare;
  return Object.hash(runtimeType,_this.category,_this.amount,_this.percent);
}

@override
String toString() {
  final _this = this as TripExpensesCategoryShare;
  return 'TripExpensesCategoryShare(category: ${_this.category}, amount: ${_this.amount}, percent: ${_this.percent})';
}


}

/// @nodoc
abstract mixin class $TripExpensesCategoryShareCopyWith<$Res>  {
  factory $TripExpensesCategoryShareCopyWith(TripExpensesCategoryShare value, $Res Function(TripExpensesCategoryShare) _then) = _$TripExpensesCategoryShareCopyWithImpl;
@useResult
$Res call({
 TripExpensesCategory category, num amount, int percent
});




}
/// @nodoc
class _$TripExpensesCategoryShareCopyWithImpl<$Res>
    implements $TripExpensesCategoryShareCopyWith<$Res> {
  _$TripExpensesCategoryShareCopyWithImpl(this._self, this._then);

  final TripExpensesCategoryShare _self;
  final $Res Function(TripExpensesCategoryShare) _then;

/// Create a copy of TripExpensesCategoryShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? amount = null,Object? percent = null,}) {
  return _then(TripExpensesCategoryShare(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpensesCategoryShare].
extension TripExpensesCategorySharePatterns on TripExpensesCategoryShare {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesCategoryShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesCategoryShare() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesCategoryShare value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesCategoryShare():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesCategoryShare value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesCategoryShare() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripExpensesCategory category,  num amount,  int percent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesCategoryShare() when $default != null:
return $default(_that.category,_that.amount,_that.percent);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripExpensesCategory category,  num amount,  int percent)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesCategoryShare():
return $default(_that.category,_that.amount,_that.percent);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripExpensesCategory category,  num amount,  int percent)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesCategoryShare() when $default != null:
return $default(_that.category,_that.amount,_that.percent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesCategoryShare implements TripExpensesCategoryShare {
  const _TripExpensesCategoryShare({required this.category, required this.amount, required this.percent});
  factory _TripExpensesCategoryShare.fromJson(Map<String, dynamic> json) => _$TripExpensesCategoryShareFromJson(json);

@override final  TripExpensesCategory category;
@override final  num amount;
@override final  int percent;

/// Create a copy of TripExpensesCategoryShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesCategoryShareCopyWith<_TripExpensesCategoryShare> get copyWith => __$TripExpensesCategoryShareCopyWithImpl<_TripExpensesCategoryShare>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesCategoryShareToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesCategoryShare&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.percent, percent) || other.percent == percent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,category,amount,percent);
}

@override
String toString() {
    return 'TripExpensesCategoryShare(category: $category, amount: $amount, percent: $percent)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesCategoryShareCopyWith<$Res> implements $TripExpensesCategoryShareCopyWith<$Res> {
  factory _$TripExpensesCategoryShareCopyWith(_TripExpensesCategoryShare value, $Res Function(_TripExpensesCategoryShare) _then) = __$TripExpensesCategoryShareCopyWithImpl;
@override @useResult
$Res call({
 TripExpensesCategory category, num amount, int percent
});




}
/// @nodoc
class __$TripExpensesCategoryShareCopyWithImpl<$Res>
    implements _$TripExpensesCategoryShareCopyWith<$Res> {
  __$TripExpensesCategoryShareCopyWithImpl(this._self, this._then);

  final _TripExpensesCategoryShare _self;
  final $Res Function(_TripExpensesCategoryShare) _then;

/// Create a copy of TripExpensesCategoryShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? amount = null,Object? percent = null,}) {
  return _then(_TripExpensesCategoryShare(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripExpensesSettlement {

 String get id; String get fromMemberId; String get fromDisplayName; String get fromInitials; bool get fromIsViewer; String get toMemberId; String get toDisplayName; bool get toIsViewer; num get amount; String? get note; TripExpensesSettlementStatus get status; String? get expenseId; String? get splitId;
/// Create a copy of TripExpensesSettlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesSettlementCopyWith<TripExpensesSettlement> get copyWith => _$TripExpensesSettlementCopyWithImpl<TripExpensesSettlement>(this as TripExpensesSettlement, _$identity);

  /// Serializes this TripExpensesSettlement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesSettlement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesSettlement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fromMemberId, _this.fromMemberId) || other.fromMemberId == _this.fromMemberId)&&(identical(other.fromDisplayName, _this.fromDisplayName) || other.fromDisplayName == _this.fromDisplayName)&&(identical(other.fromInitials, _this.fromInitials) || other.fromInitials == _this.fromInitials)&&(identical(other.fromIsViewer, _this.fromIsViewer) || other.fromIsViewer == _this.fromIsViewer)&&(identical(other.toMemberId, _this.toMemberId) || other.toMemberId == _this.toMemberId)&&(identical(other.toDisplayName, _this.toDisplayName) || other.toDisplayName == _this.toDisplayName)&&(identical(other.toIsViewer, _this.toIsViewer) || other.toIsViewer == _this.toIsViewer)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.expenseId, _this.expenseId) || other.expenseId == _this.expenseId)&&(identical(other.splitId, _this.splitId) || other.splitId == _this.splitId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesSettlement;
  return Object.hash(runtimeType,_this.id,_this.fromMemberId,_this.fromDisplayName,_this.fromInitials,_this.fromIsViewer,_this.toMemberId,_this.toDisplayName,_this.toIsViewer,_this.amount,_this.note,_this.status,_this.expenseId,_this.splitId);
}

@override
String toString() {
  final _this = this as TripExpensesSettlement;
  return 'TripExpensesSettlement(id: ${_this.id}, fromMemberId: ${_this.fromMemberId}, fromDisplayName: ${_this.fromDisplayName}, fromInitials: ${_this.fromInitials}, fromIsViewer: ${_this.fromIsViewer}, toMemberId: ${_this.toMemberId}, toDisplayName: ${_this.toDisplayName}, toIsViewer: ${_this.toIsViewer}, amount: ${_this.amount}, note: ${_this.note}, status: ${_this.status}, expenseId: ${_this.expenseId}, splitId: ${_this.splitId})';
}


}

/// @nodoc
abstract mixin class $TripExpensesSettlementCopyWith<$Res>  {
  factory $TripExpensesSettlementCopyWith(TripExpensesSettlement value, $Res Function(TripExpensesSettlement) _then) = _$TripExpensesSettlementCopyWithImpl;
@useResult
$Res call({
 String id, String fromMemberId, String fromDisplayName, String fromInitials, bool fromIsViewer, String toMemberId, String toDisplayName, bool toIsViewer, num amount, String? note, TripExpensesSettlementStatus status, String? expenseId, String? splitId
});




}
/// @nodoc
class _$TripExpensesSettlementCopyWithImpl<$Res>
    implements $TripExpensesSettlementCopyWith<$Res> {
  _$TripExpensesSettlementCopyWithImpl(this._self, this._then);

  final TripExpensesSettlement _self;
  final $Res Function(TripExpensesSettlement) _then;

/// Create a copy of TripExpensesSettlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromMemberId = null,Object? fromDisplayName = null,Object? fromInitials = null,Object? fromIsViewer = null,Object? toMemberId = null,Object? toDisplayName = null,Object? toIsViewer = null,Object? amount = null,Object? note = freezed,Object? status = null,Object? expenseId = freezed,Object? splitId = freezed,}) {
  return _then(TripExpensesSettlement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMemberId: null == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String,fromDisplayName: null == fromDisplayName ? _self.fromDisplayName : fromDisplayName // ignore: cast_nullable_to_non_nullable
as String,fromInitials: null == fromInitials ? _self.fromInitials : fromInitials // ignore: cast_nullable_to_non_nullable
as String,fromIsViewer: null == fromIsViewer ? _self.fromIsViewer : fromIsViewer // ignore: cast_nullable_to_non_nullable
as bool,toMemberId: null == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String,toDisplayName: null == toDisplayName ? _self.toDisplayName : toDisplayName // ignore: cast_nullable_to_non_nullable
as String,toIsViewer: null == toIsViewer ? _self.toIsViewer : toIsViewer // ignore: cast_nullable_to_non_nullable
as bool,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripExpensesSettlementStatus,expenseId: freezed == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String?,splitId: freezed == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpensesSettlement].
extension TripExpensesSettlementPatterns on TripExpensesSettlement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesSettlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesSettlement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesSettlement value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSettlement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesSettlement value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSettlement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromMemberId,  String fromDisplayName,  String fromInitials,  bool fromIsViewer,  String toMemberId,  String toDisplayName,  bool toIsViewer,  num amount,  String? note,  TripExpensesSettlementStatus status,  String? expenseId,  String? splitId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesSettlement() when $default != null:
return $default(_that.id,_that.fromMemberId,_that.fromDisplayName,_that.fromInitials,_that.fromIsViewer,_that.toMemberId,_that.toDisplayName,_that.toIsViewer,_that.amount,_that.note,_that.status,_that.expenseId,_that.splitId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromMemberId,  String fromDisplayName,  String fromInitials,  bool fromIsViewer,  String toMemberId,  String toDisplayName,  bool toIsViewer,  num amount,  String? note,  TripExpensesSettlementStatus status,  String? expenseId,  String? splitId)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSettlement():
return $default(_that.id,_that.fromMemberId,_that.fromDisplayName,_that.fromInitials,_that.fromIsViewer,_that.toMemberId,_that.toDisplayName,_that.toIsViewer,_that.amount,_that.note,_that.status,_that.expenseId,_that.splitId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromMemberId,  String fromDisplayName,  String fromInitials,  bool fromIsViewer,  String toMemberId,  String toDisplayName,  bool toIsViewer,  num amount,  String? note,  TripExpensesSettlementStatus status,  String? expenseId,  String? splitId)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSettlement() when $default != null:
return $default(_that.id,_that.fromMemberId,_that.fromDisplayName,_that.fromInitials,_that.fromIsViewer,_that.toMemberId,_that.toDisplayName,_that.toIsViewer,_that.amount,_that.note,_that.status,_that.expenseId,_that.splitId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesSettlement implements TripExpensesSettlement {
  const _TripExpensesSettlement({required this.id, required this.fromMemberId, required this.fromDisplayName, required this.fromInitials, this.fromIsViewer = false, required this.toMemberId, required this.toDisplayName, required this.toIsViewer, required this.amount, this.note, required this.status, this.expenseId, this.splitId});
  factory _TripExpensesSettlement.fromJson(Map<String, dynamic> json) => _$TripExpensesSettlementFromJson(json);

@override final  String id;
@override final  String fromMemberId;
@override final  String fromDisplayName;
@override final  String fromInitials;
@override@JsonKey() final  bool fromIsViewer;
@override final  String toMemberId;
@override final  String toDisplayName;
@override final  bool toIsViewer;
@override final  num amount;
@override final  String? note;
@override final  TripExpensesSettlementStatus status;
@override final  String? expenseId;
@override final  String? splitId;

/// Create a copy of TripExpensesSettlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesSettlementCopyWith<_TripExpensesSettlement> get copyWith => __$TripExpensesSettlementCopyWithImpl<_TripExpensesSettlement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesSettlementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesSettlement&&(identical(other.id, id) || other.id == id)&&(identical(other.fromMemberId, fromMemberId) || other.fromMemberId == fromMemberId)&&(identical(other.fromDisplayName, fromDisplayName) || other.fromDisplayName == fromDisplayName)&&(identical(other.fromInitials, fromInitials) || other.fromInitials == fromInitials)&&(identical(other.fromIsViewer, fromIsViewer) || other.fromIsViewer == fromIsViewer)&&(identical(other.toMemberId, toMemberId) || other.toMemberId == toMemberId)&&(identical(other.toDisplayName, toDisplayName) || other.toDisplayName == toDisplayName)&&(identical(other.toIsViewer, toIsViewer) || other.toIsViewer == toIsViewer)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note)&&(identical(other.status, status) || other.status == status)&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.splitId, splitId) || other.splitId == splitId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,fromMemberId,fromDisplayName,fromInitials,fromIsViewer,toMemberId,toDisplayName,toIsViewer,amount,note,status,expenseId,splitId);
}

@override
String toString() {
    return 'TripExpensesSettlement(id: $id, fromMemberId: $fromMemberId, fromDisplayName: $fromDisplayName, fromInitials: $fromInitials, fromIsViewer: $fromIsViewer, toMemberId: $toMemberId, toDisplayName: $toDisplayName, toIsViewer: $toIsViewer, amount: $amount, note: $note, status: $status, expenseId: $expenseId, splitId: $splitId)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesSettlementCopyWith<$Res> implements $TripExpensesSettlementCopyWith<$Res> {
  factory _$TripExpensesSettlementCopyWith(_TripExpensesSettlement value, $Res Function(_TripExpensesSettlement) _then) = __$TripExpensesSettlementCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromMemberId, String fromDisplayName, String fromInitials, bool fromIsViewer, String toMemberId, String toDisplayName, bool toIsViewer, num amount, String? note, TripExpensesSettlementStatus status, String? expenseId, String? splitId
});




}
/// @nodoc
class __$TripExpensesSettlementCopyWithImpl<$Res>
    implements _$TripExpensesSettlementCopyWith<$Res> {
  __$TripExpensesSettlementCopyWithImpl(this._self, this._then);

  final _TripExpensesSettlement _self;
  final $Res Function(_TripExpensesSettlement) _then;

/// Create a copy of TripExpensesSettlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromMemberId = null,Object? fromDisplayName = null,Object? fromInitials = null,Object? fromIsViewer = null,Object? toMemberId = null,Object? toDisplayName = null,Object? toIsViewer = null,Object? amount = null,Object? note = freezed,Object? status = null,Object? expenseId = freezed,Object? splitId = freezed,}) {
  return _then(_TripExpensesSettlement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMemberId: null == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String,fromDisplayName: null == fromDisplayName ? _self.fromDisplayName : fromDisplayName // ignore: cast_nullable_to_non_nullable
as String,fromInitials: null == fromInitials ? _self.fromInitials : fromInitials // ignore: cast_nullable_to_non_nullable
as String,fromIsViewer: null == fromIsViewer ? _self.fromIsViewer : fromIsViewer // ignore: cast_nullable_to_non_nullable
as bool,toMemberId: null == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String,toDisplayName: null == toDisplayName ? _self.toDisplayName : toDisplayName // ignore: cast_nullable_to_non_nullable
as String,toIsViewer: null == toIsViewer ? _self.toIsViewer : toIsViewer // ignore: cast_nullable_to_non_nullable
as bool,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripExpensesSettlementStatus,expenseId: freezed == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String?,splitId: freezed == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripExpenseReceipt {

 String get mediaId; String get url; int get sortOrder;
/// Create a copy of TripExpenseReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpenseReceiptCopyWith<TripExpenseReceipt> get copyWith => _$TripExpenseReceiptCopyWithImpl<TripExpenseReceipt>(this as TripExpenseReceipt, _$identity);

  /// Serializes this TripExpenseReceipt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpenseReceipt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpenseReceipt&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpenseReceipt;
  return Object.hash(runtimeType,_this.mediaId,_this.url,_this.sortOrder);
}

@override
String toString() {
  final _this = this as TripExpenseReceipt;
  return 'TripExpenseReceipt(mediaId: ${_this.mediaId}, url: ${_this.url}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $TripExpenseReceiptCopyWith<$Res>  {
  factory $TripExpenseReceiptCopyWith(TripExpenseReceipt value, $Res Function(TripExpenseReceipt) _then) = _$TripExpenseReceiptCopyWithImpl;
@useResult
$Res call({
 String mediaId, String url, int sortOrder
});




}
/// @nodoc
class _$TripExpenseReceiptCopyWithImpl<$Res>
    implements $TripExpenseReceiptCopyWith<$Res> {
  _$TripExpenseReceiptCopyWithImpl(this._self, this._then);

  final TripExpenseReceipt _self;
  final $Res Function(TripExpenseReceipt) _then;

/// Create a copy of TripExpenseReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? url = null,Object? sortOrder = null,}) {
  return _then(TripExpenseReceipt(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpenseReceipt].
extension TripExpenseReceiptPatterns on TripExpenseReceipt {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpenseReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpenseReceipt() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpenseReceipt value)  $default,){
final _that = this;
switch (_that) {
case _TripExpenseReceipt():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpenseReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpenseReceipt() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId,  String url,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpenseReceipt() when $default != null:
return $default(_that.mediaId,_that.url,_that.sortOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId,  String url,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _TripExpenseReceipt():
return $default(_that.mediaId,_that.url,_that.sortOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId,  String url,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _TripExpenseReceipt() when $default != null:
return $default(_that.mediaId,_that.url,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpenseReceipt implements TripExpenseReceipt {
  const _TripExpenseReceipt({required this.mediaId, required this.url, this.sortOrder = 0});
  factory _TripExpenseReceipt.fromJson(Map<String, dynamic> json) => _$TripExpenseReceiptFromJson(json);

@override final  String mediaId;
@override final  String url;
@override@JsonKey() final  int sortOrder;

/// Create a copy of TripExpenseReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpenseReceiptCopyWith<_TripExpenseReceipt> get copyWith => __$TripExpenseReceiptCopyWithImpl<_TripExpenseReceipt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpenseReceiptToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpenseReceipt&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.url, url) || other.url == url)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,url,sortOrder);
}

@override
String toString() {
    return 'TripExpenseReceipt(mediaId: $mediaId, url: $url, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$TripExpenseReceiptCopyWith<$Res> implements $TripExpenseReceiptCopyWith<$Res> {
  factory _$TripExpenseReceiptCopyWith(_TripExpenseReceipt value, $Res Function(_TripExpenseReceipt) _then) = __$TripExpenseReceiptCopyWithImpl;
@override @useResult
$Res call({
 String mediaId, String url, int sortOrder
});




}
/// @nodoc
class __$TripExpenseReceiptCopyWithImpl<$Res>
    implements _$TripExpenseReceiptCopyWith<$Res> {
  __$TripExpenseReceiptCopyWithImpl(this._self, this._then);

  final _TripExpenseReceipt _self;
  final $Res Function(_TripExpenseReceipt) _then;

/// Create a copy of TripExpenseReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? url = null,Object? sortOrder = null,}) {
  return _then(_TripExpenseReceipt(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripExpensesEntry {

 String get id; String get tripId; String? get description; String get amount; TripExpensesCurrency get currency; TripExpensesCategory get category; TripExpensesSplitType get splitType; DateTime get spentAt; String? get locationNote; DateTime get createdAt; String get payerId; bool get payerIsViewer; TripExpensesPayer get payer; int get splitCount; num? get amountPerPerson; String? get splitNote; int get settledCount; TripExpensesSettleStatus get status; List<TripExpensesSplitEntry> get splits; List<TripExpenseReceipt> get receipts;
/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesEntryCopyWith<TripExpensesEntry> get copyWith => _$TripExpensesEntryCopyWithImpl<TripExpensesEntry>(this as TripExpensesEntry, _$identity);

  /// Serializes this TripExpensesEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.splitType, _this.splitType) || other.splitType == _this.splitType)&&(identical(other.spentAt, _this.spentAt) || other.spentAt == _this.spentAt)&&(identical(other.locationNote, _this.locationNote) || other.locationNote == _this.locationNote)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.payerId, _this.payerId) || other.payerId == _this.payerId)&&(identical(other.payerIsViewer, _this.payerIsViewer) || other.payerIsViewer == _this.payerIsViewer)&&(identical(other.payer, _this.payer) || other.payer == _this.payer)&&(identical(other.splitCount, _this.splitCount) || other.splitCount == _this.splitCount)&&(identical(other.amountPerPerson, _this.amountPerPerson) || other.amountPerPerson == _this.amountPerPerson)&&(identical(other.splitNote, _this.splitNote) || other.splitNote == _this.splitNote)&&(identical(other.settledCount, _this.settledCount) || other.settledCount == _this.settledCount)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.splits, _this.splits)&&const DeepCollectionEquality().equals(other.receipts, _this.receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesEntry;
  return Object.hashAll([runtimeType,_this.id,_this.tripId,_this.description,_this.amount,_this.currency,_this.category,_this.splitType,_this.spentAt,_this.locationNote,_this.createdAt,_this.payerId,_this.payerIsViewer,_this.payer,_this.splitCount,_this.amountPerPerson,_this.splitNote,_this.settledCount,_this.status,const DeepCollectionEquality().hash(_this.splits),const DeepCollectionEquality().hash(_this.receipts)]);
}

@override
String toString() {
  final _this = this as TripExpensesEntry;
  return 'TripExpensesEntry(id: ${_this.id}, tripId: ${_this.tripId}, description: ${_this.description}, amount: ${_this.amount}, currency: ${_this.currency}, category: ${_this.category}, splitType: ${_this.splitType}, spentAt: ${_this.spentAt}, locationNote: ${_this.locationNote}, createdAt: ${_this.createdAt}, payerId: ${_this.payerId}, payerIsViewer: ${_this.payerIsViewer}, payer: ${_this.payer}, splitCount: ${_this.splitCount}, amountPerPerson: ${_this.amountPerPerson}, splitNote: ${_this.splitNote}, settledCount: ${_this.settledCount}, status: ${_this.status}, splits: ${_this.splits}, receipts: ${_this.receipts})';
}


}

/// @nodoc
abstract mixin class $TripExpensesEntryCopyWith<$Res>  {
  factory $TripExpensesEntryCopyWith(TripExpensesEntry value, $Res Function(TripExpensesEntry) _then) = _$TripExpensesEntryCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String? description, String amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, DateTime spentAt, String? locationNote, DateTime createdAt, String payerId, bool payerIsViewer, TripExpensesPayer payer, int splitCount, num? amountPerPerson, String? splitNote, int settledCount, TripExpensesSettleStatus status, List<TripExpensesSplitEntry> splits, List<TripExpenseReceipt> receipts
});


$TripExpensesPayerCopyWith<$Res> get payer;

}
/// @nodoc
class _$TripExpensesEntryCopyWithImpl<$Res>
    implements $TripExpensesEntryCopyWith<$Res> {
  _$TripExpensesEntryCopyWithImpl(this._self, this._then);

  final TripExpensesEntry _self;
  final $Res Function(TripExpensesEntry) _then;

/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? description = freezed,Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? spentAt = null,Object? locationNote = freezed,Object? createdAt = null,Object? payerId = null,Object? payerIsViewer = null,Object? payer = null,Object? splitCount = null,Object? amountPerPerson = freezed,Object? splitNote = freezed,Object? settledCount = null,Object? status = null,Object? splits = null,Object? receipts = null,}) {
  return _then(TripExpensesEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,payerIsViewer: null == payerIsViewer ? _self.payerIsViewer : payerIsViewer // ignore: cast_nullable_to_non_nullable
as bool,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as TripExpensesPayer,splitCount: null == splitCount ? _self.splitCount : splitCount // ignore: cast_nullable_to_non_nullable
as int,amountPerPerson: freezed == amountPerPerson ? _self.amountPerPerson : amountPerPerson // ignore: cast_nullable_to_non_nullable
as num?,splitNote: freezed == splitNote ? _self.splitNote : splitNote // ignore: cast_nullable_to_non_nullable
as String?,settledCount: null == settledCount ? _self.settledCount : settledCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripExpensesSettleStatus,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<TripExpensesSplitEntry>,receipts: null == receipts ? _self.receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<TripExpenseReceipt>,
  ));
}
/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesPayerCopyWith<$Res> get payer {
  
  return $TripExpensesPayerCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpensesEntry].
extension TripExpensesEntryPatterns on TripExpensesEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesEntry value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String? description,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  String payerId,  bool payerIsViewer,  TripExpensesPayer payer,  int splitCount,  num? amountPerPerson,  String? splitNote,  int settledCount,  TripExpensesSettleStatus status,  List<TripExpensesSplitEntry> splits,  List<TripExpenseReceipt> receipts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.description,_that.amount,_that.currency,_that.category,_that.splitType,_that.spentAt,_that.locationNote,_that.createdAt,_that.payerId,_that.payerIsViewer,_that.payer,_that.splitCount,_that.amountPerPerson,_that.splitNote,_that.settledCount,_that.status,_that.splits,_that.receipts);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String? description,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  String payerId,  bool payerIsViewer,  TripExpensesPayer payer,  int splitCount,  num? amountPerPerson,  String? splitNote,  int settledCount,  TripExpensesSettleStatus status,  List<TripExpensesSplitEntry> splits,  List<TripExpenseReceipt> receipts)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesEntry():
return $default(_that.id,_that.tripId,_that.description,_that.amount,_that.currency,_that.category,_that.splitType,_that.spentAt,_that.locationNote,_that.createdAt,_that.payerId,_that.payerIsViewer,_that.payer,_that.splitCount,_that.amountPerPerson,_that.splitNote,_that.settledCount,_that.status,_that.splits,_that.receipts);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String? description,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  String payerId,  bool payerIsViewer,  TripExpensesPayer payer,  int splitCount,  num? amountPerPerson,  String? splitNote,  int settledCount,  TripExpensesSettleStatus status,  List<TripExpensesSplitEntry> splits,  List<TripExpenseReceipt> receipts)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.description,_that.amount,_that.currency,_that.category,_that.splitType,_that.spentAt,_that.locationNote,_that.createdAt,_that.payerId,_that.payerIsViewer,_that.payer,_that.splitCount,_that.amountPerPerson,_that.splitNote,_that.settledCount,_that.status,_that.splits,_that.receipts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesEntry implements TripExpensesEntry {
  const _TripExpensesEntry({required this.id, required this.tripId, this.description, required this.amount, required this.currency, required this.category, required this.splitType, required this.spentAt, this.locationNote, required this.createdAt, required this.payerId, required this.payerIsViewer, required this.payer, required this.splitCount, this.amountPerPerson, this.splitNote, required this.settledCount, required this.status,  List<TripExpensesSplitEntry> splits = const <TripExpensesSplitEntry>[],  List<TripExpenseReceipt> receipts = const <TripExpenseReceipt>[]}): _splits = splits,_receipts = receipts;
  factory _TripExpensesEntry.fromJson(Map<String, dynamic> json) => _$TripExpensesEntryFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String? description;
@override final  String amount;
@override final  TripExpensesCurrency currency;
@override final  TripExpensesCategory category;
@override final  TripExpensesSplitType splitType;
@override final  DateTime spentAt;
@override final  String? locationNote;
@override final  DateTime createdAt;
@override final  String payerId;
@override final  bool payerIsViewer;
@override final  TripExpensesPayer payer;
@override final  int splitCount;
@override final  num? amountPerPerson;
@override final  String? splitNote;
@override final  int settledCount;
@override final  TripExpensesSettleStatus status;
 final  List<TripExpensesSplitEntry> _splits;
@override@JsonKey() List<TripExpensesSplitEntry> get splits {
  if (_splits is EqualUnmodifiableListView) return _splits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_splits);
}

 final  List<TripExpenseReceipt> _receipts;
@override@JsonKey() List<TripExpenseReceipt> get receipts {
  if (_receipts is EqualUnmodifiableListView) return _receipts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receipts);
}


/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesEntryCopyWith<_TripExpensesEntry> get copyWith => __$TripExpensesEntryCopyWithImpl<_TripExpensesEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.category, category) || other.category == category)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.spentAt, spentAt) || other.spentAt == spentAt)&&(identical(other.locationNote, locationNote) || other.locationNote == locationNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.payerIsViewer, payerIsViewer) || other.payerIsViewer == payerIsViewer)&&(identical(other.payer, payer) || other.payer == payer)&&(identical(other.splitCount, splitCount) || other.splitCount == splitCount)&&(identical(other.amountPerPerson, amountPerPerson) || other.amountPerPerson == amountPerPerson)&&(identical(other.splitNote, splitNote) || other.splitNote == splitNote)&&(identical(other.settledCount, settledCount) || other.settledCount == settledCount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.splits, _splits)&&const DeepCollectionEquality().equals(other.receipts, _receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,tripId,description,amount,currency,category,splitType,spentAt,locationNote,createdAt,payerId,payerIsViewer,payer,splitCount,amountPerPerson,splitNote,settledCount,status,const DeepCollectionEquality().hash(_splits),const DeepCollectionEquality().hash(_receipts)]);
}

@override
String toString() {
    return 'TripExpensesEntry(id: $id, tripId: $tripId, description: $description, amount: $amount, currency: $currency, category: $category, splitType: $splitType, spentAt: $spentAt, locationNote: $locationNote, createdAt: $createdAt, payerId: $payerId, payerIsViewer: $payerIsViewer, payer: $payer, splitCount: $splitCount, amountPerPerson: $amountPerPerson, splitNote: $splitNote, settledCount: $settledCount, status: $status, splits: $splits, receipts: $receipts)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesEntryCopyWith<$Res> implements $TripExpensesEntryCopyWith<$Res> {
  factory _$TripExpensesEntryCopyWith(_TripExpensesEntry value, $Res Function(_TripExpensesEntry) _then) = __$TripExpensesEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String? description, String amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, DateTime spentAt, String? locationNote, DateTime createdAt, String payerId, bool payerIsViewer, TripExpensesPayer payer, int splitCount, num? amountPerPerson, String? splitNote, int settledCount, TripExpensesSettleStatus status, List<TripExpensesSplitEntry> splits, List<TripExpenseReceipt> receipts
});


@override $TripExpensesPayerCopyWith<$Res> get payer;

}
/// @nodoc
class __$TripExpensesEntryCopyWithImpl<$Res>
    implements _$TripExpensesEntryCopyWith<$Res> {
  __$TripExpensesEntryCopyWithImpl(this._self, this._then);

  final _TripExpensesEntry _self;
  final $Res Function(_TripExpensesEntry) _then;

/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? description = freezed,Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? spentAt = null,Object? locationNote = freezed,Object? createdAt = null,Object? payerId = null,Object? payerIsViewer = null,Object? payer = null,Object? splitCount = null,Object? amountPerPerson = freezed,Object? splitNote = freezed,Object? settledCount = null,Object? status = null,Object? splits = null,Object? receipts = null,}) {
  return _then(_TripExpensesEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,payerIsViewer: null == payerIsViewer ? _self.payerIsViewer : payerIsViewer // ignore: cast_nullable_to_non_nullable
as bool,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as TripExpensesPayer,splitCount: null == splitCount ? _self.splitCount : splitCount // ignore: cast_nullable_to_non_nullable
as int,amountPerPerson: freezed == amountPerPerson ? _self.amountPerPerson : amountPerPerson // ignore: cast_nullable_to_non_nullable
as num?,splitNote: freezed == splitNote ? _self.splitNote : splitNote // ignore: cast_nullable_to_non_nullable
as String?,settledCount: null == settledCount ? _self.settledCount : settledCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripExpensesSettleStatus,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<TripExpensesSplitEntry>,receipts: null == receipts ? _self._receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<TripExpenseReceipt>,
  ));
}

/// Create a copy of TripExpensesEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesPayerCopyWith<$Res> get payer {
  
  return $TripExpensesPayerCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}


/// @nodoc
mixin _$TripExpensesPayer {

 String get id; String get userId; String get displayName; String? get title; TripExpensesUser get user;
/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesPayerCopyWith<TripExpensesPayer> get copyWith => _$TripExpensesPayerCopyWithImpl<TripExpensesPayer>(this as TripExpensesPayer, _$identity);

  /// Serializes this TripExpensesPayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesPayer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesPayer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesPayer;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.displayName,_this.title,_this.user);
}

@override
String toString() {
  final _this = this as TripExpensesPayer;
  return 'TripExpensesPayer(id: ${_this.id}, userId: ${_this.userId}, displayName: ${_this.displayName}, title: ${_this.title}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $TripExpensesPayerCopyWith<$Res>  {
  factory $TripExpensesPayerCopyWith(TripExpensesPayer value, $Res Function(TripExpensesPayer) _then) = _$TripExpensesPayerCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String displayName, String? title, TripExpensesUser user
});


$TripExpensesUserCopyWith<$Res> get user;

}
/// @nodoc
class _$TripExpensesPayerCopyWithImpl<$Res>
    implements $TripExpensesPayerCopyWith<$Res> {
  _$TripExpensesPayerCopyWithImpl(this._self, this._then);

  final TripExpensesPayer _self;
  final $Res Function(TripExpensesPayer) _then;

/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? title = freezed,Object? user = null,}) {
  return _then(TripExpensesPayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripExpensesUser,
  ));
}
/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesUserCopyWith<$Res> get user {
  
  return $TripExpensesUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpensesPayer].
extension TripExpensesPayerPatterns on TripExpensesPayer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesPayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesPayer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesPayer value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesPayer():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesPayer value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesPayer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? title,  TripExpensesUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesPayer() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.title,_that.user);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? title,  TripExpensesUser user)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesPayer():
return $default(_that.id,_that.userId,_that.displayName,_that.title,_that.user);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String displayName,  String? title,  TripExpensesUser user)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesPayer() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.title,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesPayer implements TripExpensesPayer {
  const _TripExpensesPayer({required this.id, required this.userId, required this.displayName, this.title, required this.user});
  factory _TripExpensesPayer.fromJson(Map<String, dynamic> json) => _$TripExpensesPayerFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String displayName;
@override final  String? title;
@override final  TripExpensesUser user;

/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesPayerCopyWith<_TripExpensesPayer> get copyWith => __$TripExpensesPayerCopyWithImpl<_TripExpensesPayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesPayerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesPayer&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.title, title) || other.title == title)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,displayName,title,user);
}

@override
String toString() {
    return 'TripExpensesPayer(id: $id, userId: $userId, displayName: $displayName, title: $title, user: $user)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesPayerCopyWith<$Res> implements $TripExpensesPayerCopyWith<$Res> {
  factory _$TripExpensesPayerCopyWith(_TripExpensesPayer value, $Res Function(_TripExpensesPayer) _then) = __$TripExpensesPayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String displayName, String? title, TripExpensesUser user
});


@override $TripExpensesUserCopyWith<$Res> get user;

}
/// @nodoc
class __$TripExpensesPayerCopyWithImpl<$Res>
    implements _$TripExpensesPayerCopyWith<$Res> {
  __$TripExpensesPayerCopyWithImpl(this._self, this._then);

  final _TripExpensesPayer _self;
  final $Res Function(_TripExpensesPayer) _then;

/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? title = freezed,Object? user = null,}) {
  return _then(_TripExpensesPayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripExpensesUser,
  ));
}

/// Create a copy of TripExpensesPayer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesUserCopyWith<$Res> get user {
  
  return $TripExpensesUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$TripExpensesUser {

 String get id; String get username; String? get avatarId;
/// Create a copy of TripExpensesUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesUserCopyWith<TripExpensesUser> get copyWith => _$TripExpensesUserCopyWithImpl<TripExpensesUser>(this as TripExpensesUser, _$identity);

  /// Serializes this TripExpensesUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesUser;
  return Object.hash(runtimeType,_this.id,_this.username,_this.avatarId);
}

@override
String toString() {
  final _this = this as TripExpensesUser;
  return 'TripExpensesUser(id: ${_this.id}, username: ${_this.username}, avatarId: ${_this.avatarId})';
}


}

/// @nodoc
abstract mixin class $TripExpensesUserCopyWith<$Res>  {
  factory $TripExpensesUserCopyWith(TripExpensesUser value, $Res Function(TripExpensesUser) _then) = _$TripExpensesUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class _$TripExpensesUserCopyWithImpl<$Res>
    implements $TripExpensesUserCopyWith<$Res> {
  _$TripExpensesUserCopyWithImpl(this._self, this._then);

  final TripExpensesUser _self;
  final $Res Function(TripExpensesUser) _then;

/// Create a copy of TripExpensesUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(TripExpensesUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpensesUser].
extension TripExpensesUserPatterns on TripExpensesUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesUser value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesUser value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesUser() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesUser():
return $default(_that.id,_that.username,_that.avatarId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? avatarId)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesUser() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesUser implements TripExpensesUser {
  const _TripExpensesUser({required this.id, required this.username, this.avatarId});
  factory _TripExpensesUser.fromJson(Map<String, dynamic> json) => _$TripExpensesUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarId;

/// Create a copy of TripExpensesUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesUserCopyWith<_TripExpensesUser> get copyWith => __$TripExpensesUserCopyWithImpl<_TripExpensesUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,avatarId);
}

@override
String toString() {
    return 'TripExpensesUser(id: $id, username: $username, avatarId: $avatarId)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesUserCopyWith<$Res> implements $TripExpensesUserCopyWith<$Res> {
  factory _$TripExpensesUserCopyWith(_TripExpensesUser value, $Res Function(_TripExpensesUser) _then) = __$TripExpensesUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class __$TripExpensesUserCopyWithImpl<$Res>
    implements _$TripExpensesUserCopyWith<$Res> {
  __$TripExpensesUserCopyWithImpl(this._self, this._then);

  final _TripExpensesUser _self;
  final $Res Function(_TripExpensesUser) _then;

/// Create a copy of TripExpensesUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(_TripExpensesUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripExpensesSplitEntry {

 String get id; String get expenseId; String get tripMemberId; String get amount; bool get isSettled;
/// Create a copy of TripExpensesSplitEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesSplitEntryCopyWith<TripExpensesSplitEntry> get copyWith => _$TripExpensesSplitEntryCopyWithImpl<TripExpensesSplitEntry>(this as TripExpensesSplitEntry, _$identity);

  /// Serializes this TripExpensesSplitEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesSplitEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesSplitEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.expenseId, _this.expenseId) || other.expenseId == _this.expenseId)&&(identical(other.tripMemberId, _this.tripMemberId) || other.tripMemberId == _this.tripMemberId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.isSettled, _this.isSettled) || other.isSettled == _this.isSettled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesSplitEntry;
  return Object.hash(runtimeType,_this.id,_this.expenseId,_this.tripMemberId,_this.amount,_this.isSettled);
}

@override
String toString() {
  final _this = this as TripExpensesSplitEntry;
  return 'TripExpensesSplitEntry(id: ${_this.id}, expenseId: ${_this.expenseId}, tripMemberId: ${_this.tripMemberId}, amount: ${_this.amount}, isSettled: ${_this.isSettled})';
}


}

/// @nodoc
abstract mixin class $TripExpensesSplitEntryCopyWith<$Res>  {
  factory $TripExpensesSplitEntryCopyWith(TripExpensesSplitEntry value, $Res Function(TripExpensesSplitEntry) _then) = _$TripExpensesSplitEntryCopyWithImpl;
@useResult
$Res call({
 String id, String expenseId, String tripMemberId, String amount, bool isSettled
});




}
/// @nodoc
class _$TripExpensesSplitEntryCopyWithImpl<$Res>
    implements $TripExpensesSplitEntryCopyWith<$Res> {
  _$TripExpensesSplitEntryCopyWithImpl(this._self, this._then);

  final TripExpensesSplitEntry _self;
  final $Res Function(TripExpensesSplitEntry) _then;

/// Create a copy of TripExpensesSplitEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? expenseId = null,Object? tripMemberId = null,Object? amount = null,Object? isSettled = null,}) {
  return _then(TripExpensesSplitEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripExpensesSplitEntry].
extension TripExpensesSplitEntryPatterns on TripExpensesSplitEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesSplitEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesSplitEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesSplitEntry value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSplitEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesSplitEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesSplitEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesSplitEntry() when $default != null:
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSplitEntry():
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesSplitEntry() when $default != null:
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesSplitEntry implements TripExpensesSplitEntry {
  const _TripExpensesSplitEntry({required this.id, required this.expenseId, required this.tripMemberId, required this.amount, required this.isSettled});
  factory _TripExpensesSplitEntry.fromJson(Map<String, dynamic> json) => _$TripExpensesSplitEntryFromJson(json);

@override final  String id;
@override final  String expenseId;
@override final  String tripMemberId;
@override final  String amount;
@override final  bool isSettled;

/// Create a copy of TripExpensesSplitEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesSplitEntryCopyWith<_TripExpensesSplitEntry> get copyWith => __$TripExpensesSplitEntryCopyWithImpl<_TripExpensesSplitEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesSplitEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesSplitEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.tripMemberId, tripMemberId) || other.tripMemberId == tripMemberId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,expenseId,tripMemberId,amount,isSettled);
}

@override
String toString() {
    return 'TripExpensesSplitEntry(id: $id, expenseId: $expenseId, tripMemberId: $tripMemberId, amount: $amount, isSettled: $isSettled)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesSplitEntryCopyWith<$Res> implements $TripExpensesSplitEntryCopyWith<$Res> {
  factory _$TripExpensesSplitEntryCopyWith(_TripExpensesSplitEntry value, $Res Function(_TripExpensesSplitEntry) _then) = __$TripExpensesSplitEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String expenseId, String tripMemberId, String amount, bool isSettled
});




}
/// @nodoc
class __$TripExpensesSplitEntryCopyWithImpl<$Res>
    implements _$TripExpensesSplitEntryCopyWith<$Res> {
  __$TripExpensesSplitEntryCopyWithImpl(this._self, this._then);

  final _TripExpensesSplitEntry _self;
  final $Res Function(_TripExpensesSplitEntry) _then;

/// Create a copy of TripExpensesSplitEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? expenseId = null,Object? tripMemberId = null,Object? amount = null,Object? isSettled = null,}) {
  return _then(_TripExpensesSplitEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CreateTripExpenseRequest {

 num get amount; TripExpensesCurrency get currency; TripExpensesCategory get category; TripExpensesSplitType get splitType; String? get description; String? get payerTripMemberId; DateTime? get spentAt; String? get locationNote; List<String> get receiptMediaIds; List<CreateTripExpenseSplit> get splits;
/// Create a copy of CreateTripExpenseRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTripExpenseRequestCopyWith<CreateTripExpenseRequest> get copyWith => _$CreateTripExpenseRequestCopyWithImpl<CreateTripExpenseRequest>(this as CreateTripExpenseRequest, _$identity);

  /// Serializes this CreateTripExpenseRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateTripExpenseRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTripExpenseRequest&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.splitType, _this.splitType) || other.splitType == _this.splitType)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.payerTripMemberId, _this.payerTripMemberId) || other.payerTripMemberId == _this.payerTripMemberId)&&(identical(other.spentAt, _this.spentAt) || other.spentAt == _this.spentAt)&&(identical(other.locationNote, _this.locationNote) || other.locationNote == _this.locationNote)&&const DeepCollectionEquality().equals(other.receiptMediaIds, _this.receiptMediaIds)&&const DeepCollectionEquality().equals(other.splits, _this.splits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateTripExpenseRequest;
  return Object.hash(runtimeType,_this.amount,_this.currency,_this.category,_this.splitType,_this.description,_this.payerTripMemberId,_this.spentAt,_this.locationNote,const DeepCollectionEquality().hash(_this.receiptMediaIds),const DeepCollectionEquality().hash(_this.splits));
}

@override
String toString() {
  final _this = this as CreateTripExpenseRequest;
  return 'CreateTripExpenseRequest(amount: ${_this.amount}, currency: ${_this.currency}, category: ${_this.category}, splitType: ${_this.splitType}, description: ${_this.description}, payerTripMemberId: ${_this.payerTripMemberId}, spentAt: ${_this.spentAt}, locationNote: ${_this.locationNote}, receiptMediaIds: ${_this.receiptMediaIds}, splits: ${_this.splits})';
}


}

/// @nodoc
abstract mixin class $CreateTripExpenseRequestCopyWith<$Res>  {
  factory $CreateTripExpenseRequestCopyWith(CreateTripExpenseRequest value, $Res Function(CreateTripExpenseRequest) _then) = _$CreateTripExpenseRequestCopyWithImpl;
@useResult
$Res call({
 num amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, String? description, String? payerTripMemberId, DateTime? spentAt, String? locationNote, List<String> receiptMediaIds, List<CreateTripExpenseSplit> splits
});




}
/// @nodoc
class _$CreateTripExpenseRequestCopyWithImpl<$Res>
    implements $CreateTripExpenseRequestCopyWith<$Res> {
  _$CreateTripExpenseRequestCopyWithImpl(this._self, this._then);

  final CreateTripExpenseRequest _self;
  final $Res Function(CreateTripExpenseRequest) _then;

/// Create a copy of CreateTripExpenseRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? description = freezed,Object? payerTripMemberId = freezed,Object? spentAt = freezed,Object? locationNote = freezed,Object? receiptMediaIds = null,Object? splits = null,}) {
  return _then(CreateTripExpenseRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,payerTripMemberId: freezed == payerTripMemberId ? _self.payerTripMemberId : payerTripMemberId // ignore: cast_nullable_to_non_nullable
as String?,spentAt: freezed == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaIds: null == receiptMediaIds ? _self.receiptMediaIds : receiptMediaIds // ignore: cast_nullable_to_non_nullable
as List<String>,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<CreateTripExpenseSplit>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTripExpenseRequest].
extension CreateTripExpenseRequestPatterns on CreateTripExpenseRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTripExpenseRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTripExpenseRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTripExpenseRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateTripExpenseRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTripExpenseRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTripExpenseRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  String? payerTripMemberId,  DateTime? spentAt,  String? locationNote,  List<String> receiptMediaIds,  List<CreateTripExpenseSplit> splits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTripExpenseRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.payerTripMemberId,_that.spentAt,_that.locationNote,_that.receiptMediaIds,_that.splits);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  String? payerTripMemberId,  DateTime? spentAt,  String? locationNote,  List<String> receiptMediaIds,  List<CreateTripExpenseSplit> splits)  $default,) {final _that = this;
switch (_that) {
case _CreateTripExpenseRequest():
return $default(_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.payerTripMemberId,_that.spentAt,_that.locationNote,_that.receiptMediaIds,_that.splits);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  String? payerTripMemberId,  DateTime? spentAt,  String? locationNote,  List<String> receiptMediaIds,  List<CreateTripExpenseSplit> splits)?  $default,) {final _that = this;
switch (_that) {
case _CreateTripExpenseRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.payerTripMemberId,_that.spentAt,_that.locationNote,_that.receiptMediaIds,_that.splits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateTripExpenseRequest implements CreateTripExpenseRequest {
  const _CreateTripExpenseRequest({required this.amount, this.currency = TripExpensesCurrency.vnd, required this.category, required this.splitType, this.description, this.payerTripMemberId, this.spentAt, this.locationNote,  List<String> receiptMediaIds = const <String>[],  List<CreateTripExpenseSplit> splits = const <CreateTripExpenseSplit>[]}): _receiptMediaIds = receiptMediaIds,_splits = splits;
  factory _CreateTripExpenseRequest.fromJson(Map<String, dynamic> json) => _$CreateTripExpenseRequestFromJson(json);

@override final  num amount;
@override@JsonKey() final  TripExpensesCurrency currency;
@override final  TripExpensesCategory category;
@override final  TripExpensesSplitType splitType;
@override final  String? description;
@override final  String? payerTripMemberId;
@override final  DateTime? spentAt;
@override final  String? locationNote;
 final  List<String> _receiptMediaIds;
@override@JsonKey() List<String> get receiptMediaIds {
  if (_receiptMediaIds is EqualUnmodifiableListView) return _receiptMediaIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receiptMediaIds);
}

 final  List<CreateTripExpenseSplit> _splits;
@override@JsonKey() List<CreateTripExpenseSplit> get splits {
  if (_splits is EqualUnmodifiableListView) return _splits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_splits);
}


/// Create a copy of CreateTripExpenseRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTripExpenseRequestCopyWith<_CreateTripExpenseRequest> get copyWith => __$CreateTripExpenseRequestCopyWithImpl<_CreateTripExpenseRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTripExpenseRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTripExpenseRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.category, category) || other.category == category)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.description, description) || other.description == description)&&(identical(other.payerTripMemberId, payerTripMemberId) || other.payerTripMemberId == payerTripMemberId)&&(identical(other.spentAt, spentAt) || other.spentAt == spentAt)&&(identical(other.locationNote, locationNote) || other.locationNote == locationNote)&&const DeepCollectionEquality().equals(other.receiptMediaIds, _receiptMediaIds)&&const DeepCollectionEquality().equals(other.splits, _splits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,amount,currency,category,splitType,description,payerTripMemberId,spentAt,locationNote,const DeepCollectionEquality().hash(_receiptMediaIds),const DeepCollectionEquality().hash(_splits));
}

@override
String toString() {
    return 'CreateTripExpenseRequest(amount: $amount, currency: $currency, category: $category, splitType: $splitType, description: $description, payerTripMemberId: $payerTripMemberId, spentAt: $spentAt, locationNote: $locationNote, receiptMediaIds: $receiptMediaIds, splits: $splits)';
}


}

/// @nodoc
abstract mixin class _$CreateTripExpenseRequestCopyWith<$Res> implements $CreateTripExpenseRequestCopyWith<$Res> {
  factory _$CreateTripExpenseRequestCopyWith(_CreateTripExpenseRequest value, $Res Function(_CreateTripExpenseRequest) _then) = __$CreateTripExpenseRequestCopyWithImpl;
@override @useResult
$Res call({
 num amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, String? description, String? payerTripMemberId, DateTime? spentAt, String? locationNote, List<String> receiptMediaIds, List<CreateTripExpenseSplit> splits
});




}
/// @nodoc
class __$CreateTripExpenseRequestCopyWithImpl<$Res>
    implements _$CreateTripExpenseRequestCopyWith<$Res> {
  __$CreateTripExpenseRequestCopyWithImpl(this._self, this._then);

  final _CreateTripExpenseRequest _self;
  final $Res Function(_CreateTripExpenseRequest) _then;

/// Create a copy of CreateTripExpenseRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? description = freezed,Object? payerTripMemberId = freezed,Object? spentAt = freezed,Object? locationNote = freezed,Object? receiptMediaIds = null,Object? splits = null,}) {
  return _then(_CreateTripExpenseRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,payerTripMemberId: freezed == payerTripMemberId ? _self.payerTripMemberId : payerTripMemberId // ignore: cast_nullable_to_non_nullable
as String?,spentAt: freezed == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaIds: null == receiptMediaIds ? _self._receiptMediaIds : receiptMediaIds // ignore: cast_nullable_to_non_nullable
as List<String>,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<CreateTripExpenseSplit>,
  ));
}


}


/// @nodoc
mixin _$CreateTripExpenseSplit {

 String get tripMemberId; num get amount;
/// Create a copy of CreateTripExpenseSplit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTripExpenseSplitCopyWith<CreateTripExpenseSplit> get copyWith => _$CreateTripExpenseSplitCopyWithImpl<CreateTripExpenseSplit>(this as CreateTripExpenseSplit, _$identity);

  /// Serializes this CreateTripExpenseSplit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateTripExpenseSplit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTripExpenseSplit&&(identical(other.tripMemberId, _this.tripMemberId) || other.tripMemberId == _this.tripMemberId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateTripExpenseSplit;
  return Object.hash(runtimeType,_this.tripMemberId,_this.amount);
}

@override
String toString() {
  final _this = this as CreateTripExpenseSplit;
  return 'CreateTripExpenseSplit(tripMemberId: ${_this.tripMemberId}, amount: ${_this.amount})';
}


}

/// @nodoc
abstract mixin class $CreateTripExpenseSplitCopyWith<$Res>  {
  factory $CreateTripExpenseSplitCopyWith(CreateTripExpenseSplit value, $Res Function(CreateTripExpenseSplit) _then) = _$CreateTripExpenseSplitCopyWithImpl;
@useResult
$Res call({
 String tripMemberId, num amount
});




}
/// @nodoc
class _$CreateTripExpenseSplitCopyWithImpl<$Res>
    implements $CreateTripExpenseSplitCopyWith<$Res> {
  _$CreateTripExpenseSplitCopyWithImpl(this._self, this._then);

  final CreateTripExpenseSplit _self;
  final $Res Function(CreateTripExpenseSplit) _then;

/// Create a copy of CreateTripExpenseSplit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripMemberId = null,Object? amount = null,}) {
  return _then(CreateTripExpenseSplit(
tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTripExpenseSplit].
extension CreateTripExpenseSplitPatterns on CreateTripExpenseSplit {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTripExpenseSplit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTripExpenseSplit() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTripExpenseSplit value)  $default,){
final _that = this;
switch (_that) {
case _CreateTripExpenseSplit():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTripExpenseSplit value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTripExpenseSplit() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripMemberId,  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTripExpenseSplit() when $default != null:
return $default(_that.tripMemberId,_that.amount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripMemberId,  num amount)  $default,) {final _that = this;
switch (_that) {
case _CreateTripExpenseSplit():
return $default(_that.tripMemberId,_that.amount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripMemberId,  num amount)?  $default,) {final _that = this;
switch (_that) {
case _CreateTripExpenseSplit() when $default != null:
return $default(_that.tripMemberId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateTripExpenseSplit implements CreateTripExpenseSplit {
  const _CreateTripExpenseSplit({required this.tripMemberId, required this.amount});
  factory _CreateTripExpenseSplit.fromJson(Map<String, dynamic> json) => _$CreateTripExpenseSplitFromJson(json);

@override final  String tripMemberId;
@override final  num amount;

/// Create a copy of CreateTripExpenseSplit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTripExpenseSplitCopyWith<_CreateTripExpenseSplit> get copyWith => __$CreateTripExpenseSplitCopyWithImpl<_CreateTripExpenseSplit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTripExpenseSplitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTripExpenseSplit&&(identical(other.tripMemberId, tripMemberId) || other.tripMemberId == tripMemberId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripMemberId,amount);
}

@override
String toString() {
    return 'CreateTripExpenseSplit(tripMemberId: $tripMemberId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CreateTripExpenseSplitCopyWith<$Res> implements $CreateTripExpenseSplitCopyWith<$Res> {
  factory _$CreateTripExpenseSplitCopyWith(_CreateTripExpenseSplit value, $Res Function(_CreateTripExpenseSplit) _then) = __$CreateTripExpenseSplitCopyWithImpl;
@override @useResult
$Res call({
 String tripMemberId, num amount
});




}
/// @nodoc
class __$CreateTripExpenseSplitCopyWithImpl<$Res>
    implements _$CreateTripExpenseSplitCopyWith<$Res> {
  __$CreateTripExpenseSplitCopyWithImpl(this._self, this._then);

  final _CreateTripExpenseSplit _self;
  final $Res Function(_CreateTripExpenseSplit) _then;

/// Create a copy of CreateTripExpenseSplit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripMemberId = null,Object? amount = null,}) {
  return _then(_CreateTripExpenseSplit(
tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$TripExpenseCreated {

 String get id; String get tripId; String get payerId; String get amount; TripExpensesCurrency get currency; TripExpensesCategory get category; TripExpensesSplitType get splitType; String? get description; DateTime get spentAt; String? get locationNote; DateTime get createdAt; TripExpensesMember get payer; List<TripExpenseCreatedSplit> get splits; List<TripExpenseReceipt> get receipts;
/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpenseCreatedCopyWith<TripExpenseCreated> get copyWith => _$TripExpenseCreatedCopyWithImpl<TripExpenseCreated>(this as TripExpenseCreated, _$identity);

  /// Serializes this TripExpenseCreated to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpenseCreated;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpenseCreated&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.payerId, _this.payerId) || other.payerId == _this.payerId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.splitType, _this.splitType) || other.splitType == _this.splitType)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.spentAt, _this.spentAt) || other.spentAt == _this.spentAt)&&(identical(other.locationNote, _this.locationNote) || other.locationNote == _this.locationNote)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.payer, _this.payer) || other.payer == _this.payer)&&const DeepCollectionEquality().equals(other.splits, _this.splits)&&const DeepCollectionEquality().equals(other.receipts, _this.receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpenseCreated;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.payerId,_this.amount,_this.currency,_this.category,_this.splitType,_this.description,_this.spentAt,_this.locationNote,_this.createdAt,_this.payer,const DeepCollectionEquality().hash(_this.splits),const DeepCollectionEquality().hash(_this.receipts));
}

@override
String toString() {
  final _this = this as TripExpenseCreated;
  return 'TripExpenseCreated(id: ${_this.id}, tripId: ${_this.tripId}, payerId: ${_this.payerId}, amount: ${_this.amount}, currency: ${_this.currency}, category: ${_this.category}, splitType: ${_this.splitType}, description: ${_this.description}, spentAt: ${_this.spentAt}, locationNote: ${_this.locationNote}, createdAt: ${_this.createdAt}, payer: ${_this.payer}, splits: ${_this.splits}, receipts: ${_this.receipts})';
}


}

/// @nodoc
abstract mixin class $TripExpenseCreatedCopyWith<$Res>  {
  factory $TripExpenseCreatedCopyWith(TripExpenseCreated value, $Res Function(TripExpenseCreated) _then) = _$TripExpenseCreatedCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String payerId, String amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, String? description, DateTime spentAt, String? locationNote, DateTime createdAt, TripExpensesMember payer, List<TripExpenseCreatedSplit> splits, List<TripExpenseReceipt> receipts
});


$TripExpensesMemberCopyWith<$Res> get payer;

}
/// @nodoc
class _$TripExpenseCreatedCopyWithImpl<$Res>
    implements $TripExpenseCreatedCopyWith<$Res> {
  _$TripExpenseCreatedCopyWithImpl(this._self, this._then);

  final TripExpenseCreated _self;
  final $Res Function(TripExpenseCreated) _then;

/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? payerId = null,Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? description = freezed,Object? spentAt = null,Object? locationNote = freezed,Object? createdAt = null,Object? payer = null,Object? splits = null,Object? receipts = null,}) {
  return _then(TripExpenseCreated(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as TripExpensesMember,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<TripExpenseCreatedSplit>,receipts: null == receipts ? _self.receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<TripExpenseReceipt>,
  ));
}
/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesMemberCopyWith<$Res> get payer {
  
  return $TripExpensesMemberCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpenseCreated].
extension TripExpenseCreatedPatterns on TripExpenseCreated {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpenseCreated value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpenseCreated() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpenseCreated value)  $default,){
final _that = this;
switch (_that) {
case _TripExpenseCreated():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpenseCreated value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpenseCreated() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String payerId,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  TripExpensesMember payer,  List<TripExpenseCreatedSplit> splits,  List<TripExpenseReceipt> receipts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpenseCreated() when $default != null:
return $default(_that.id,_that.tripId,_that.payerId,_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.spentAt,_that.locationNote,_that.createdAt,_that.payer,_that.splits,_that.receipts);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String payerId,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  TripExpensesMember payer,  List<TripExpenseCreatedSplit> splits,  List<TripExpenseReceipt> receipts)  $default,) {final _that = this;
switch (_that) {
case _TripExpenseCreated():
return $default(_that.id,_that.tripId,_that.payerId,_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.spentAt,_that.locationNote,_that.createdAt,_that.payer,_that.splits,_that.receipts);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String payerId,  String amount,  TripExpensesCurrency currency,  TripExpensesCategory category,  TripExpensesSplitType splitType,  String? description,  DateTime spentAt,  String? locationNote,  DateTime createdAt,  TripExpensesMember payer,  List<TripExpenseCreatedSplit> splits,  List<TripExpenseReceipt> receipts)?  $default,) {final _that = this;
switch (_that) {
case _TripExpenseCreated() when $default != null:
return $default(_that.id,_that.tripId,_that.payerId,_that.amount,_that.currency,_that.category,_that.splitType,_that.description,_that.spentAt,_that.locationNote,_that.createdAt,_that.payer,_that.splits,_that.receipts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpenseCreated implements TripExpenseCreated {
  const _TripExpenseCreated({required this.id, required this.tripId, required this.payerId, required this.amount, required this.currency, required this.category, required this.splitType, this.description, required this.spentAt, this.locationNote, required this.createdAt, required this.payer,  List<TripExpenseCreatedSplit> splits = const <TripExpenseCreatedSplit>[],  List<TripExpenseReceipt> receipts = const <TripExpenseReceipt>[]}): _splits = splits,_receipts = receipts;
  factory _TripExpenseCreated.fromJson(Map<String, dynamic> json) => _$TripExpenseCreatedFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String payerId;
@override final  String amount;
@override final  TripExpensesCurrency currency;
@override final  TripExpensesCategory category;
@override final  TripExpensesSplitType splitType;
@override final  String? description;
@override final  DateTime spentAt;
@override final  String? locationNote;
@override final  DateTime createdAt;
@override final  TripExpensesMember payer;
 final  List<TripExpenseCreatedSplit> _splits;
@override@JsonKey() List<TripExpenseCreatedSplit> get splits {
  if (_splits is EqualUnmodifiableListView) return _splits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_splits);
}

 final  List<TripExpenseReceipt> _receipts;
@override@JsonKey() List<TripExpenseReceipt> get receipts {
  if (_receipts is EqualUnmodifiableListView) return _receipts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receipts);
}


/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpenseCreatedCopyWith<_TripExpenseCreated> get copyWith => __$TripExpenseCreatedCopyWithImpl<_TripExpenseCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpenseCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpenseCreated&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.category, category) || other.category == category)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.description, description) || other.description == description)&&(identical(other.spentAt, spentAt) || other.spentAt == spentAt)&&(identical(other.locationNote, locationNote) || other.locationNote == locationNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payer, payer) || other.payer == payer)&&const DeepCollectionEquality().equals(other.splits, _splits)&&const DeepCollectionEquality().equals(other.receipts, _receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,payerId,amount,currency,category,splitType,description,spentAt,locationNote,createdAt,payer,const DeepCollectionEquality().hash(_splits),const DeepCollectionEquality().hash(_receipts));
}

@override
String toString() {
    return 'TripExpenseCreated(id: $id, tripId: $tripId, payerId: $payerId, amount: $amount, currency: $currency, category: $category, splitType: $splitType, description: $description, spentAt: $spentAt, locationNote: $locationNote, createdAt: $createdAt, payer: $payer, splits: $splits, receipts: $receipts)';
}


}

/// @nodoc
abstract mixin class _$TripExpenseCreatedCopyWith<$Res> implements $TripExpenseCreatedCopyWith<$Res> {
  factory _$TripExpenseCreatedCopyWith(_TripExpenseCreated value, $Res Function(_TripExpenseCreated) _then) = __$TripExpenseCreatedCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String payerId, String amount, TripExpensesCurrency currency, TripExpensesCategory category, TripExpensesSplitType splitType, String? description, DateTime spentAt, String? locationNote, DateTime createdAt, TripExpensesMember payer, List<TripExpenseCreatedSplit> splits, List<TripExpenseReceipt> receipts
});


@override $TripExpensesMemberCopyWith<$Res> get payer;

}
/// @nodoc
class __$TripExpenseCreatedCopyWithImpl<$Res>
    implements _$TripExpenseCreatedCopyWith<$Res> {
  __$TripExpenseCreatedCopyWithImpl(this._self, this._then);

  final _TripExpenseCreated _self;
  final $Res Function(_TripExpenseCreated) _then;

/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? payerId = null,Object? amount = null,Object? currency = null,Object? category = null,Object? splitType = null,Object? description = freezed,Object? spentAt = null,Object? locationNote = freezed,Object? createdAt = null,Object? payer = null,Object? splits = null,Object? receipts = null,}) {
  return _then(_TripExpenseCreated(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as TripExpensesCurrency,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TripExpensesCategory,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripExpensesSplitType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationNote: freezed == locationNote ? _self.locationNote : locationNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as TripExpensesMember,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<TripExpenseCreatedSplit>,receipts: null == receipts ? _self._receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<TripExpenseReceipt>,
  ));
}

/// Create a copy of TripExpenseCreated
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesMemberCopyWith<$Res> get payer {
  
  return $TripExpensesMemberCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}


/// @nodoc
mixin _$TripExpensesMember {

 String get id; String get userId; TripExpensesUser get user;
/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpensesMemberCopyWith<TripExpensesMember> get copyWith => _$TripExpensesMemberCopyWithImpl<TripExpensesMember>(this as TripExpensesMember, _$identity);

  /// Serializes this TripExpensesMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpensesMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpensesMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpensesMember;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.user);
}

@override
String toString() {
  final _this = this as TripExpensesMember;
  return 'TripExpensesMember(id: ${_this.id}, userId: ${_this.userId}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $TripExpensesMemberCopyWith<$Res>  {
  factory $TripExpensesMemberCopyWith(TripExpensesMember value, $Res Function(TripExpensesMember) _then) = _$TripExpensesMemberCopyWithImpl;
@useResult
$Res call({
 String id, String userId, TripExpensesUser user
});


$TripExpensesUserCopyWith<$Res> get user;

}
/// @nodoc
class _$TripExpensesMemberCopyWithImpl<$Res>
    implements $TripExpensesMemberCopyWith<$Res> {
  _$TripExpensesMemberCopyWithImpl(this._self, this._then);

  final TripExpensesMember _self;
  final $Res Function(TripExpensesMember) _then;

/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? user = null,}) {
  return _then(TripExpensesMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripExpensesUser,
  ));
}
/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesUserCopyWith<$Res> get user {
  
  return $TripExpensesUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpensesMember].
extension TripExpensesMemberPatterns on TripExpensesMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpensesMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpensesMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpensesMember value)  $default,){
final _that = this;
switch (_that) {
case _TripExpensesMember():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpensesMember value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpensesMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  TripExpensesUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpensesMember() when $default != null:
return $default(_that.id,_that.userId,_that.user);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  TripExpensesUser user)  $default,) {final _that = this;
switch (_that) {
case _TripExpensesMember():
return $default(_that.id,_that.userId,_that.user);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  TripExpensesUser user)?  $default,) {final _that = this;
switch (_that) {
case _TripExpensesMember() when $default != null:
return $default(_that.id,_that.userId,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpensesMember implements TripExpensesMember {
  const _TripExpensesMember({required this.id, required this.userId, required this.user});
  factory _TripExpensesMember.fromJson(Map<String, dynamic> json) => _$TripExpensesMemberFromJson(json);

@override final  String id;
@override final  String userId;
@override final  TripExpensesUser user;

/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpensesMemberCopyWith<_TripExpensesMember> get copyWith => __$TripExpensesMemberCopyWithImpl<_TripExpensesMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpensesMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpensesMember&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,user);
}

@override
String toString() {
    return 'TripExpensesMember(id: $id, userId: $userId, user: $user)';
}


}

/// @nodoc
abstract mixin class _$TripExpensesMemberCopyWith<$Res> implements $TripExpensesMemberCopyWith<$Res> {
  factory _$TripExpensesMemberCopyWith(_TripExpensesMember value, $Res Function(_TripExpensesMember) _then) = __$TripExpensesMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, TripExpensesUser user
});


@override $TripExpensesUserCopyWith<$Res> get user;

}
/// @nodoc
class __$TripExpensesMemberCopyWithImpl<$Res>
    implements _$TripExpensesMemberCopyWith<$Res> {
  __$TripExpensesMemberCopyWithImpl(this._self, this._then);

  final _TripExpensesMember _self;
  final $Res Function(_TripExpensesMember) _then;

/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? user = null,}) {
  return _then(_TripExpensesMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripExpensesUser,
  ));
}

/// Create a copy of TripExpensesMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesUserCopyWith<$Res> get user {
  
  return $TripExpensesUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$TripExpenseCreatedSplit {

 String get id; String get expenseId; String get tripMemberId; String get amount; bool get isSettled; TripExpensesMember get member;
/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripExpenseCreatedSplitCopyWith<TripExpenseCreatedSplit> get copyWith => _$TripExpenseCreatedSplitCopyWithImpl<TripExpenseCreatedSplit>(this as TripExpenseCreatedSplit, _$identity);

  /// Serializes this TripExpenseCreatedSplit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripExpenseCreatedSplit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripExpenseCreatedSplit&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.expenseId, _this.expenseId) || other.expenseId == _this.expenseId)&&(identical(other.tripMemberId, _this.tripMemberId) || other.tripMemberId == _this.tripMemberId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.isSettled, _this.isSettled) || other.isSettled == _this.isSettled)&&(identical(other.member, _this.member) || other.member == _this.member));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripExpenseCreatedSplit;
  return Object.hash(runtimeType,_this.id,_this.expenseId,_this.tripMemberId,_this.amount,_this.isSettled,_this.member);
}

@override
String toString() {
  final _this = this as TripExpenseCreatedSplit;
  return 'TripExpenseCreatedSplit(id: ${_this.id}, expenseId: ${_this.expenseId}, tripMemberId: ${_this.tripMemberId}, amount: ${_this.amount}, isSettled: ${_this.isSettled}, member: ${_this.member})';
}


}

/// @nodoc
abstract mixin class $TripExpenseCreatedSplitCopyWith<$Res>  {
  factory $TripExpenseCreatedSplitCopyWith(TripExpenseCreatedSplit value, $Res Function(TripExpenseCreatedSplit) _then) = _$TripExpenseCreatedSplitCopyWithImpl;
@useResult
$Res call({
 String id, String expenseId, String tripMemberId, String amount, bool isSettled, TripExpensesMember member
});


$TripExpensesMemberCopyWith<$Res> get member;

}
/// @nodoc
class _$TripExpenseCreatedSplitCopyWithImpl<$Res>
    implements $TripExpenseCreatedSplitCopyWith<$Res> {
  _$TripExpenseCreatedSplitCopyWithImpl(this._self, this._then);

  final TripExpenseCreatedSplit _self;
  final $Res Function(TripExpenseCreatedSplit) _then;

/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? expenseId = null,Object? tripMemberId = null,Object? amount = null,Object? isSettled = null,Object? member = null,}) {
  return _then(TripExpenseCreatedSplit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as TripExpensesMember,
  ));
}
/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesMemberCopyWith<$Res> get member {
  
  return $TripExpensesMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripExpenseCreatedSplit].
extension TripExpenseCreatedSplitPatterns on TripExpenseCreatedSplit {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripExpenseCreatedSplit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripExpenseCreatedSplit value)  $default,){
final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripExpenseCreatedSplit value)?  $default,){
final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled,  TripExpensesMember member)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit() when $default != null:
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled,_that.member);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled,  TripExpensesMember member)  $default,) {final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit():
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled,_that.member);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String expenseId,  String tripMemberId,  String amount,  bool isSettled,  TripExpensesMember member)?  $default,) {final _that = this;
switch (_that) {
case _TripExpenseCreatedSplit() when $default != null:
return $default(_that.id,_that.expenseId,_that.tripMemberId,_that.amount,_that.isSettled,_that.member);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripExpenseCreatedSplit implements TripExpenseCreatedSplit {
  const _TripExpenseCreatedSplit({required this.id, required this.expenseId, required this.tripMemberId, required this.amount, required this.isSettled, required this.member});
  factory _TripExpenseCreatedSplit.fromJson(Map<String, dynamic> json) => _$TripExpenseCreatedSplitFromJson(json);

@override final  String id;
@override final  String expenseId;
@override final  String tripMemberId;
@override final  String amount;
@override final  bool isSettled;
@override final  TripExpensesMember member;

/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripExpenseCreatedSplitCopyWith<_TripExpenseCreatedSplit> get copyWith => __$TripExpenseCreatedSplitCopyWithImpl<_TripExpenseCreatedSplit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripExpenseCreatedSplitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripExpenseCreatedSplit&&(identical(other.id, id) || other.id == id)&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.tripMemberId, tripMemberId) || other.tripMemberId == tripMemberId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled)&&(identical(other.member, member) || other.member == member));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,expenseId,tripMemberId,amount,isSettled,member);
}

@override
String toString() {
    return 'TripExpenseCreatedSplit(id: $id, expenseId: $expenseId, tripMemberId: $tripMemberId, amount: $amount, isSettled: $isSettled, member: $member)';
}


}

/// @nodoc
abstract mixin class _$TripExpenseCreatedSplitCopyWith<$Res> implements $TripExpenseCreatedSplitCopyWith<$Res> {
  factory _$TripExpenseCreatedSplitCopyWith(_TripExpenseCreatedSplit value, $Res Function(_TripExpenseCreatedSplit) _then) = __$TripExpenseCreatedSplitCopyWithImpl;
@override @useResult
$Res call({
 String id, String expenseId, String tripMemberId, String amount, bool isSettled, TripExpensesMember member
});


@override $TripExpensesMemberCopyWith<$Res> get member;

}
/// @nodoc
class __$TripExpenseCreatedSplitCopyWithImpl<$Res>
    implements _$TripExpenseCreatedSplitCopyWith<$Res> {
  __$TripExpenseCreatedSplitCopyWithImpl(this._self, this._then);

  final _TripExpenseCreatedSplit _self;
  final $Res Function(_TripExpenseCreatedSplit) _then;

/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? expenseId = null,Object? tripMemberId = null,Object? amount = null,Object? isSettled = null,Object? member = null,}) {
  return _then(_TripExpenseCreatedSplit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,tripMemberId: null == tripMemberId ? _self.tripMemberId : tripMemberId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as TripExpensesMember,
  ));
}

/// Create a copy of TripExpenseCreatedSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripExpensesMemberCopyWith<$Res> get member {
  
  return $TripExpensesMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}

// dart format on
