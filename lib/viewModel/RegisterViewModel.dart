import 'dart:convert';
import 'package:aifitness/models/register_request.dart';
import 'package:aifitness/models/register_response.dart';
import 'package:aifitness/repository/RegisterRepository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository1 repository;

  RegisterViewModel(this.repository);

  bool loading = false;
  RegisterResponse? registerResponse;
  String? errorMessage;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  List<String>? decodeList(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return List<String>.from(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  Future<void> onNextPressed(BuildContext context) async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(".Please enter your full name")),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(".Please enter your email")));
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(".Please enter your password")),
      );
      return;
    }

    // OPTIONAL: Email format validation
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(".Please enter a valid email address")),
      );
      return;
    }

    // OPTIONAL: Password requirement validation
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 6 characters."),
        ),
      );
      return;
    }

    loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

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

    final breakfastFoods = decodeList(
      prefs.getString("breakfast_food_items_past"),
    );
    final lunchFoods = decodeList(prefs.getString("lunch_food_items_past"));
    final snackFoods = decodeList(prefs.getString("snack_food_items_past"));
    final dinnerFoods = decodeList(prefs.getString("dinner_food_items_past"));
    final supplements = decodeList(prefs.getString("supplements"));

    await prefs.setString('password', password);

    // RegisterRequest model = RegisterRequest(
    //   name: name,
    //   hip: prefs.getString("hip") ?? "",
    //   noOfDaysPerWeek: prefs.getInt("no_of_days_per_week") ?? 0,
    //   woTime: "45",
    //   password: password,
    //   email: email,
    //   fitnessGoal: prefs.getString("fitness_goal") ?? "",
    //   currentBfp: prefs.getString("current_bfp") ?? "",

    //   grains: grainsList ?? [],
    //   fruits: fruitsList ?? [],
    //   carbs: carbsList ?? [],
    //   vegetables: vegetablesList ?? [],
    //   nuts: nutsList ?? [],
    //   proteins: proteinsList ?? [],
    //   fats: fatsList ?? [],
    //   fibers: [],
    //   focusMuscle: [],
    //   woDays: [],

    //   waist: prefs.getString("waist") ?? "",
    //   planType: prefs.getString("plan_type") ?? "",

    //   currentBodyShape: prefs.getString("current_body_shape") ?? "3",
    //   heightUnit: "CM",
    //   desiredBodyShape: "3",
    //   woModeSubOption: "",
    //   targetBfp: (prefs.getString("target_bfp") ?? "").replaceAll("%", ""),
    //   currentWeightValue: prefs.getString("current_weight_value") ?? "",

    //   activityLevel: prefs.getString("activity_level") ?? "",
    //   hipUnit: "CM",
    //   waistUnit: "CM",

    //   dobAgeMonth: "0",
    //   woGoal: prefs.getString("wo_goal") ?? "",
    //   deviceId: prefs.getString("device_id") ?? "",
    //   woMode: prefs.getString("wo_mode") ?? "",

    //   skeletalMuscle: "",
    //   subcutaneousFatPercentage: "",
    //   dobAgeYear: prefs.getString("dob_age_year") ?? "",
    //   heightValue: prefs.getString("height_value") ?? "",
    //   howFastToReachGoal: prefs.getString("how_fast_to_reach_goal") ?? "",

    //   visceralFat: "",
    //   waterWeight: "",
    //   currentWeightUnit: "KG",
    //   lossGainTargetValue: "",
    //   gender: prefs.getString("gender") ?? "",
    //   mealTypeSubOption: "",
    //   mealType: prefs.getString("meal_type") ?? "",
    // );
    // RegisterRequest model = RegisterRequest(
    //   name: name,
    //   email: email,
    //   password: password,
    //   gender: prefs.getString("gender") ?? "",
    //   dobAgeYear: prefs.getString("dob_age_year") ?? "",
    //   dobAgeMonth: "0",
    //   heightValue: prefs.getString("height_value") ?? "",
    //   heightUnit: "CM",
    //   currentWeightValue: prefs.getString("current_weight_value") ?? "",
    //   currentWeightUnit: "KG",
    //   waist: prefs.getString("waist") ?? "",
    //   waistUnit: "CM",
    //   hip: prefs.getString("hip") ?? "",
    //   hipUnit: "CM",
    //   currentBfp: prefs.getString("current_bfp") ?? "",
    //   targetBfp: (prefs.getString("target_bfp") ?? "").replaceAll("%", ""),
    //   currentBodyShape: prefs.getString("current_body_shape") ?? "3",
    //   desiredBodyShape: "3",
    //   skeletalMuscle: "",
    //   subcutaneousFatPercentage: "",
    //   visceralFat: "",
    //   waterWeight: "",
    //   planType: prefs.getString("plan_type") ?? "",
    //   fitnessGoal: prefs.getString("fitness_goal") ?? "",
    //   woGoal: prefs.getString("wo_goal") ?? "",
    //   activityLevel: prefs.getString("activity_level") ?? "",
    //   howFastToReachGoal: "Easy",
    //   lossGainTargetValue: "0",
    //   woMode: prefs.getString("wo_mode") ?? "",
    //   woModeSubOption: "",
    //   woTime: "30",
    //   noOfDaysPerWeek: prefs.getInt("no_of_days_per_week") ?? 0,
    //   woDays: [],
    //   focusMuscle: [],
    //   mealType: prefs.getString("meal_type") ?? "",
    //   mealTypeSubOption: "",
    //   grains: grainsList ?? [],
    //   fruits: fruitsList ?? [],
    //   vegetables: vegetablesList ?? [],
    //   proteins: proteinsList ?? [],
    //   carbs: carbsList ?? [],
    //   fats: fatsList ?? [],
    //   nuts: nutsList ?? [],
    //   fibers: [],
    //   deviceId: prefs.getString("device_id") ?? "",
    // );

    RegisterRequest model = RegisterRequest(
      name: name,
      email: email,
      password: password,
      gender: prefs.getString("gender") ?? "",
      dobAgeYear: prefs.getString("dob_age_year") ?? "",
      dobAgeMonth: "0",
      heightValue: prefs.getString("height_value") ?? "",
      heightUnit: "CM",
      currentWeightValue: prefs.getString("current_weight_value") ?? "",
      currentWeightUnit: "KG",
      waist: prefs.getString("waist") ?? "",
      waistUnit: "CM",
      hip: prefs.getString("hip") ?? "",
      hipUnit: "CM",
      currentBfp: prefs.getString("current_bfp") ?? "",
      targetBfp: (prefs.getString("target_bfp") ?? "").replaceAll("%", ""),
      currentBodyShape: prefs.getString("current_body_shape") ?? "3",
      desiredBodyShape: "3",
      skeletalMuscle: "",
      subcutaneousFatPercentage: "",
      visceralFat: "",
      waterWeight: "",
      planType: prefs.getString("plan_type") ?? "",

      // fitnessGoal: "Strength",
      // woGoal: "Lose Weight",
      // activityLevel: "Sedentary Exercise",
      fitnessGoal: prefs.getString("fitness_goal") ?? "",
      woGoal: prefs.getString("wo_goal") ?? "",
      activityLevel: prefs.getString("activity_level") ?? "",

      howFastToReachGoal: "Easy",
      lossGainTargetValue: "0",
      woMode: prefs.getString("wo_mode") ?? "",
      woModeSubOption: "",
      woTime: "30",
      noOfDaysPerWeek: prefs.getInt("no_of_days_per_week") ?? 0,

      woDays: [],
      focusMuscle: [],
      mealType: prefs.getString("meal_type") ?? "",
      mealTypeSubOption: "",
      grains: grainsList ?? [],
      fruits: fruitsList ?? [],
      vegetables: vegetablesList ?? [],
      proteins: proteinsList ?? [],
      carbs: carbsList ?? [],
      fats: fatsList ?? [],
      nuts: nutsList ?? [],
      fibers: [],
      deviceId: prefs.getString("device_id") ?? "",
      breakfastFoods: breakfastFoods ?? [],
      lunchFoods: lunchFoods ?? [],
      snackFoods: snackFoods ?? [],
      dinnerFoods: dinnerFoods ?? [],
      supplements: supplements ?? [],
    );

    print("""
===== FINAL REQUEST JSON =====

name: $name
email: $email
password: $password

gender: ${prefs.getString("gender") ?? ""}
dobAgeYear: ${prefs.getString("dob_age_year") ?? ""}
dobAgeMonth: 0

heightValue: ${prefs.getString("height_value") ?? ""}
heightUnit: CM

currentWeightValue: ${prefs.getString("current_weight_value") ?? ""}
currentWeightUnit: KG

waist: ${prefs.getString("waist") ?? ""}
waistUnit: CM

hip: ${prefs.getString("hip") ?? ""}
hipUnit: CM

currentBfp: ${prefs.getString("current_bfp") ?? ""}
targetBfp: ${(prefs.getString("target_bfp") ?? "").replaceAll("%", "")}

currentBodyShape: ${prefs.getString("current_body_shape") ?? "3"}
desiredBodyShape: 3

planType: ${prefs.getString("plan_type") ?? ""}
fitnessGoal: ${prefs.getString("fitness_goal") ?? ""}
woGoal: ${prefs.getString("wo_goal") ?? ""}
activityLevel: ${prefs.getString("activity_level") ?? ""}

howFastToReachGoal: Easy
lossGainTargetValue: 0

woMode: ${prefs.getString("wo_mode") ?? ""}
woModeSubOption: ""

woTime: 30
noOfDaysPerWeek: ${prefs.getInt("no_of_days_per_week") ?? 0}

woDays: []
focusMuscle: []

mealType: ${prefs.getString("meal_type") ?? ""}
mealTypeSubOption: ""

grains: ${grainsList ?? []}
fruits: ${fruitsList ?? []}
vegetables: ${vegetablesList ?? []}
proteins: ${proteinsList ?? []}
carbs: ${carbsList ?? []}
fats: ${fatsList ?? []}
nuts: ${nutsList ?? []}
fibers: []

breakfastFoods: ${breakfastFoods ?? []}
lunchFoods: ${lunchFoods ?? []}
snackFoods: ${snackFoods ?? []}
dinnerFoods: ${dinnerFoods ?? []}
supplements: ${supplements ?? []}

deviceId: ${prefs.getString("device_id") ?? ""}

================================
""");

    // try {
    //   registerResponse = await repository.registerUser(model);
    //   errorMessage = null;
    //   print("FINAL REQUEST JSON = ${registerResponse!.data!.userDetails!.id}");
    //   final prefs = await SharedPreferences.getInstance();
    //   int? userIds = registerResponse!.data!.userDetails!.id;
    //   await prefs.setInt('user_id', userIds!);
    //   String? deviceIdS = registerResponse!.data!.userDetails!.deviceId;
    //   String? name = registerResponse!.data!.userDetails!.name;
    //   String? email = registerResponse!.data!.userDetails!.email;
    //   String? imageFullUrl = registerResponse!.data!.userDetails!.image;

    //   await prefs.setString('device_id', deviceIdS!);
    //   await prefs.setString('name', name!);

    //   await prefs.setString('email', email!);

    //   await prefs.setString('image_full_url', imageFullUrl!);
    //   print("ResponseAllIds ${userIds}  ${deviceIdS}");
    //   // Show success snackbar
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(registerResponse?.message ?? "Registration successful"),
    //     ),
    //   );
    //   Navigator.pushNamed(context, RouteNames.signinScreenTwentyFive);

    //   // Navigate or do next step
    // } catch (e) {
    //   errorMessage = e.toString();
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));
    //   print(errorMessage);
    // }
    try {
      registerResponse = await repository.registerUser(model);

      /// 🔴 FAILURE CASE (email already exists etc.)
      if (registerResponse?.success != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(registerResponse?.message ?? "Registration failed"),
          ),
        );
        loading = false;
        notifyListeners();
        return;
      }

      /// 🟢 SUCCESS CASE
      final user = registerResponse?.data?.userDetails;
      if (user == null) {
        throw Exception("Invalid server response");
      }

      await prefs.setInt('user_id', user.id ?? 0);
      await prefs.setString('device_id', user.deviceId ?? '');
      await prefs.setString('name', user.name ?? '');
      await prefs.setString('email', user.email ?? '');
      await prefs.setString('image_full_url', user.image ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(registerResponse!.message ?? "Success")),
      );

      Navigator.pushNamed(context, RouteNames.signinScreenTwentyFive);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }

    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
