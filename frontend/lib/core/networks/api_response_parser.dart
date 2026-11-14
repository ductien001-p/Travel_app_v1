//dung de lay data tu response backend tra ve {success, data}
abstract final class ApiResponseParser {
  static Map<String, dynamic> dataMap(Map<String, dynamic> body) {
    final rawData = body['data'];

    if (rawData is Map) {
      return Map<String, dynamic>.from(rawData);
    }

    return body;
  }

  static Map<String, dynamic> nestedMap(Map<String, dynamic> body, String key) {
    final parent = dataMap(body);

    final value = parent[key];

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return parent;
  }
}
