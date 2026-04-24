import 'dart:convert';
import 'package:aifitness/models/WeightLogResponse.dart';
import 'package:http/http.dart' as http;

class WeightRepository {

  Future<WeightLogResponse> addWeightLog(Map<String, dynamic> body) async {
    final url = Uri.parse("https://aipoweredfitness.com/api/ai-add-weight-logs");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return WeightLogResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add log: ${response.body}");
    }
  }
}
