import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/ai_details_model.dart';

class AiDetailsRepository {
  final String _url = "https://aipoweredfitness.com/api/get-details-ai";
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

  Future<AiDetailsResponse> getAiUserDetails({
    required String deviceId,
    required int userId,
  }) async {
    try {
      final response = await _dio.post(
        _url,
        data: {"device_id": deviceId, "user_id": userId},
      );

      if (response.statusCode == 200) {
        // Ensure JSON string → Map conversion
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        return AiDetailsResponse.fromJson(data);
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fetching AI details failed: $e");
    }
  }
}
