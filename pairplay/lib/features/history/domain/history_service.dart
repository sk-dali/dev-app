import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/local_storage_service.dart';

class HistoryService {
  final LocalStorageService _storageService;

  HistoryService(this._storageService);

  Future<void> addMissionSession(DateTime date, List<String> doneMissionIds) async {
    final dateKey = _formatDate(date);
    await _storageService.saveMissionHistory(dateKey, doneMissionIds);
  }

  Future<Map<String, List<String>>> loadAllMissionSessions() async {
    return await _storageService.loadMissionHistory();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

final historyServiceProvider = Provider<HistoryService>((ref) {
  final storageService = ref.read(localStorageServiceProvider);
  return HistoryService(storageService);
});

