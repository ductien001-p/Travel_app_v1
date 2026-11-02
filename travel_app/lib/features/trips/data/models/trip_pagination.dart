class PageMeta {
  const PageMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  factory PageMeta.fromJson(Map<String, dynamic> json) => PageMeta(
    page: json['page'] as int,
    limit: json['limit'] as int,
    total: json['total'] as int,
    totalPages: json['totalPages'] as int,
    hasNextPage: json['hasNextPage'] as bool,
    hasPreviousPage: json['hasPreviousPage'] as bool,
  );
}

class PageResult<T> {
  const PageResult({required this.items, required this.meta});
  final List<T> items;
  final PageMeta meta;
}
