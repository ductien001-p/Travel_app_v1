import '../data/models/social_post_detail_models.dart';

enum SocialPostCommentSort { relevant, newest }

class SocialPostDetailView {
  const SocialPostDetailView({
    required this.post,
    required this.comments,
    required this.hasNextComments,
    required this.remainingComments,
    required this.hashtags,
    required this.captionBody,
    required this.visibilityLabel,
    required this.composerHint,
    required this.sort,
  });

  final SocialPostDetail post;
  final List<SocialPostDetailComment> comments;
  final bool hasNextComments;
  final int remainingComments;
  final List<String> hashtags;
  final String captionBody;
  final String visibilityLabel;
  final String composerHint;
  final SocialPostCommentSort sort;

  String get authorDisplayName {
    final name = post.author.displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return post.author.username;
  }

  String get placeSubtitle {
    final detail = post.place?.detail ?? post.placeDetail;
    if (detail == null || detail.trim().isEmpty) return '';
    return detail.trim();
  }

  String get logSubtitle {
    final place = post.place?.name.trim();
    if (place != null && place.isNotEmpty) return '$place Travel Log';
    return 'Bảng tin Teal Horizon';
  }
}

SocialPostDetailView buildSocialPostDetailView({
  required SocialPostDetail post,
  required List<SocialPostDetailComment> comments,
  required bool hasNextComments,
  required int commentsTotal,
  required SocialPostCommentSort sort,
}) {
  final parsed = splitCaptionAndHashtags(post.caption ?? '');
  final sorted = sortComments(comments, sort);
  final remaining = (commentsTotal - sorted.length).clamp(0, commentsTotal);
  return SocialPostDetailView(
    post: post,
    comments: sorted,
    hasNextComments: hasNextComments,
    remainingComments: remaining,
    hashtags: parsed.hashtags,
    captionBody: parsed.body,
    visibilityLabel: visibilityLabelVi(post.visibility),
    composerHint:
        'Viết bình luận cho ${post.author.displayName?.trim().isNotEmpty == true ? post.author.displayName!.trim() : post.author.username}...',
    sort: sort,
  );
}

({String body, List<String> hashtags}) splitCaptionAndHashtags(String caption) {
  final matches = RegExp(
    r'#([\p{L}\p{N}_]+)',
    unicode: true,
  ).allMatches(caption);
  final tags = <String>[];
  for (final match in matches) {
    final tag = match.group(0);
    if (tag == null || tag.isEmpty) continue;
    if (!tags.contains(tag)) tags.add(tag);
  }
  final body = caption
      .replaceAll(RegExp(r'(?:\s*#[\p{L}\p{N}_]+)+$', unicode: true), '')
      .trim();
  return (body: body.isEmpty ? caption.trim() : body, hashtags: tags);
}

List<SocialPostDetailComment> sortComments(
  List<SocialPostDetailComment> comments,
  SocialPostCommentSort sort,
) {
  final copy = [...comments];
  switch (sort) {
    case SocialPostCommentSort.newest:
      copy.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    case SocialPostCommentSort.relevant:
      // API chưa có điểm liên quan — giữ thứ tự tải (mới nhất trước).
      copy.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
  return copy;
}

String visibilityLabelVi(String visibility) {
  switch (visibility.toUpperCase()) {
    case 'FOLLOWERS':
      return 'Người theo dõi';
    case 'PRIVATE':
      return 'Riêng tư';
    case 'PUBLIC':
    default:
      return 'Công khai';
  }
}

String formatCommentTimeLabel(DateTime createdAt, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final diff = current.difference(createdAt.toLocal());
  if (diff.inMinutes < 1) return 'Vừa xong';
  if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
  if (diff.inHours < 24) return '${diff.inHours} giờ trước';
  if (diff.inDays < 7) return '${diff.inDays} ngày trước';
  return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
}

String formatCountLabel(int count) {
  if (count >= 1000000) {
    final value = count / 1000000;
    return value == value.roundToDouble()
        ? '${value.toInt()}M'
        : '${value.toStringAsFixed(1)}M';
  }
  if (count >= 1000) {
    final value = count / 1000;
    return value == value.roundToDouble()
        ? '${value.toInt()}K'
        : '${value.toStringAsFixed(1)}K';
  }
  return '$count';
}

String socialPostDetailFailureMessage(Object error) {
  final text = error.toString().toLowerCase();
  if (text.contains('401') || text.contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem bài viết.';
  }
  if (text.contains('404') || text.contains('not found')) {
    return 'Bài viết không tồn tại hoặc đã bị xóa.';
  }
  return 'Không tải được bài viết. Thử lại sau.';
}

bool socialPostDetailFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
