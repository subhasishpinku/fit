import 'package:aifitness/data/shareperfarance/fat_loss_pref.dart';
import 'package:aifitness/models/FatLossModel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aifitness/repository/signin_thirteen_repository.dart';

class SigninThirteenViewModel extends ChangeNotifier {
  final _repo = SigninThirteenRepository();

  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic>? fatLossData;
  FatLossModel? fatLossModel;
  bool? correctTargetWeightFlag;
  Future<void> fetchFatLossDataFromPrefs() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      print("plan_type: ${prefs.getString("plan_type")}");
      print("fitness_goal: ${prefs.getString("fitness_goal")}");
      print(
        "how_fast_to_reach_goal: ${prefs.getString("how_fast_to_reach_goal")}",
      );
      print("activity_level: ${prefs.getString("activity_level")}");
      print("gender: ${prefs.getString("gender")}");
      print("dob_age_year: ${prefs.getString("dob_age_year")}");
      print("height_value: ${prefs.getString("height_value")}");
      print("weight_value: ${prefs.getString("weight_value")}");
      print("hip: ${prefs.getString("hip")}");
      print("waist: ${prefs.getString("waist")}");
      print("current_bfp: ${prefs.getString("current_bfp")}");

      // print("wo_time: ${prefs.getInt("wo_time")}");
      print("target_bfp: ${prefs.getString("target_bfp")}");

      String? value = prefs.getString("target_bfp");
      String target_bfp = value!.replaceAll('%', '');
      print(target_bfp); // Output: 9

      String? value1 = prefs.getString("current_bfp");
      String current_bfp = value1!.replaceAll('%', '');
      print(current_bfp);
      // Load values (or use default)
      final payload = {
        "plan_type": prefs.getString("plan_type") ?? "weight_fat_loss",
        "weight_value": prefs.getString("weight_value") ?? "60.0",
        "gender": prefs.getString("gender") ?? "M",
        "dob_age_year": prefs.getString("dob_age_year") ?? "1980",
        "height_value": prefs.getString("height_value") ?? "150",
        "wo_time": 45,
        "target_bfp": target_bfp,
        "current_bfp": current_bfp,
        "activity_level":
            prefs.getString("activity_level") ?? "Sedentary Exercise",
        "how_fast_to_reach_goal":
            prefs.getString("how_fast_to_reach_goal") ?? "Easy",
      };
      print("API payload: $payload");
      final data = await _repo.fetchFatLossData(payload);
      fatLossData = data;
      print("API Response: $fatLossData");

      // Save weight if exists
      final weightValue = fatLossData?["current_weight_value"];
      final woGoal = fatLossData?["wo_goal"];
      final howfasttoreachgoal = fatLossData?["how_fast_to_reach_goal"];
      correctTargetWeightFlag =
      fatLossData?["correct_target_weight_flag"];

      print("correcttargetweightflag: $correctTargetWeightFlag");

      print("weightValue: $weightValue");
      print("woGoal: $woGoal");

      if (weightValue != null) {
        prefs.setString("current_weight_value", weightValue.toString());
      }
      if (woGoal != null) {
        prefs.setString("wo_goal", woGoal.toString());
      }

      // fatLossModel = FatLossModel.fromJson(fatLossData!);
      // FatLossPref.saveFatLossData(fatLossModel!);
      // loadFatLossData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadFatLossData() async {
    FatLossModel? model = await FatLossPref.getFatLossData();

    if (model == null) {
      print("No saved data found");
      return;
    }

    print("Message: ${model.message}");
    print("Plan Type: ${model.data.planType}");
    print("Weight: ${model.data.weightValue}");
    print("Gender: ${model.data.gender}");
    print("Ideal Weight: ${model.data.idealWeight}");

    print("Day Name: ${model.data.dayDetails.dayName}");
    print("AI Calories: ${model.data.aiTargetCalories.targetCalories}");
  }
}
