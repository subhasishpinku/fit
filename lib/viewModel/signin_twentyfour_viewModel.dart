import 'dart:convert';
import 'package:aifitness/models/register_request_model.dart';
import 'package:aifitness/repository/register_repository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninTwentyFourViewModel extends ChangeNotifier {
  final RegisterRepository repo = RegisterRepository();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool loading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /// Helper to decode String? JSON → List<String>?
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

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    /// READ RAW JSON STRINGS
    String? grainsRaw = prefs.getString("grains");
    String? fruitsRaw = prefs.getString("fruit");
    String? carbsRaw = prefs.getString("carbs");
    String? vegetablesRaw = prefs.getString("vegetables");
    String? nutsRaw = prefs.getString("nut");
    String? proteinsRaw = prefs.getString("proteins");
    String? fatsRaw = prefs.getString("fat");
    String? fibersRaw = prefs.getString("fibers");
    String? wodaysRaw = prefs.getString("wo_days");
    String? focusmuscleRaw = prefs.getString("focus_muscle");

    /// DECODE STRING → LIST<String>
    final grainsList = decodeList(grainsRaw);
    // String grainsListString = "["; // start array

    // if (grainsList != null) {
    //   for (int i = 0; i < grainsList.length; i++) {
    //     grainsListString += "\"${grainsList[i]}\""; // add "item"

    //     if (i != grainsList.length - 1) {
    //       grainsListString += ", "; // add comma
    //     }
    //   }
    // }

    // grainsListString += "]"; // end array

    // print("FINAL => $grainsListString");
    final fruitsList = decodeList(fruitsRaw);

    //  String fruitsListString = "["; // start array

    // if (fruitsList != null) {
    //   for (int i = 0; i < fruitsList.length; i++) {
    //     grainsListString += "\"${fruitsList[i]}\""; // add "item"

    //     if (i != fruitsList.length - 1) {
    //       fruitsListString += ", "; // add comma
    //     }
    //   }
    // }

    // fruitsListString += "]"; // end array

    // print("FINAL => $fruitsListString");
    final carbsList = decodeList(carbsRaw);
    final vegetablesList = decodeList(vegetablesRaw);
    final nutsList = decodeList(nutsRaw);
    final proteinsList = decodeList(proteinsRaw);
    final fatsList = decodeList(fatsRaw);
    final fibersList = decodeList(fibersRaw);
    final woDaysList = decodeList(wodaysRaw);
    final focusmuscleList = decodeList(focusmuscleRaw);

    // print("Decoded fruitsList = $grainsList");
    String grainsListString = buildJsonArray(grainsList);
    String fruitsListString = buildJsonArray(fruitsList);
    String carbsListString = buildJsonArray(carbsList);
    String vegetablesListString = buildJsonArray(vegetablesList);
    String nutsListString = buildJsonArray(nutsList);
    String proteinsListString = buildJsonArray(proteinsList);
    String fatsListString = buildJsonArray(fatsList);
    String fibersListString = buildJsonArray(fibersList);
    String woDaysListString = buildJsonArray(woDaysList);
    String focusmuscleString = buildJsonArray(focusmuscleList);

    // print("GRAINS => $grainsListString");
    // print("FRUITS => $fruitsListString");

    /// Build final request model
    RegisterRequestModel model = RegisterRequestModel(
      name: name,
      hip: prefs.getString("hip"),
      noOfDaysPerWeek: prefs.getInt("no_of_days_per_week"),
      woTime: "45",
      password: password,
      email: email,
      fitnessGoal: prefs.getString("fitness_goal"),
      currentBfp: prefs.getString("current_bfp"),

      /// LIST FIELDS
      grains: grainsListString,
      fruits: fruitsListString,
      carbs: carbsListString,
      vegetables: vegetablesListString,
      nuts: nutsListString,
      proteins: proteinsListString,
      fats: fatsListString,
      fibers: fibersListString,

      waist: prefs.getString("waist"),
      planType: prefs.getString("plan_type"),

      currentBodyShape: prefs.getString("current_body_shape") ?? "3",
      desiredBodyShape: "3",
      heightUnit: "CM",

      woModeSubOption: "",
      targetBfp: prefs.getString("target_bfp")?.replaceAll("%", ""),
      currentWeightValue: "",

      activityLevel: prefs.getString("activity_level"),
      hipUnit: "CM",
      waistUnit: "CM",

      focusMuscle: focusmuscleString,
      dobAgeMonth: "0",
      woGoal: prefs.getString("wo_goal"),
      deviceId: prefs.getString("device_id"),
      woMode: prefs.getString("wo_mode") ?? "",

      skeletalMuscle: "",
      subcutaneousFatPercentage: "",
      dobAgeYear: prefs.getString("dob_age_year"),
      heightValue: prefs.getString("height_value"),
      howFastToReachGoal: prefs.getString("how_fast_to_reach_goal"),

      visceralFat: "",
      woDays: woDaysListString,
      waterWeight: "",
      currentWeightUnit: "KG",
      lossGainTargetValue: "",
      gender: prefs.getString("gender"),
      mealTypeSubOption: "",
      mealType: prefs.getString("meal_type"),
    );
    // print(prefs.getString("hip"));
    String? value = model.toJson().toString();

    print("FINAL DATA:");

    print(value);

    /// ---- API CALL ----
    try {
      final response = await repo.registerUser(model);

      loading = false;
      notifyListeners();
          print("FINAL DATA: ${response.data}");

      if (response.data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data["message"] ?? "Registration Successful",
            ),
          ),
        );

        Navigator.pushNamed(context, RouteNames.signinScreenTwentyFive);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data["message"] ?? "Registration Failed"),
          ),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("errorsData => $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  String buildJsonArray(List<String>? list) {
    if (list == null) return "[]";

    String result = "[";

    for (int i = 0; i < list.length; i++) {
      result += "\"${list[i]}\"";
      if (i != list.length - 1) result += ", ";
    }

    result += "]";
    return result;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
