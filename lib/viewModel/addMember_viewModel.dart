import 'package:aifitness/models/member_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/add_member_repository.dart';

class AddmemberViewmodel extends ChangeNotifier {
  final AddMemberRepository repository = AddMemberRepository();

  bool isLoading = false;

  String errorMessage = "";

  Future<void> createProfile({
    required String name,
    required String gender,
    required String birthYear,
    required String height,
    required String deviceId,
  }) async {
    try {
      errorMessage = "";

      isLoading = true;

      notifyListeners();

      final model = AddMemberRequestModel(
        name: name,

        gender: gender,

        birthYear: birthYear,

        heightValue: height.replaceAll(" cm", ""),

        heightUnit: "CM",

        profilePic: gender == "M" ? "male_avatar1" : "female_avatar1",

        deviceId: deviceId,
      );

      print("REQUEST MODEL =>");
      print(model.toJson());

      final response = await repository.createMember(model);

      print("SUCCESS RESPONSE =>");
      print(response);

      /// STORE USER ID
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("user_ids", response["data"]["id"].toString());

      print("USER ID STORED => ${response["data"]["id"]}");
    } catch (e) {
      errorMessage = e.toString();

      print("ERROR => $errorMessage");
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
