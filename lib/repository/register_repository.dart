import 'dart:convert';

import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/models/register_request_model.dart';
import 'package:dio/dio.dart';

class RegisterRepository {
  final ApiService _apiService = ApiService();

  Future<Response> registerUser(RegisterRequestModel model) async {
    // print("getalldata => ${model.toJson().toString()}");

    return await _apiService.postRequest("register", model.toJson());
  }
}
