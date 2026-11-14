import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';

class SocialPostComment {
  const SocialPostComment({
    required this.id,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.authorId,
    required this.authorName,
    this.avatarId,
  });

  final String id;
  final String postId;
  final String content;
  final DateTime createdAt;
  final String authorId;
  final String authorName;
  final String? avatarId;

  factory SocialPostComment.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final userMap = user is Map<String, dynamic>
        ? user
        : user is Map
        ? Map<String, dynamic>.from(user)
        : const <String, dynamic>{};
    final username = userMap['username']?.toString();
    return SocialPostComment(
      id: json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      authorId: userMap['id']?.toString() ?? json['userId']?.toString() ?? '',
      authorName: (username != null && username.isNotEmpty) ? username : 'Bạn',
      avatarId: userMap['avatarId']?.toString(),
    );
  }
}

class SocialPostCommentsPage {
  const SocialPostCommentsPage({required this.data, required this.meta});

  final List<SocialPostComment> data;
  final PageMeta meta;

  factory SocialPostCommentsPage.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    final list = raw is List
        ? raw
              .whereType<Object>()
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return SocialPostComment.fromJson(item);
                }
                if (item is Map) {
                  return SocialPostComment.fromJson(
                    Map<String, dynamic>.from(item),
                  );
                }
                return null;
              })
              .whereType<SocialPostComment>()
              .toList()
        : const <SocialPostComment>[];
    final metaJson = json['meta'];
    final meta = metaJson is Map<String, dynamic>
        ? PageMeta.fromJson(metaJson)
        : metaJson is Map
        ? PageMeta.fromJson(Map<String, dynamic>.from(metaJson))
        : const PageMeta(
            page: 1,
            limit: 20,
            total: 0,
            totalPages: 0,
            hasNextPage: false,
            hasPreviousPage: false,
          );
    return SocialPostCommentsPage(data: list, meta: meta);
  }
}
