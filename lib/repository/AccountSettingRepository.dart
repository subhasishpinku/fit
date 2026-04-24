import 'dart:convert';
import 'package:dio/dio.dart';

class AccountSettingRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> deleteProfile(int userId) async {
    const url = "https://aipoweredfitness.com/api/delete-profile";

    final response = await _dio.post(url, data: {"user_id": userId});

    // Ensure response is Map
    if (response.data is String) {
      return jsonDecode(response.data);
    }

    return response.data;
  }
}
