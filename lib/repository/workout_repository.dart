import 'dart:convert';
import 'package:aifitness/models/exercise_models.dart';
import 'package:http/http.dart' as http;

class WorkoutRepository {
  Future<List<Exercise>> fetchWorkouts({
    required int userId,
    required String day,
    required String deviceId,
  }) async {
    const url = "https://aipoweredfitness.com/api/get-full-body-plan-workouts-new-ai-app";

    final response = await http.post(
      Uri.parse(url),
      body: {
        "user_id": userId.toString(),
        "day": day,
        "device_id": deviceId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed: ${response.statusCode}");
    }

    final jsonData = jsonDecode(response.body);

    if (jsonData["success"] != true) {
      throw Exception("API returned false");
    }

    List exercises = jsonData["data"]["exercises"];

    return exercises.map((e) => Exercise.fromJson(e)).toList();
  }
}
