import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_memories_models.freezed.dart';
part 'user_memories_models.g.dart';

/// `GET /trips/memories/mine`. Collections and highlight are null after the
/// first page.
@freezed
abstract class UserMemoriesPage with _$UserMemoriesPage {
  const factory UserMemoriesPage({
    @JsonKey(name: 'data')
    @Default(<UserMemoryPhoto>[])
    List<UserMemoryPhoto> items,
    List<UserMemoryCollection>? collections,
    UserMemoryPhoto? highlight,
    required UserMemoriesMeta meta,
  }) = _UserMemoriesPage;

  factory UserMemoriesPage.fromJson(Map<String, dynamic> json) =>
      _$UserMemoriesPageFromJson(json);
}

@freezed
abstract class UserMemoriesMeta with _$UserMemoriesMeta {
  const factory UserMemoriesMeta({
    String? nextCursor,
    @Default(false) bool hasMore,
    int? totalCount,
  }) = _UserMemoriesMeta;

  factory UserMemoriesMeta.fromJson(Map<String, dynamic> json) =>
      _$UserMemoriesMetaFromJson(json);
}

@freezed
abstract class UserMemoryCollection with _$UserMemoryCollection {
  const factory UserMemoryCollection({
    required String tripId,
    required String name,
    required String status,
    required int memoryCount,
  }) = _UserMemoryCollection;

  factory UserMemoryCollection.fromJson(Map<String, dynamic> json) =>
      _$UserMemoryCollectionFromJson(json);
}

@freezed
abstract class UserMemoryPhoto with _$UserMemoryPhoto {
  const factory UserMemoryPhoto({
    required String id,
    required String tripId,
    required String tripName,
    String? caption,
    required DateTime createdAt,
    required String imageUrl,
    String? badge,
    required int likeCount,
    @Default(false) bool liked,
  }) = _UserMemoryPhoto;

  factory UserMemoryPhoto.fromJson(Map<String, dynamic> json) =>
      _$UserMemoryPhotoFromJson(json);
}

@freezed
abstract class UserMemoryLike with _$UserMemoryLike {
  const factory UserMemoryLike({required int likeCount, required bool liked}) =
      _UserMemoryLike;

  factory UserMemoryLike.fromJson(Map<String, dynamic> json) =>
      _$UserMemoryLikeFromJson(json);
}
