import 'dart:convert';
import 'package:aifitness/data/network/api_service.dart';
import 'package:dio/dio.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

class RegisterRepository1 {
  final ApiService _apiService = ApiService();

  Future<RegisterResponse> registerUser(RegisterRequest request) async {
    Response response = await _apiService.postRequest(
      "register",
      request.toJson(),
    );

    var raw = response.data;

    Map<String, dynamic> jsonMap;

    if (raw is String) {
      jsonMap = jsonDecode(raw); // FIX
    } else {
      jsonMap = raw;
    }

    return RegisterResponse.fromJson(jsonMap);
  }
}
