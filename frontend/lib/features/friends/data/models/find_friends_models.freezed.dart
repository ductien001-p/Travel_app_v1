// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_friends_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FindFriendsPage {

 String get query;@JsonKey(fromJson: _readInt) int get matchCount; String get matchCountLabel; List<String> get recentSearches; FindFriendsDnaBanner get dnaBanner; List<FindFriendsUser> get results; List<FindFriendsNearbySuggestion> get nearbySuggestions;
/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsPageCopyWith<FindFriendsPage> get copyWith => _$FindFriendsPageCopyWithImpl<FindFriendsPage>(this as FindFriendsPage, _$identity);

  /// Serializes this FindFriendsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsPage&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.matchCount, _this.matchCount) || other.matchCount == _this.matchCount)&&(identical(other.matchCountLabel, _this.matchCountLabel) || other.matchCountLabel == _this.matchCountLabel)&&const DeepCollectionEquality().equals(other.recentSearches, _this.recentSearches)&&(identical(other.dnaBanner, _this.dnaBanner) || other.dnaBanner == _this.dnaBanner)&&const DeepCollectionEquality().equals(other.results, _this.results)&&const DeepCollectionEquality().equals(other.nearbySuggestions, _this.nearbySuggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsPage;
  return Object.hash(runtimeType,_this.query,_this.matchCount,_this.matchCountLabel,const DeepCollectionEquality().hash(_this.recentSearches),_this.dnaBanner,const DeepCollectionEquality().hash(_this.results),const DeepCollectionEquality().hash(_this.nearbySuggestions));
}

@override
String toString() {
  final _this = this as FindFriendsPage;
  return 'FindFriendsPage(query: ${_this.query}, matchCount: ${_this.matchCount}, matchCountLabel: ${_this.matchCountLabel}, recentSearches: ${_this.recentSearches}, dnaBanner: ${_this.dnaBanner}, results: ${_this.results}, nearbySuggestions: ${_this.nearbySuggestions})';
}


}

/// @nodoc
abstract mixin class $FindFriendsPageCopyWith<$Res>  {
  factory $FindFriendsPageCopyWith(FindFriendsPage value, $Res Function(FindFriendsPage) _then) = _$FindFriendsPageCopyWithImpl;
@useResult
$Res call({
 String query,@JsonKey(fromJson: _readInt) int matchCount, String matchCountLabel, List<String> recentSearches, FindFriendsDnaBanner dnaBanner, List<FindFriendsUser> results, List<FindFriendsNearbySuggestion> nearbySuggestions
});


$FindFriendsDnaBannerCopyWith<$Res> get dnaBanner;

}
/// @nodoc
class _$FindFriendsPageCopyWithImpl<$Res>
    implements $FindFriendsPageCopyWith<$Res> {
  _$FindFriendsPageCopyWithImpl(this._self, this._then);

  final FindFriendsPage _self;
  final $Res Function(FindFriendsPage) _then;

/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? matchCount = null,Object? matchCountLabel = null,Object? recentSearches = null,Object? dnaBanner = null,Object? results = null,Object? nearbySuggestions = null,}) {
  return _then(FindFriendsPage(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,matchCountLabel: null == matchCountLabel ? _self.matchCountLabel : matchCountLabel // ignore: cast_nullable_to_non_nullable
as String,recentSearches: null == recentSearches ? _self.recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,dnaBanner: null == dnaBanner ? _self.dnaBanner : dnaBanner // ignore: cast_nullable_to_non_nullable
as FindFriendsDnaBanner,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<FindFriendsUser>,nearbySuggestions: null == nearbySuggestions ? _self.nearbySuggestions : nearbySuggestions // ignore: cast_nullable_to_non_nullable
as List<FindFriendsNearbySuggestion>,
  ));
}
/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FindFriendsDnaBannerCopyWith<$Res> get dnaBanner {
  
  return $FindFriendsDnaBannerCopyWith<$Res>(_self.dnaBanner, (value) {
    return _then(_self.copyWith(dnaBanner: value));
  });
}
}


