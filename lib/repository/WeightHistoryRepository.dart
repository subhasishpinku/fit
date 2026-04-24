import 'dart:convert';
import 'package:aifitness/models/WeightLogModel.dart';
import 'package:http/http.dart' as http;

class WeightHistoryRepository {

  Future<List<WeightLogModel>> getWeightLogs(Map<String, dynamic> body) async {
    final url = Uri.parse("https://aipoweredfitness.com/api/ai-get-weight-logs");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<dynamic> list = jsonData["data"] ?? [];

      return list.map((e) => WeightLogModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load weight logs");
    }
  }
}
