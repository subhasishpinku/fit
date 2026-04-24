import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/models/DietResponse.dart';

class DietRepository {
  final ApiService _api = ApiService();

  Future<DietResponse> getDietPlan({
    required int week,
    required int userId,
    required String dayType,
    required String day,
  }) async {
    try {
      final response = await _api.postRequest("get-diet-day-wise-new-app-test?test=yes", {
        "week": week,
        "user_id": userId,
        "day_type": dayType,
        "day": day,
      });
      
      // Handle the response properly
      if (response.data is Map<String, dynamic>) {
        return DietResponse.fromJson(response.data);
      } else {
        return DietResponse(
          success: false,
          message: "Invalid response format",
          data: null,
        );
      }
    } catch (e) {
      print("Error in DietRepository: $e");
      return DietResponse(
        success: false,
        message: "Failed to fetch diet plan",
        data: null,
      );
    }
  }
}