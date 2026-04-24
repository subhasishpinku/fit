import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:aifitness/data/network/api_service.dart';

class SigninThirteenRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchFatLossData(
    Map<String, dynamic> body,
  ) async {
    try {
      final Response response = await _apiService.postRequest(
        "fetch-pre-register-detail",
        body,
      );

      print("🔹 Raw response type: ${response.data.runtimeType}");
      print("🔹 Raw response11: ${response.data}");

      dynamic responseData = response.data;

      //  Case 1: response is a string (decode it)
      if (responseData is String) {
        try {
          responseData = jsonDecode(responseData);
        } catch (e) {
          throw Exception("Response is not valid JSON: $responseData");
        }
      }

      //  Case 2: response must now be a JSON Map
      if (responseData is Map<String, dynamic>) {
        if (responseData["success"] == true &&
            responseData.containsKey("data")) {
          return responseData["data"];
        } else {
          throw Exception(responseData["message"] ?? "Invalid response format");
        }
      } else {
        throw Exception(
          "Unexpected response format after decoding: ${responseData.runtimeType}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
