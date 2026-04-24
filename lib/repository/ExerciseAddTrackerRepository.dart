import 'dart:convert';

import 'package:dio/dio.dart';

class ExerciseAddTrackerRepository {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<bool> saveExerciseTracker(Map<String, dynamic> data) async {
    const url = "https://aipoweredfitness.com/api/ai-add-exercise-tracker";

    try {
      final res = await _dio.post(url, data: data);
      print("Raw Response: ${res.data}");

      dynamic body = res.data;

      // If response comes as String → decode
      if (body is String) {
        try {
          body = jsonDecode(body);
        } catch (_) {}
      }

      if (body is Map && body["success"].toString() == "true") {
        print("successView: $body");
        return true;
      }

      return false;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
