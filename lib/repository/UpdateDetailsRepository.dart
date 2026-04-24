import 'dart:convert';
import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/models/UpdateDetailsRequest.dart';
import 'package:aifitness/models/UserProfile.dart';
import 'package:dio/dio.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

class UpdateDetailsRepository {
  final ApiService _apiService = ApiService();

  Future<UpdateDetailsRequest> registerUser(UserProfile request) async {
    Response response = await _apiService.postRequest(
      "update-details-ai",
      request.toJson(),
    );

    var raw = response.data;

    Map<String, dynamic> jsonMap;

    if (raw is String) {
      jsonMap = jsonDecode(raw); // FIX
    } else {
      jsonMap = raw;
    }

    return UpdateDetailsRequest.fromJson(jsonMap);
  }
}
