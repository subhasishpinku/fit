import 'dart:convert';
import 'package:aifitness/models/food_model.dart';
import 'package:http/http.dart' as http;

class FoodRepository {
  // final String baseUrl = "https://aipoweredfitness.com/api/get-foods-ai";
  final String baseUrl = "https://aipoweredfitness.com/api/get-foods-ai";

  Future<List<FoodModel>> getFoods({
    required String classification,
    required String type,
    required String search,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "classification": classification,
          "type": type,
          "search": search,
          "sub_category": "",
        }),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // FIX: API uses "success", not "status"
        if (body["success"] == true && body["data"] is List) {
          return (body["data"] as List)
              .map((item) => FoodModel.fromJson(item))
              .toList();
        }

        return [];
      }

      return [];
    } catch (e) {
      print("ERROR FETCHING FOODS: $e");
      return [];
    }
  }
  Future<List<FoodModel>> getFoods1({
     required String classification,
  required String type,
  required String search,
  required String subCategory,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "classification": classification,
          "type": type,
          "search": search,
         "sub_category": subCategory, // 🔥 IMPORTANT
        }),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // FIX: API uses "success", not "status"
        if (body["success"] == true && body["data"] is List) {
          return (body["data"] as List)
              .map((item) => FoodModel.fromJson(item))
              .toList();
        }

        return [];
      }

      return [];
    } catch (e) {
      print("ERROR FETCHING FOODS: $e");
      return [];
    }
  }
}