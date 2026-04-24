import 'package:aifitness/data/network/api_service.dart';

class ContactRepository {
  final _apiService = ApiService();

  Future<dynamic> sendContactForm(Map<String, dynamic> data) async {
    const url = "send-contact-email";
    return await _apiService.postContractRequest(url, data);
  }
}
