import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _recentSearchesKey = 'find_friends.recent_searches.v1';

final findFriendsRecentSearchesStoreProvider =
    Provider<FindFriendsRecentSearchesStore>(
      (ref) => const FindFriendsRecentSearchesStore(),
    );

class FindFriendsRecentSearchesStore {
  const FindFriendsRecentSearchesStore();

  Future<List<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? const <String>[];
  }

  Future<void> save(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, items);
  }
}
