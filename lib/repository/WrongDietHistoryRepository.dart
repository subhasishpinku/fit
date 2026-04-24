// wrong_diet_history_repository.dart

import 'dart:convert';
import 'package:aifitness/models/WrongDietHistoryModel.dart';
import 'package:http/http.dart' as http;

class WrongDietHistoryRepository {
  final String baseUrl = "https://aipoweredfitness.com/api";

  Future<WrongDietHistoryModel> getWrongDietHistory(
      String week, int userId) async {

    final body = {
      "week": week,
      "user_id": userId.toString(),
    };

    final response = await http.post(
      Uri.parse("$baseUrl/ai-get-wrong-diet-history"),
      body: body,
    );

    if (response.statusCode == 200) {
      return WrongDietHistoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch wrong diet history");
    }
  }
}
