import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/models/member_model.dart';


class AddMemberRepository {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> createMember(
    AddMemberRequestModel model,
  ) async {

    final response = await apiService.postContractRequest(
      "register-machine-user",
      model.toJson(),
    );

    return response;
  }
}