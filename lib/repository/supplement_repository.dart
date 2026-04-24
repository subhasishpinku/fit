import 'package:aifitness/data/network/api_service.dart';

import '../models/supplement_model.dart';

class SupplementRepository {
  final ApiService apiService;

  SupplementRepository(this.apiService);

  // Future<List<SupplementModel>> fetchSupplements() async {
  //   final response = await apiService.postContractRequest(
  //     "get-supplements-list?type=Non Veg&gender=All",
  //     {},
  //   );

  //   List data = response["data"];

  //   return data.map((e) => SupplementModel.fromJson(e)).toList();
  // }

  Future<List<SupplementModel>> fetchSupplements({
    required String type,
    required String gender,
    String? subCategory,
  }) async {
    final body = {
      "type": type,
      "gender": gender,
    };

    if (subCategory != null && subCategory.isNotEmpty) {
      body["sub_category"] = subCategory;
    }

    final response = await apiService.postContractRequest(
      "get-supplements-list",
      body,
    );

    List data = response["data"];
    return data.map((e) => SupplementModel.fromJson(e)).toList();
  }
}