/// Adds pattern-matching-related methods to [FindFriendsPage].
extension FindFriendsPagePatterns on FindFriendsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsPage value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsPage value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query, @JsonKey(fromJson: _readInt)  int matchCount,  String matchCountLabel,  List<String> recentSearches,  FindFriendsDnaBanner dnaBanner,  List<FindFriendsUser> results,  List<FindFriendsNearbySuggestion> nearbySuggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsPage() when $default != null:
return $default(_that.query,_that.matchCount,_that.matchCountLabel,_that.recentSearches,_that.dnaBanner,_that.results,_that.nearbySuggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query, @JsonKey(fromJson: _readInt)  int matchCount,  String matchCountLabel,  List<String> recentSearches,  FindFriendsDnaBanner dnaBanner,  List<FindFriendsUser> results,  List<FindFriendsNearbySuggestion> nearbySuggestions)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsPage():
return $default(_that.query,_that.matchCount,_that.matchCountLabel,_that.recentSearches,_that.dnaBanner,_that.results,_that.nearbySuggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query, @JsonKey(fromJson: _readInt)  int matchCount,  String matchCountLabel,  List<String> recentSearches,  FindFriendsDnaBanner dnaBanner,  List<FindFriendsUser> results,  List<FindFriendsNearbySuggestion> nearbySuggestions)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsPage() when $default != null:
return $default(_that.query,_that.matchCount,_that.matchCountLabel,_that.recentSearches,_that.dnaBanner,_that.results,_that.nearbySuggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsPage implements FindFriendsPage {
  const _FindFriendsPage({this.query = '', @JsonKey(fromJson: _readInt) this.matchCount = 0, this.matchCountLabel = '',  List<String> recentSearches = const <String>[], required this.dnaBanner,  List<FindFriendsUser> results = const <FindFriendsUser>[],  List<FindFriendsNearbySuggestion> nearbySuggestions = const <FindFriendsNearbySuggestion>[]}): _recentSearches = recentSearches,_results = results,_nearbySuggestions = nearbySuggestions;
  factory _FindFriendsPage.fromJson(Map<String, dynamic> json) => _$FindFriendsPageFromJson(json);

@override@JsonKey() final  String query;
@override@JsonKey(fromJson: _readInt) final  int matchCount;
@override@JsonKey() final  String matchCountLabel;
 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}

@override final  FindFriendsDnaBanner dnaBanner;
 final  List<FindFriendsUser> _results;
@override@JsonKey() List<FindFriendsUser> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<FindFriendsNearbySuggestion> _nearbySuggestions;
@override@JsonKey() List<FindFriendsNearbySuggestion> get nearbySuggestions {
  if (_nearbySuggestions is EqualUnmodifiableListView) return _nearbySuggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbySuggestions);
}


/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsPageCopyWith<_FindFriendsPage> get copyWith => __$FindFriendsPageCopyWithImpl<_FindFriendsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsPage&&(identical(other.query, query) || other.query == query)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.matchCountLabel, matchCountLabel) || other.matchCountLabel == matchCountLabel)&&const DeepCollectionEquality().equals(other.recentSearches, _recentSearches)&&(identical(other.dnaBanner, dnaBanner) || other.dnaBanner == dnaBanner)&&const DeepCollectionEquality().equals(other.results, _results)&&const DeepCollectionEquality().equals(other.nearbySuggestions, _nearbySuggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,query,matchCount,matchCountLabel,const DeepCollectionEquality().hash(_recentSearches),dnaBanner,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_nearbySuggestions));
}

@override
String toString() {
    return 'FindFriendsPage(query: $query, matchCount: $matchCount, matchCountLabel: $matchCountLabel, recentSearches: $recentSearches, dnaBanner: $dnaBanner, results: $results, nearbySuggestions: $nearbySuggestions)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsPageCopyWith<$Res> implements $FindFriendsPageCopyWith<$Res> {
  factory _$FindFriendsPageCopyWith(_FindFriendsPage value, $Res Function(_FindFriendsPage) _then) = __$FindFriendsPageCopyWithImpl;
@override @useResult
$Res call({
 String query,@JsonKey(fromJson: _readInt) int matchCount, String matchCountLabel, List<String> recentSearches, FindFriendsDnaBanner dnaBanner, List<FindFriendsUser> results, List<FindFriendsNearbySuggestion> nearbySuggestions
});


@override $FindFriendsDnaBannerCopyWith<$Res> get dnaBanner;

}
/// @nodoc
class __$FindFriendsPageCopyWithImpl<$Res>
    implements _$FindFriendsPageCopyWith<$Res> {
  __$FindFriendsPageCopyWithImpl(this._self, this._then);

  final _FindFriendsPage _self;
  final $Res Function(_FindFriendsPage) _then;

/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? matchCount = null,Object? matchCountLabel = null,Object? recentSearches = null,Object? dnaBanner = null,Object? results = null,Object? nearbySuggestions = null,}) {
  return _then(_FindFriendsPage(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,matchCountLabel: null == matchCountLabel ? _self.matchCountLabel : matchCountLabel // ignore: cast_nullable_to_non_nullable
as String,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,dnaBanner: null == dnaBanner ? _self.dnaBanner : dnaBanner // ignore: cast_nullable_to_non_nullable
as FindFriendsDnaBanner,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<FindFriendsUser>,nearbySuggestions: null == nearbySuggestions ? _self._nearbySuggestions : nearbySuggestions // ignore: cast_nullable_to_non_nullable
as List<FindFriendsNearbySuggestion>,
  ));
}

/// Create a copy of FindFriendsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FindFriendsDnaBannerCopyWith<$Res> get dnaBanner {
  
  return $FindFriendsDnaBannerCopyWith<$Res>(_self.dnaBanner, (value) {
    return _then(_self.copyWith(dnaBanner: value));
  });
}
}


/// @nodoc
mixin _$FindFriendsDnaBanner {

 String get badgeLabel; String get title; String get subtitle; String get ctaLabel;@JsonKey(fromJson: _readInt) int get extraCount; List<String> get previewAvatars;
/// Create a copy of FindFriendsDnaBanner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsDnaBannerCopyWith<FindFriendsDnaBanner> get copyWith => _$FindFriendsDnaBannerCopyWithImpl<FindFriendsDnaBanner>(this as FindFriendsDnaBanner, _$identity);

  /// Serializes this FindFriendsDnaBanner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsDnaBanner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsDnaBanner&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.ctaLabel, _this.ctaLabel) || other.ctaLabel == _this.ctaLabel)&&(identical(other.extraCount, _this.extraCount) || other.extraCount == _this.extraCount)&&const DeepCollectionEquality().equals(other.previewAvatars, _this.previewAvatars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsDnaBanner;
  return Object.hash(runtimeType,_this.badgeLabel,_this.title,_this.subtitle,_this.ctaLabel,_this.extraCount,const DeepCollectionEquality().hash(_this.previewAvatars));
}

