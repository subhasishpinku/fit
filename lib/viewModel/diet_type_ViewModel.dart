import 'dart:convert';

import 'package:aifitness/models/UpdateDetailsRequest.dart';
import 'package:aifitness/models/UserProfile.dart';
import 'package:aifitness/repository/UpdateDetailsRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aifitness/utils/routes/routes_names.dart';

class DietTypeViewModel extends ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  final List<String> options = [
    "Omnivore (Eats plants and animals)",
    "Vegetarian (Includes egg and dairy)",
    "Vegan (No animal products)",
  ];

  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;
  final UpdateDetailsRepository repository = UpdateDetailsRepository();
  UpdateDetailsRequest? updateDetailsRequestResponse;
  String? errorMessage;
  DietTypeViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate button appearance one by one
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < options.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle selection and save to SharedPreferences
  Future<void> selectOption(BuildContext context, int index) async {
    _selectedIndex = index;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    String selectedValue = "";
    if (index == 0) {
      selectedValue = "Non Veg";
    } else if (index == 1) {
      selectedValue = "Veg";
    } else if (index == 2) {
      selectedValue = "Vegan";
    }

    await prefs.setString('meal_type', selectedValue);

    final savedValue = prefs.getString('meal_type');
    print('meal_type: $savedValue');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: ${options[index]}")));

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
        "UPDATE_PROFILE = ${updateDetailsRequestResponse!.data!.userBodyMetrics!.heightValue!}",
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

  /// Navigate to next screen
  void onNextPressed(BuildContext context) {
    if (_selectedIndex != -1) {
      Navigator.pushNamed(context, RouteNames.targetChangeDetails);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Please select an option first")),
      // );
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
