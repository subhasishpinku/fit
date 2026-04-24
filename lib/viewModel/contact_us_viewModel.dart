import 'package:flutter/material.dart';
import '../repository/contact_repository.dart';

class ContactUsViewModel extends ChangeNotifier {
  final _repo = ContactRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<Map<String, dynamic>> sendContactDetails({
  //   required int userId,
  //   required String email,
  //   required String message,
  //   required String deviceId,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   Map<String, dynamic> request = {
  //     "user_id": userId,
  //     "message": message,
  //     "email": email,
  //     "enquiry_type": "contact",
  //     "device_id": deviceId,
  //   };

  //   try {
  //     var response = await _repo.sendContactForm(request);

  //     _isLoading = false;
  //     notifyListeners();
  //     return response; // MUST RETURN MAP
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     print("contracted $e");
  //     return {"success": false, "message": "Something went wrong"};
  //   }
  // }

  Future<Map<String, dynamic>> sendContactDetails({
    required int userId,
    required String email,
    required String message,
    required String deviceId,
    required String purpose, // ✅ NEW
  }) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> request = {
      "user_id": userId,
      "message": message,
      "email": email,
      "enquiry_type": purpose, // ✅ USE DROPDOWN VALUE
      "device_id": deviceId,
    };

    try {
      var response = await _repo.sendContactForm(request);

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("contact error $e");
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
