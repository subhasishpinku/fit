import 'dart:convert';
import 'package:aifitness/viewModel/days_model.dart';
import 'package:http/http.dart' as http;

class ViewPlanRepository {
  Future<DaysModel?> fetchDays(int userId) async {
    const url = "https://aipoweredfitness.com/api/get-days-new-app";

    try {
      final response = await http.post(Uri.parse(url), body: {"user_id": userId.toString()});
      final json = jsonDecode(response.body);

      if (json["success"] == true) {
        return DaysModel.fromJson(json["data"]);
      }
    } catch (e) {
      print("Repository Error: $e");
    }
    return null;
  }
}
