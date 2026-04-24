import 'package:dio/dio.dart';
import '../models/wrong_diet_model.dart';

class WrongDietRepository {
  final Dio _dio = Dio();

  Future<WrongDietModel> addWrongDiet(Map<String, dynamic> body) async {
    const url = "https://aipoweredfitness.com/api/ai-add-wrong-diet";

    final response = await _dio.post(url, data: body);

    if (response.statusCode == 200 && response.data["success"] == true) {
      return WrongDietModel.fromJson(response.data["data"]);
    } else {
      throw Exception("Failed to add wrong diet");
    }
  }
}
