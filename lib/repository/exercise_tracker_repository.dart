import '../data/network/api_service.dart';
import '../models/exercise_tracker_model.dart';

class ExerciseTrackerRepository {
  final _apiService = ApiService();

  Future<List<ExerciseTrackerModel>> getExerciseHistory(int userId, int exerciseId) async {
    const url = "https://aipoweredfitness.com/api/ai-get-exercise-tracker";

    final response = await _apiService.postRequest(url, {
      "user_id": userId,
      "exercise_id": exerciseId,
    });

    List data = response.data["data"];
    return data.map((item) => ExerciseTrackerModel.fromJson(item)).toList();
  }
}
