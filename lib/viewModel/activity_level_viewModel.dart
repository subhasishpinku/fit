import 'dart:convert';

import 'package:aifitness/models/UpdateDetailsRequest.dart';
import 'package:aifitness/models/UserProfile.dart';
import 'package:aifitness/repository/UpdateDetailsRepository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityLevelViewModel extends ChangeNotifier {
  final List<String> _topics = [
    "Sedentary: Little to no \n physical activity.",
    "Lightly Active: Light exercise or \n physical activity 1–3 days a week.",
    "Moderately Active: Engaging in \n moderate exercise or physical \n activity 3–5 days a week.",
    "Very Active: Hard exercise or \n physical activity 6–7 days a week.",
    "Super Active: Very intense exercise \n or physical activity, often multiple \n times per day, or for those with \n physically demanding jobs or \n training programs.",
  ];

  List<String> get topics => _topics;

  final List<bool> _isVisible = List.filled(5, false);
  List<bool> get isVisible => _isVisible;

  String? _selectedTopic;
  String? get selectedTopic => _selectedTopic;
  final UpdateDetailsRepository repository = UpdateDetailsRepository();
  UpdateDetailsRequest? updateDetailsRequestResponse;
  String? errorMessage;

  ActivityLevelViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate button appearance one by one
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < _topics.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle topic selection & store in SharedPreferences
  Future<void> onTopicSelected(BuildContext context, String topic) async {
    _selectedTopic = topic;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String activityLevel = '';

    if (topic == "Sedentary: Little to no \n physical activity.") {
      activityLevel = 'Sedentary Exercise';
    } else if (topic ==
        "Lightly Active: Light exercise or \n physical activity 1–3 days a week.") {
      activityLevel = 'Light Exercise';
    } else if (topic ==
        "Moderately Active: Engaging in \n moderate exercise or physical \n activity 3–5 days a week.") {
      activityLevel = 'Moderate Exercise';
    } else if (topic ==
        "Very Active: Hard exercise or \n physical activity 6–7 days a week.") {
      activityLevel = 'Intense Exercise';
    } else if (topic ==
        "Super Active: Very intense exercise \n or physical activity, often multiple \n times per day, or for those with \n physically demanding jobs or \n training programs.") {
      activityLevel = 'Super Intense Exercise';
    }

    // Use consistent lowercase key naming
    await prefs.setString('activity_level', activityLevel);

    // Optional: ensure it's written immediately
    await prefs.reload();

    final savedActivity = prefs.getString('activity_level');
    debugPrint(' Saved activity_level: $savedActivity');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: $topic")));

    //  Navigate only after successful save
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
    Navigator.pushNamed(context, RouteNames.targetChangeDetails);
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