@override
String toString() {
  final _this = this as FindFriendsDnaBanner;
  return 'FindFriendsDnaBanner(badgeLabel: ${_this.badgeLabel}, title: ${_this.title}, subtitle: ${_this.subtitle}, ctaLabel: ${_this.ctaLabel}, extraCount: ${_this.extraCount}, previewAvatars: ${_this.previewAvatars})';
}


}

/// @nodoc
abstract mixin class $FindFriendsDnaBannerCopyWith<$Res>  {
  factory $FindFriendsDnaBannerCopyWith(FindFriendsDnaBanner value, $Res Function(FindFriendsDnaBanner) _then) = _$FindFriendsDnaBannerCopyWithImpl;
@useResult
$Res call({
 String badgeLabel, String title, String subtitle, String ctaLabel,@JsonKey(fromJson: _readInt) int extraCount, List<String> previewAvatars
});




}
/// @nodoc
class _$FindFriendsDnaBannerCopyWithImpl<$Res>
    implements $FindFriendsDnaBannerCopyWith<$Res> {
  _$FindFriendsDnaBannerCopyWithImpl(this._self, this._then);

  final FindFriendsDnaBanner _self;
  final $Res Function(FindFriendsDnaBanner) _then;

/// Create a copy of FindFriendsDnaBanner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? badgeLabel = null,Object? title = null,Object? subtitle = null,Object? ctaLabel = null,Object? extraCount = null,Object? previewAvatars = null,}) {
  return _then(FindFriendsDnaBanner(
badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,ctaLabel: null == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String,extraCount: null == extraCount ? _self.extraCount : extraCount // ignore: cast_nullable_to_non_nullable
as int,previewAvatars: null == previewAvatars ? _self.previewAvatars : previewAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FindFriendsDnaBanner].
extension FindFriendsDnaBannerPatterns on FindFriendsDnaBanner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsDnaBanner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsDnaBanner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsDnaBanner value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsDnaBanner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsDnaBanner value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsDnaBanner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String badgeLabel,  String title,  String subtitle,  String ctaLabel, @JsonKey(fromJson: _readInt)  int extraCount,  List<String> previewAvatars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsDnaBanner() when $default != null:
return $default(_that.badgeLabel,_that.title,_that.subtitle,_that.ctaLabel,_that.extraCount,_that.previewAvatars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String badgeLabel,  String title,  String subtitle,  String ctaLabel, @JsonKey(fromJson: _readInt)  int extraCount,  List<String> previewAvatars)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsDnaBanner():
return $default(_that.badgeLabel,_that.title,_that.subtitle,_that.ctaLabel,_that.extraCount,_that.previewAvatars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String badgeLabel,  String title,  String subtitle,  String ctaLabel, @JsonKey(fromJson: _readInt)  int extraCount,  List<String> previewAvatars)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsDnaBanner() when $default != null:
return $default(_that.badgeLabel,_that.title,_that.subtitle,_that.ctaLabel,_that.extraCount,_that.previewAvatars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsDnaBanner implements FindFriendsDnaBanner {
  const _FindFriendsDnaBanner({required this.badgeLabel, required this.title, required this.subtitle, required this.ctaLabel, @JsonKey(fromJson: _readInt) this.extraCount = 0,  List<String> previewAvatars = const <String>[]}): _previewAvatars = previewAvatars;
  factory _FindFriendsDnaBanner.fromJson(Map<String, dynamic> json) => _$FindFriendsDnaBannerFromJson(json);

@override final  String badgeLabel;
@override final  String title;
@override final  String subtitle;
@override final  String ctaLabel;
@override@JsonKey(fromJson: _readInt) final  int extraCount;
 final  List<String> _previewAvatars;
@override@JsonKey() List<String> get previewAvatars {
  if (_previewAvatars is EqualUnmodifiableListView) return _previewAvatars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previewAvatars);
}


/// Create a copy of FindFriendsDnaBanner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsDnaBannerCopyWith<_FindFriendsDnaBanner> get copyWith => __$FindFriendsDnaBannerCopyWithImpl<_FindFriendsDnaBanner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsDnaBannerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsDnaBanner&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel)&&(identical(other.extraCount, extraCount) || other.extraCount == extraCount)&&const DeepCollectionEquality().equals(other.previewAvatars, _previewAvatars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,badgeLabel,title,subtitle,ctaLabel,extraCount,const DeepCollectionEquality().hash(_previewAvatars));
}

@override
String toString() {
    return 'FindFriendsDnaBanner(badgeLabel: $badgeLabel, title: $title, subtitle: $subtitle, ctaLabel: $ctaLabel, extraCount: $extraCount, previewAvatars: $previewAvatars)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsDnaBannerCopyWith<$Res> implements $FindFriendsDnaBannerCopyWith<$Res> {
  factory _$FindFriendsDnaBannerCopyWith(_FindFriendsDnaBanner value, $Res Function(_FindFriendsDnaBanner) _then) = __$FindFriendsDnaBannerCopyWithImpl;
@override @useResult
$Res call({
 String badgeLabel, String title, String subtitle, String ctaLabel,@JsonKey(fromJson: _readInt) int extraCount, List<String> previewAvatars
});




}
/// @nodoc
class __$FindFriendsDnaBannerCopyWithImpl<$Res>
    implements _$FindFriendsDnaBannerCopyWith<$Res> {
  __$FindFriendsDnaBannerCopyWithImpl(this._self, this._then);

  final _FindFriendsDnaBanner _self;
  final $Res Function(_FindFriendsDnaBanner) _then;

/// Create a copy of FindFriendsDnaBanner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? badgeLabel = null,Object? title = null,Object? subtitle = null,Object? ctaLabel = null,Object? extraCount = null,Object? previewAvatars = null,}) {
  return _then(_FindFriendsDnaBanner(
badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,ctaLabel: null == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String,extraCount: null == extraCount ? _self.extraCount : extraCount // ignore: cast_nullable_to_non_nullable
as int,previewAvatars: null == previewAvatars ? _self._previewAvatars : previewAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$FindFriendsBadge {

 String get label; FindFriendsBadgeTone get tone; String? get icon;
/// Create a copy of FindFriendsBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsBadgeCopyWith<FindFriendsBadge> get copyWith => _$FindFriendsBadgeCopyWithImpl<FindFriendsBadge>(this as FindFriendsBadge, _$identity);

  /// Serializes this FindFriendsBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsBadge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsBadge&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.tone, _this.tone) || other.tone == _this.tone)&&(identical(other.icon, _this.icon) || other.icon == _this.icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsBadge;
  return Object.hash(runtimeType,_this.label,_this.tone,_this.icon);
}

@override
String toString() {
  final _this = this as FindFriendsBadge;
  return 'FindFriendsBadge(label: ${_this.label}, tone: ${_this.tone}, icon: ${_this.icon})';
}


}

/// @nodoc
abstract mixin class $FindFriendsBadgeCopyWith<$Res>  {
  factory $FindFriendsBadgeCopyWith(FindFriendsBadge value, $Res Function(FindFriendsBadge) _then) = _$FindFriendsBadgeCopyWithImpl;
@useResult
$Res call({
 String label, FindFriendsBadgeTone tone, String? icon
});




}
/// @nodoc
class _$FindFriendsBadgeCopyWithImpl<$Res>
    implements $FindFriendsBadgeCopyWith<$Res> {
  _$FindFriendsBadgeCopyWithImpl(this._self, this._then);

  final FindFriendsBadge _self;
  final $Res Function(FindFriendsBadge) _then;

/// Create a copy of FindFriendsBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? tone = null,Object? icon = freezed,}) {
  return _then(FindFriendsBadge(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as FindFriendsBadgeTone,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FindFriendsBadge].
extension FindFriendsBadgePatterns on FindFriendsBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsBadge value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsBadge value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  FindFriendsBadgeTone tone,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsBadge() when $default != null:
return $default(_that.label,_that.tone,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  FindFriendsBadgeTone tone,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsBadge():
return $default(_that.label,_that.tone,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  FindFriendsBadgeTone tone,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsBadge() when $default != null:
return $default(_that.label,_that.tone,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsBadge implements FindFriendsBadge {
  const _FindFriendsBadge({required this.label, this.tone = FindFriendsBadgeTone.subdued, this.icon});
  factory _FindFriendsBadge.fromJson(Map<String, dynamic> json) => _$FindFriendsBadgeFromJson(json);

@override final  String label;
@override@JsonKey() final  FindFriendsBadgeTone tone;
@override final  String? icon;

/// Create a copy of FindFriendsBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsBadgeCopyWith<_FindFriendsBadge> get copyWith => __$FindFriendsBadgeCopyWithImpl<_FindFriendsBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsBadge&&(identical(other.label, label) || other.label == label)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,tone,icon);
}

@override
String toString() {
    return 'FindFriendsBadge(label: $label, tone: $tone, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsBadgeCopyWith<$Res> implements $FindFriendsBadgeCopyWith<$Res> {
  factory _$FindFriendsBadgeCopyWith(_FindFriendsBadge value, $Res Function(_FindFriendsBadge) _then) = __$FindFriendsBadgeCopyWithImpl;
@override @useResult
$Res call({
 String label, FindFriendsBadgeTone tone, String? icon
});




}
/// @nodoc
class __$FindFriendsBadgeCopyWithImpl<$Res>
    implements _$FindFriendsBadgeCopyWith<$Res> {
  __$FindFriendsBadgeCopyWithImpl(this._self, this._then);

  final _FindFriendsBadge _self;
  final $Res Function(_FindFriendsBadge) _then;

/// Create a copy of FindFriendsBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? tone = null,Object? icon = freezed,}) {
  return _then(_FindFriendsBadge(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as FindFriendsBadgeTone,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FindFriendsUser {

 String get id; String get displayName; String get username; String? get avatarUrl; bool get isOnline; bool get verified; FindFriendsAction get action; String? get friendRequestId; String? get conversationId; List<FindFriendsBadge> get badges; String? get metaIcon; String? get metaLine; String? get travelPersona; int? get dnaMatchPercent; int? get sharedTripsCount;
/// Create a copy of FindFriendsUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsUserCopyWith<FindFriendsUser> get copyWith => _$FindFriendsUserCopyWithImpl<FindFriendsUser>(this as FindFriendsUser, _$identity);

  /// Serializes this FindFriendsUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.friendRequestId, _this.friendRequestId) || other.friendRequestId == _this.friendRequestId)&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&const DeepCollectionEquality().equals(other.badges, _this.badges)&&(identical(other.metaIcon, _this.metaIcon) || other.metaIcon == _this.metaIcon)&&(identical(other.metaLine, _this.metaLine) || other.metaLine == _this.metaLine)&&(identical(other.travelPersona, _this.travelPersona) || other.travelPersona == _this.travelPersona)&&(identical(other.dnaMatchPercent, _this.dnaMatchPercent) || other.dnaMatchPercent == _this.dnaMatchPercent)&&(identical(other.sharedTripsCount, _this.sharedTripsCount) || other.sharedTripsCount == _this.sharedTripsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsUser;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.username,_this.avatarUrl,_this.isOnline,_this.verified,_this.action,_this.friendRequestId,_this.conversationId,const DeepCollectionEquality().hash(_this.badges),_this.metaIcon,_this.metaLine,_this.travelPersona,_this.dnaMatchPercent,_this.sharedTripsCount);
}

@override
String toString() {
  final _this = this as FindFriendsUser;
  return 'FindFriendsUser(id: ${_this.id}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, isOnline: ${_this.isOnline}, verified: ${_this.verified}, action: ${_this.action}, friendRequestId: ${_this.friendRequestId}, conversationId: ${_this.conversationId}, badges: ${_this.badges}, metaIcon: ${_this.metaIcon}, metaLine: ${_this.metaLine}, travelPersona: ${_this.travelPersona}, dnaMatchPercent: ${_this.dnaMatchPercent}, sharedTripsCount: ${_this.sharedTripsCount})';
}


}

/// @nodoc
abstract mixin class $FindFriendsUserCopyWith<$Res>  {
  factory $FindFriendsUserCopyWith(FindFriendsUser value, $Res Function(FindFriendsUser) _then) = _$FindFriendsUserCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isOnline, bool verified, FindFriendsAction action, String? friendRequestId, String? conversationId, List<FindFriendsBadge> badges, String? metaIcon, String? metaLine, String? travelPersona, int? dnaMatchPercent, int? sharedTripsCount
});




}
/// @nodoc
class _$FindFriendsUserCopyWithImpl<$Res>
    implements $FindFriendsUserCopyWith<$Res> {
  _$FindFriendsUserCopyWithImpl(this._self, this._then);

  final FindFriendsUser _self;
  final $Res Function(FindFriendsUser) _then;

/// Create a copy of FindFriendsUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isOnline = null,Object? verified = null,Object? action = null,Object? friendRequestId = freezed,Object? conversationId = freezed,Object? badges = null,Object? metaIcon = freezed,Object? metaLine = freezed,Object? travelPersona = freezed,Object? dnaMatchPercent = freezed,Object? sharedTripsCount = freezed,}) {
  return _then(FindFriendsUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FindFriendsAction,friendRequestId: freezed == friendRequestId ? _self.friendRequestId : friendRequestId // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<FindFriendsBadge>,metaIcon: freezed == metaIcon ? _self.metaIcon : metaIcon // ignore: cast_nullable_to_non_nullable
as String?,metaLine: freezed == metaLine ? _self.metaLine : metaLine // ignore: cast_nullable_to_non_nullable
as String?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,dnaMatchPercent: freezed == dnaMatchPercent ? _self.dnaMatchPercent : dnaMatchPercent // ignore: cast_nullable_to_non_nullable
as int?,sharedTripsCount: freezed == sharedTripsCount ? _self.sharedTripsCount : sharedTripsCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FindFriendsUser].
extension FindFriendsUserPatterns on FindFriendsUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsUser value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsUser value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  FindFriendsAction action,  String? friendRequestId,  String? conversationId,  List<FindFriendsBadge> badges,  String? metaIcon,  String? metaLine,  String? travelPersona,  int? dnaMatchPercent,  int? sharedTripsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsUser() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.action,_that.friendRequestId,_that.conversationId,_that.badges,_that.metaIcon,_that.metaLine,_that.travelPersona,_that.dnaMatchPercent,_that.sharedTripsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  FindFriendsAction action,  String? friendRequestId,  String? conversationId,  List<FindFriendsBadge> badges,  String? metaIcon,  String? metaLine,  String? travelPersona,  int? dnaMatchPercent,  int? sharedTripsCount)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsUser():
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.action,_that.friendRequestId,_that.conversationId,_that.badges,_that.metaIcon,_that.metaLine,_that.travelPersona,_that.dnaMatchPercent,_that.sharedTripsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  FindFriendsAction action,  String? friendRequestId,  String? conversationId,  List<FindFriendsBadge> badges,  String? metaIcon,  String? metaLine,  String? travelPersona,  int? dnaMatchPercent,  int? sharedTripsCount)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsUser() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.action,_that.friendRequestId,_that.conversationId,_that.badges,_that.metaIcon,_that.metaLine,_that.travelPersona,_that.dnaMatchPercent,_that.sharedTripsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsUser implements FindFriendsUser {
  const _FindFriendsUser({required this.id, required this.displayName, required this.username, this.avatarUrl, this.isOnline = false, this.verified = false, this.action = FindFriendsAction.addFriend, this.friendRequestId, this.conversationId,  List<FindFriendsBadge> badges = const <FindFriendsBadge>[], this.metaIcon, this.metaLine, this.travelPersona, this.dnaMatchPercent, this.sharedTripsCount}): _badges = badges;
  factory _FindFriendsUser.fromJson(Map<String, dynamic> json) => _$FindFriendsUserFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  FindFriendsAction action;
@override final  String? friendRequestId;
@override final  String? conversationId;
 final  List<FindFriendsBadge> _badges;
@override@JsonKey() List<FindFriendsBadge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override final  String? metaIcon;
@override final  String? metaLine;
@override final  String? travelPersona;
@override final  int? dnaMatchPercent;
@override final  int? sharedTripsCount;

/// Create a copy of FindFriendsUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsUserCopyWith<_FindFriendsUser> get copyWith => __$FindFriendsUserCopyWithImpl<_FindFriendsUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsUser&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.action, action) || other.action == action)&&(identical(other.friendRequestId, friendRequestId) || other.friendRequestId == friendRequestId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other.badges, _badges)&&(identical(other.metaIcon, metaIcon) || other.metaIcon == metaIcon)&&(identical(other.metaLine, metaLine) || other.metaLine == metaLine)&&(identical(other.travelPersona, travelPersona) || other.travelPersona == travelPersona)&&(identical(other.dnaMatchPercent, dnaMatchPercent) || other.dnaMatchPercent == dnaMatchPercent)&&(identical(other.sharedTripsCount, sharedTripsCount) || other.sharedTripsCount == sharedTripsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,username,avatarUrl,isOnline,verified,action,friendRequestId,conversationId,const DeepCollectionEquality().hash(_badges),metaIcon,metaLine,travelPersona,dnaMatchPercent,sharedTripsCount);
}

@override
String toString() {
    return 'FindFriendsUser(id: $id, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, isOnline: $isOnline, verified: $verified, action: $action, friendRequestId: $friendRequestId, conversationId: $conversationId, badges: $badges, metaIcon: $metaIcon, metaLine: $metaLine, travelPersona: $travelPersona, dnaMatchPercent: $dnaMatchPercent, sharedTripsCount: $sharedTripsCount)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsUserCopyWith<$Res> implements $FindFriendsUserCopyWith<$Res> {
  factory _$FindFriendsUserCopyWith(_FindFriendsUser value, $Res Function(_FindFriendsUser) _then) = __$FindFriendsUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isOnline, bool verified, FindFriendsAction action, String? friendRequestId, String? conversationId, List<FindFriendsBadge> badges, String? metaIcon, String? metaLine, String? travelPersona, int? dnaMatchPercent, int? sharedTripsCount
});




}
/// @nodoc
class __$FindFriendsUserCopyWithImpl<$Res>
    implements _$FindFriendsUserCopyWith<$Res> {
  __$FindFriendsUserCopyWithImpl(this._self, this._then);

  final _FindFriendsUser _self;
  final $Res Function(_FindFriendsUser) _then;

/// Create a copy of FindFriendsUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isOnline = null,Object? verified = null,Object? action = null,Object? friendRequestId = freezed,Object? conversationId = freezed,Object? badges = null,Object? metaIcon = freezed,Object? metaLine = freezed,Object? travelPersona = freezed,Object? dnaMatchPercent = freezed,Object? sharedTripsCount = freezed,}) {
  return _then(_FindFriendsUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FindFriendsAction,friendRequestId: freezed == friendRequestId ? _self.friendRequestId : friendRequestId // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<FindFriendsBadge>,metaIcon: freezed == metaIcon ? _self.metaIcon : metaIcon // ignore: cast_nullable_to_non_nullable
as String?,metaLine: freezed == metaLine ? _self.metaLine : metaLine // ignore: cast_nullable_to_non_nullable
as String?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,dnaMatchPercent: freezed == dnaMatchPercent ? _self.dnaMatchPercent : dnaMatchPercent // ignore: cast_nullable_to_non_nullable
as int?,sharedTripsCount: freezed == sharedTripsCount ? _self.sharedTripsCount : sharedTripsCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$FindFriendsNearbySuggestion {

 String get id; String get displayName; String? get avatarUrl; String get subtitle; String get chipLabel; FindFriendsContactChipTone get chipTone; FindFriendsAction get action; String? get friendRequestId; double? get distanceKm;
/// Create a copy of FindFriendsNearbySuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsNearbySuggestionCopyWith<FindFriendsNearbySuggestion> get copyWith => _$FindFriendsNearbySuggestionCopyWithImpl<FindFriendsNearbySuggestion>(this as FindFriendsNearbySuggestion, _$identity);

  /// Serializes this FindFriendsNearbySuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsNearbySuggestion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsNearbySuggestion&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.chipLabel, _this.chipLabel) || other.chipLabel == _this.chipLabel)&&(identical(other.chipTone, _this.chipTone) || other.chipTone == _this.chipTone)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.friendRequestId, _this.friendRequestId) || other.friendRequestId == _this.friendRequestId)&&(identical(other.distanceKm, _this.distanceKm) || other.distanceKm == _this.distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsNearbySuggestion;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.avatarUrl,_this.subtitle,_this.chipLabel,_this.chipTone,_this.action,_this.friendRequestId,_this.distanceKm);
}

@override
String toString() {
  final _this = this as FindFriendsNearbySuggestion;
  return 'FindFriendsNearbySuggestion(id: ${_this.id}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, subtitle: ${_this.subtitle}, chipLabel: ${_this.chipLabel}, chipTone: ${_this.chipTone}, action: ${_this.action}, friendRequestId: ${_this.friendRequestId}, distanceKm: ${_this.distanceKm})';
}


}

/// @nodoc
abstract mixin class $FindFriendsNearbySuggestionCopyWith<$Res>  {
  factory $FindFriendsNearbySuggestionCopyWith(FindFriendsNearbySuggestion value, $Res Function(FindFriendsNearbySuggestion) _then) = _$FindFriendsNearbySuggestionCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String? avatarUrl, String subtitle, String chipLabel, FindFriendsContactChipTone chipTone, FindFriendsAction action, String? friendRequestId, double? distanceKm
});




}
/// @nodoc
class _$FindFriendsNearbySuggestionCopyWithImpl<$Res>
    implements $FindFriendsNearbySuggestionCopyWith<$Res> {
  _$FindFriendsNearbySuggestionCopyWithImpl(this._self, this._then);

  final FindFriendsNearbySuggestion _self;
  final $Res Function(FindFriendsNearbySuggestion) _then;

/// Create a copy of FindFriendsNearbySuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? avatarUrl = freezed,Object? subtitle = null,Object? chipLabel = null,Object? chipTone = null,Object? action = null,Object? friendRequestId = freezed,Object? distanceKm = freezed,}) {
  return _then(FindFriendsNearbySuggestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,chipLabel: null == chipLabel ? _self.chipLabel : chipLabel // ignore: cast_nullable_to_non_nullable
as String,chipTone: null == chipTone ? _self.chipTone : chipTone // ignore: cast_nullable_to_non_nullable
as FindFriendsContactChipTone,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FindFriendsAction,friendRequestId: freezed == friendRequestId ? _self.friendRequestId : friendRequestId // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [FindFriendsNearbySuggestion].
extension FindFriendsNearbySuggestionPatterns on FindFriendsNearbySuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsNearbySuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsNearbySuggestion value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsNearbySuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String? avatarUrl,  String subtitle,  String chipLabel,  FindFriendsContactChipTone chipTone,  FindFriendsAction action,  String? friendRequestId,  double? distanceKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.subtitle,_that.chipLabel,_that.chipTone,_that.action,_that.friendRequestId,_that.distanceKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String? avatarUrl,  String subtitle,  String chipLabel,  FindFriendsContactChipTone chipTone,  FindFriendsAction action,  String? friendRequestId,  double? distanceKm)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion():
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.subtitle,_that.chipLabel,_that.chipTone,_that.action,_that.friendRequestId,_that.distanceKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String? avatarUrl,  String subtitle,  String chipLabel,  FindFriendsContactChipTone chipTone,  FindFriendsAction action,  String? friendRequestId,  double? distanceKm)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsNearbySuggestion() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.subtitle,_that.chipLabel,_that.chipTone,_that.action,_that.friendRequestId,_that.distanceKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsNearbySuggestion implements FindFriendsNearbySuggestion {
  const _FindFriendsNearbySuggestion({required this.id, required this.displayName, this.avatarUrl, required this.subtitle, required this.chipLabel, this.chipTone = FindFriendsContactChipTone.primary, this.action = FindFriendsAction.addFriend, this.friendRequestId, this.distanceKm});
  factory _FindFriendsNearbySuggestion.fromJson(Map<String, dynamic> json) => _$FindFriendsNearbySuggestionFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String subtitle;
@override final  String chipLabel;
@override@JsonKey() final  FindFriendsContactChipTone chipTone;
@override@JsonKey() final  FindFriendsAction action;
@override final  String? friendRequestId;
@override final  double? distanceKm;

/// Create a copy of FindFriendsNearbySuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsNearbySuggestionCopyWith<_FindFriendsNearbySuggestion> get copyWith => __$FindFriendsNearbySuggestionCopyWithImpl<_FindFriendsNearbySuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsNearbySuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsNearbySuggestion&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.chipLabel, chipLabel) || other.chipLabel == chipLabel)&&(identical(other.chipTone, chipTone) || other.chipTone == chipTone)&&(identical(other.action, action) || other.action == action)&&(identical(other.friendRequestId, friendRequestId) || other.friendRequestId == friendRequestId)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,avatarUrl,subtitle,chipLabel,chipTone,action,friendRequestId,distanceKm);
}

@override
String toString() {
    return 'FindFriendsNearbySuggestion(id: $id, displayName: $displayName, avatarUrl: $avatarUrl, subtitle: $subtitle, chipLabel: $chipLabel, chipTone: $chipTone, action: $action, friendRequestId: $friendRequestId, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsNearbySuggestionCopyWith<$Res> implements $FindFriendsNearbySuggestionCopyWith<$Res> {
  factory _$FindFriendsNearbySuggestionCopyWith(_FindFriendsNearbySuggestion value, $Res Function(_FindFriendsNearbySuggestion) _then) = __$FindFriendsNearbySuggestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String? avatarUrl, String subtitle, String chipLabel, FindFriendsContactChipTone chipTone, FindFriendsAction action, String? friendRequestId, double? distanceKm
});




}
/// @nodoc
class __$FindFriendsNearbySuggestionCopyWithImpl<$Res>
    implements _$FindFriendsNearbySuggestionCopyWith<$Res> {
  __$FindFriendsNearbySuggestionCopyWithImpl(this._self, this._then);

  final _FindFriendsNearbySuggestion _self;
  final $Res Function(_FindFriendsNearbySuggestion) _then;

/// Create a copy of FindFriendsNearbySuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? avatarUrl = freezed,Object? subtitle = null,Object? chipLabel = null,Object? chipTone = null,Object? action = null,Object? friendRequestId = freezed,Object? distanceKm = freezed,}) {
  return _then(_FindFriendsNearbySuggestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,chipLabel: null == chipLabel ? _self.chipLabel : chipLabel // ignore: cast_nullable_to_non_nullable
as String,chipTone: null == chipTone ? _self.chipTone : chipTone // ignore: cast_nullable_to_non_nullable
as FindFriendsContactChipTone,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FindFriendsAction,friendRequestId: freezed == friendRequestId ? _self.friendRequestId : friendRequestId // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$FindFriendsRequestSent {

 String get id; String get fromUserId; String get toUserId; String get status;
/// Create a copy of FindFriendsRequestSent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindFriendsRequestSentCopyWith<FindFriendsRequestSent> get copyWith => _$FindFriendsRequestSentCopyWithImpl<FindFriendsRequestSent>(this as FindFriendsRequestSent, _$identity);

  /// Serializes this FindFriendsRequestSent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FindFriendsRequestSent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindFriendsRequestSent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fromUserId, _this.fromUserId) || other.fromUserId == _this.fromUserId)&&(identical(other.toUserId, _this.toUserId) || other.toUserId == _this.toUserId)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FindFriendsRequestSent;
  return Object.hash(runtimeType,_this.id,_this.fromUserId,_this.toUserId,_this.status);
}

@override
String toString() {
  final _this = this as FindFriendsRequestSent;
  return 'FindFriendsRequestSent(id: ${_this.id}, fromUserId: ${_this.fromUserId}, toUserId: ${_this.toUserId}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $FindFriendsRequestSentCopyWith<$Res>  {
  factory $FindFriendsRequestSentCopyWith(FindFriendsRequestSent value, $Res Function(FindFriendsRequestSent) _then) = _$FindFriendsRequestSentCopyWithImpl;
@useResult
$Res call({
 String id, String fromUserId, String toUserId, String status
});




}
/// @nodoc
class _$FindFriendsRequestSentCopyWithImpl<$Res>
    implements $FindFriendsRequestSentCopyWith<$Res> {
  _$FindFriendsRequestSentCopyWithImpl(this._self, this._then);

  final FindFriendsRequestSent _self;
  final $Res Function(FindFriendsRequestSent) _then;

/// Create a copy of FindFriendsRequestSent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? status = null,}) {
  return _then(FindFriendsRequestSent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FindFriendsRequestSent].
extension FindFriendsRequestSentPatterns on FindFriendsRequestSent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindFriendsRequestSent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindFriendsRequestSent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindFriendsRequestSent value)  $default,){
final _that = this;
switch (_that) {
case _FindFriendsRequestSent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindFriendsRequestSent value)?  $default,){
final _that = this;
switch (_that) {
case _FindFriendsRequestSent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindFriendsRequestSent() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String status)  $default,) {final _that = this;
switch (_that) {
case _FindFriendsRequestSent():
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromUserId,  String toUserId,  String status)?  $default,) {final _that = this;
switch (_that) {
case _FindFriendsRequestSent() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FindFriendsRequestSent implements FindFriendsRequestSent {
  const _FindFriendsRequestSent({required this.id, required this.fromUserId, required this.toUserId, required this.status});
  factory _FindFriendsRequestSent.fromJson(Map<String, dynamic> json) => _$FindFriendsRequestSentFromJson(json);

@override final  String id;
@override final  String fromUserId;
@override final  String toUserId;
@override final  String status;

/// Create a copy of FindFriendsRequestSent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindFriendsRequestSentCopyWith<_FindFriendsRequestSent> get copyWith => __$FindFriendsRequestSentCopyWithImpl<_FindFriendsRequestSent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FindFriendsRequestSentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindFriendsRequestSent&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,fromUserId,toUserId,status);
}

@override
String toString() {
    return 'FindFriendsRequestSent(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$FindFriendsRequestSentCopyWith<$Res> implements $FindFriendsRequestSentCopyWith<$Res> {
  factory _$FindFriendsRequestSentCopyWith(_FindFriendsRequestSent value, $Res Function(_FindFriendsRequestSent) _then) = __$FindFriendsRequestSentCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromUserId, String toUserId, String status
});




}
/// @nodoc
class __$FindFriendsRequestSentCopyWithImpl<$Res>
    implements _$FindFriendsRequestSentCopyWith<$Res> {
  __$FindFriendsRequestSentCopyWithImpl(this._self, this._then);

  final _FindFriendsRequestSent _self;
  final $Res Function(_FindFriendsRequestSent) _then;

/// Create a copy of FindFriendsRequestSent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? status = null,}) {
  return _then(_FindFriendsRequestSent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
