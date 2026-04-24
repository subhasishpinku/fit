import 'dart:convert';

import 'package:aifitness/data/network/api_service.dart';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';

class DashboardRepository {
  final ApiService _api = ApiService();
  Future<DashboardModel> fetchDashboardData({
    required int userId,
    required String deviceId,
    required String deviceType,
  }) async {
    try {
      final response = await _api.postRequest(
        "dashboard-details-api-ai?test=1",
        {
          "user_id": userId.toString(),
          "device_id": deviceId,
          "device_type": deviceType,
        },
      );

      return DashboardModel.fromJson(response.data);
    } catch (e) {
      print("❌ API ERROR = $e");
      rethrow;
    }
  }
  // Future<DashboardModel> fetchDashboardData({
  //   required int userId,
  //   required String deviceId,
  //   required String deviceType,
  // }) async {
  //   try {
  //     final url = Uri.parse(
  //       "https://aipoweredfitness.com/api/dashboard-details-api-ai?test=1",
  //     );

  //     final response = await http.post(
  //       url,
  //       body: {
  //         "user_id": userId.toString(),
  //         "device_id": deviceId,
  //         "device_type": deviceType,
  //       },
  //     );

  //     print("STATUS CODE = ${response.statusCode}");
  //     print("RESPONSE BODY = ${response.body}");

  //     if (response.statusCode == 200 && response.body.isNotEmpty) {
  //       final jsonData = json.decode(response.body);

  //       if (jsonData == null) {
  //         throw Exception("Empty JSON");
  //       }

  //       return DashboardModel.fromJson(jsonData);
  //     } else {
  //       throw Exception("API error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("❌ API ERROR = $e");
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>> fetchWalkingSteps1(int userId) async {
  //   final response = await _api.postContractRequest("walking-steps", {
  //     "user_id": userId.toString(),
  //   });

  //   return response;
  // }

  // In DashboardRepository
  Future<Map<String, dynamic>> fetchWalkingSteps(int userId) async {
    try {
      final response = await _api.getContractRequest("walking-steps", {
        "user_id": userId.toString(),
      });
      return response;
    } catch (e) {
      print("Walking steps repository error: $e");
      rethrow;
    }
  }

  // Save walking steps using GET (since POST is not supported)
  Future<Map<String, dynamic>> saveWalkingSteps({
    required int userId,
    required int steps,
    required double calories,
  }) async {
    try {
      // Using GET request with query parameters since POST is not supported
      final response = await _api.postContractRequest(
        "walking-steps/add", // Same endpoint as fetch
        {
          'user_id': userId.toString(),
          'walking_step': steps.toString(),
          'calories_burn': calories.toString(),
        },
      );

      print('saveWalkingSteps response: $response');

      // Check if the response indicates success
      // Adjust this based on your API response structure
      if (response['success'] == true ||
          response['message']?.contains('success') == true) {
        return {
          'success': true,
          'message': response['message'] ?? 'Steps saved successfully',
          'data': response['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Failed to save steps',
        };
      }
    } catch (e) {
      print('Save walking steps error: $e');
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
