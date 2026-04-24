import 'dart:convert';
import 'package:aifitness/models/FullBodyPlanModel.dart';
import 'package:http/http.dart' as http;

class FullBodyPlanRepository {
  final String baseUrl =
      "https://aipoweredfitness.com/api/get-full-body-plan-workouts-new-ai-app";

  Future<FullBodyPlanModel> fetchFullBodyPlan(Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(baseUrl), body: body);

    if (response.statusCode == 200) {
      return FullBodyPlanModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load full body plan");
    }
  }
}
