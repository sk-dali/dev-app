import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStorageService {
  static const String _favoriteTalkIdsKey = 'favorite_talk_ids';
  static const String _missionHistoryKey = 'mission_history';

  Future<void> saveFavoriteTalkIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteTalkIdsKey, ids);
  }

  Future<List<String>> loadFavoriteTalkIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteTalkIdsKey) ?? [];
  }

  Future<void> saveMissionHistory(String dateKey, List<String> missionIds) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadMissionHistory();
    existing[dateKey] = missionIds;
    
    // MapをJSON形式で保存（簡易実装）
    final keys = existing.keys.toList();
    final values = existing.values.map((ids) => ids.join(',')).toList();
    await prefs.setStringList('${_missionHistoryKey}_keys', keys);
    await prefs.setStringList('${_missionHistoryKey}_values', values);
  }

  Future<Map<String, List<String>>> loadMissionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getStringList('${_missionHistoryKey}_keys') ?? [];
    final values = prefs.getStringList('${_missionHistoryKey}_values') ?? [];
    
    final result = <String, List<String>>{};
    for (int i = 0; i < keys.length && i < values.length; i++) {
      result[keys[i]] = values[i].split(',').where((id) => id.isNotEmpty).toList();
    }
    return result;
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

