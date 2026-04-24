import 'package:aifitness/data/network/api_service.dart';

import '../models/walking_steps_model.dart';

class WalkingStepsRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> addWalkingSteps(WalkingStepsModel model) async {
    final response = await _apiService.postContractRequest(
      "walking-steps/add",
      model.toJson(),
    );

    return response;
  }
}
