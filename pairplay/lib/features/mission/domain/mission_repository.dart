import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/mission.dart';
import '../data/mock_mission_data.dart';

abstract class MissionRepository {
  List<Mission> getByPlaceCategory(String placeCategory);
  List<Mission> getAll();
}

class MissionRepositoryImpl implements MissionRepository {
  @override
  List<Mission> getByPlaceCategory(String placeCategory) {
    return mockMissions
        .where((mission) => mission.placeCategory == placeCategory)
        .toList();
  }

  @override
  List<Mission> getAll() {
    return List.from(mockMissions);
  }
}

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepositoryImpl();
});

