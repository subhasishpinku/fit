import 'dart:convert';

import 'package:aifitness/models/UpdateDetailsRequest.dart';
import 'package:aifitness/models/UserProfile.dart';
import 'package:aifitness/repository/UpdateDetailsRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetBFPViewModel extends ChangeNotifier {
  int? _selectedIndex;

  final List<Map<String, String>> bodyFatList = [
    {'percent': '9%', 'image': 'assets/images/Desired/9.png'},
    {'percent': '11%', 'image': 'assets/images/Desired/11.png'},
    {'percent': '13%', 'image': 'assets/images/Desired/13.png'},
    {'percent': '15%', 'image': 'assets/images/Desired/15.png'},
    {'percent': '17%', 'image': 'assets/images/Desired/17.png'},
    {'percent': '19%', 'image': 'assets/images/Desired/19.png'},
    {'percent': '21%', 'image': 'assets/images/Desired/21.png'},
    {'percent': '23%', 'image': 'assets/images/Desired/23.png'},
    {'percent': '25%', 'image': 'assets/images/Desired/25.png'},
  ];

  int? get selectedIndex => _selectedIndex;
  final UpdateDetailsRepository repository = UpdateDetailsRepository();
  UpdateDetailsRequest? updateDetailsRequestResponse;
  String? errorMessage;
  Future<void> selectIndex(int index, BuildContext context) async {
    _selectedIndex = index;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final percentage = bodyFatList[index]['percent']!;

    await prefs.setString('target_bfp', percentage);
    debugPrint('Saved target_bfp: $percentage');

    final grainsList = decodeList(prefs.getString("grains"));
    final fruitsList = decodeList(prefs.getString("fruit"));
    final carbsList = decodeList(prefs.getString("carbs"));
    final vegetablesList = decodeList(prefs.getString("vegetables"));
    final nutsList = decodeList(prefs.getString("nut"));
    final proteinsList = decodeList(prefs.getString("proteins"));
    final fatsList = decodeList(prefs.getString("fat"));
    final fibersList = decodeList(prefs.getString("fibers"));
    final woDaysList = decodeList(prefs.getString("wo_days"));
    final focusMuscleList = decodeList(prefs.getString("focus_muscle"));

    int? noOfDays = prefs.getInt("no_of_days_per_week") ?? 0;
    String? noOfDaysPerWeek = noOfDays.toString();
    final rawJson = {
      "wo_time": "30",
      "wo_mode": prefs.getString("wo_mode") ?? "",
      "current_bfp": prefs.getString("current_bfp") ?? "",
      "activity_level": prefs.getString("activity_level") ?? "",
      "fitness_goal": prefs.getString("fitness_goal") ?? "",
      "user_id": prefs.getInt("user_id"),
      "device_id": prefs.getString("device_id"),

      "dob_age_month": "0",
      "height_unit": "CM",
      "current_weight_unit": "KG",

      "height_value": prefs.getString("height_value") ?? "",
      "target_bfp": (prefs.getString("target_bfp") ?? "").replaceAll("%", ""),
      "meal_type": prefs.getString("meal_type") ?? "",
      "dob_age_year": prefs.getString("dob_age_year") ?? "",
      "no_of_days_per_week": noOfDaysPerWeek,
      "gender": prefs.getString("gender") ?? "",
      "current_weight_value": prefs.getString("current_weight_value") ?? "",
    };

    final profile = UserProfile.fromJson(rawJson);
    print(profile);
    print(profile.toJson()); // Map
    print(profile.toJsonString());

    try {
      updateDetailsRequestResponse = await repository.registerUser(profile);
      errorMessage = null;
      print(
        "currentBfp = ${updateDetailsRequestResponse!.data!.userBodyMetrics!.currentBfp!}",
      );
      final prefs = await SharedPreferences.getInstance();
      int? userIds = updateDetailsRequestResponse!.data!.userDetails!.id;
      await prefs.setInt('user_id', userIds!);
      String? deviceIdS =
          updateDetailsRequestResponse!.data!.userDetails!.deviceId;
      String? name = updateDetailsRequestResponse!.data!.userDetails!.name;
      String? email = updateDetailsRequestResponse!.data!.userDetails!.email;
      String? imageFullUrl =
          updateDetailsRequestResponse!.data!.userDetails!.image;

      await prefs.setString('device_id', deviceIdS!);
      await prefs.setString('name', name!);

      await prefs.setString('email', email!);
      await prefs.setString('image_full_url', imageFullUrl!);
      print("ResponseAllIds ${userIds}  ${deviceIdS}");
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            updateDetailsRequestResponse?.message ?? "Registration successful",
          ),
        ),
      );
      // Navigator.pushNamed(context, RouteNames.signinScreenTwentyFive);

      // Navigate or do next step
    } catch (e) {
      errorMessage = e.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));
      print(errorMessage);
    }
  }

  List<String>? decodeList(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return List<String>.from(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }
}
