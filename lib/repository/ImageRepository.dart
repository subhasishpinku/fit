import 'dart:convert';
import 'package:aifitness/viewModel/weight_progress_model.dart';
import 'package:dio/dio.dart';

class ImageRepository {
  final String _url =
      "https://aipoweredfitness.com/api/get-weight-progress-list";
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
    ),
  );

  Future<WeightProgressResponse> getAiUserDetails({
    required String deviceId,
    required int userId,
  }) async {
    try {
      final response = await _dio.post(
        _url,
        data: {"device_id": deviceId, "user_id": userId},
      );

      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        print("ImageDetails: $data");

        return WeightProgressResponse.fromJson(data);
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fetching AI details failed: $e");
    }
  }
}
