import 'dart:convert';
import 'package:aifitness/models/FatLossModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FatLossPref {
  static Future<void> saveFatLossData(FatLossModel model) async {
    final prefs = await SharedPreferences.getInstance();

    /// -------------------------------
    /// Save main FatLossModel fields
    /// -------------------------------
    await prefs.setBool("success", model.success);
    await prefs.setString("message", model.message);

    final data = model.data;

    /// -------------------------------
    /// Save all FatLossData fields
    /// -------------------------------
    await prefs.setString("plan_type", data.planType);
    await prefs.setString("weight_value", data.weightValue);
    await prefs.setString("gender", data.gender);
    await prefs.setString("dob_age_year", data.dobAgeYear);
    await prefs.setString("height_value", data.heightValue);
    await prefs.setString("wo_time", data.woTime);
    await prefs.setString("target_bfp", data.targetBfp);
    await prefs.setString("current_bfp", data.currentBfp);
    await prefs.setString("activity_level", data.activityLevel);
    await prefs.setString("how_fast_to_reach_goal", data.howFastToReachGoal);
    await prefs.setString("height_unit", data.heightUnit);
    await prefs.setString("weight_unit", data.weightUnit);
    await prefs.setString("current_weight_unit", data.currentWeightUnit);
    await prefs.setString("current_weight_value", data.currentWeightValue);
    await prefs.setString("plan_starts_at", data.planStartsAt);
    await prefs.setString("wo_goal", data.woGoal);
    await prefs.setString("loss_gain_target_value", data.lossGainTargetValue);
    await prefs.setString("loss_gain_target_unit", data.lossGainTargetUnit);
    await prefs.setString("current_week", data.currentWeek);
    await prefs.setString("initial_bmi", data.initialBmi);
    await prefs.setString("initial_bmi_cat", data.initialBmiCat);
    await prefs.setString("current_bmi", data.currentBmi);
    await prefs.setString("current_bmi_cat", data.currentBmiCat);
    await prefs.setString("target_bmi", data.targetBmi);
    await prefs.setString("target_bmi_cat", data.targetBmiCat);
    await prefs.setString("initial_bfp", data.initialBfp);
    await prefs.setString("initial_bfp_cat", data.initialBfpCat);
    await prefs.setString("current_bfp_cat", data.currentBfpCat);
    await prefs.setString("target_bfp_cat", data.targetBfpCat);
    await prefs.setString("initial_bmr", data.initialBmr);
    await prefs.setString("current_bmr", data.currentBmr);
    await prefs.setString("age", data.age);
    await prefs.setString("current_calories_intake", data.currentCaloriesIntake);
    await prefs.setString("target_bmr", data.targetBmr);
    await prefs.setString("idealbfp_fitness", data.idealbfpFitness);

    await prefs.setString("target_weight_dynamic", data.targetWeightDynamic);
    await prefs.setString("totalWeeks", data.totalWeeks);
    await prefs.setString("target_maintenance_estimate", data.targetMaintenanceEstimate);
    await prefs.setString("target_weight", data.targetWeight);
    await prefs.setString("targetWeightDynamic2", data.targetWeightDynamic2);
    await prefs.setString("totalLoss", data.totalLoss);
    await prefs.setString("weeks_to_target_dynamic", data.weeksToTargetDynamic);
    await prefs.setString("target_calories_for_weight_loss",
        data.targetCaloriesForWeightLoss);
    await prefs.setString("current_phase", data.currentPhase);
    await prefs.setString("duration_weeks_phase1", data.durationWeeksPhase1);
    await prefs.setString("duration_weeks_phase2", data.durationWeeksPhase2);
    await prefs.setString("target_weight_phase1", data.targetWeightPhase1);
    await prefs.setString("target_weight_phase2", data.targetWeightPhase2);
    await prefs.setBool("muscle_gain_or_not", data.muscleGainOrNot);

    await prefs.setDouble("ideal_weight", data.idealWeight);

    /// -------------------------------
    /// Save DayDetails (nested object)
    /// -------------------------------
    final day = data.dayDetails;

    await prefs.setString("day", day.day);
    await prefs.setInt("day_id", day.dayId);
    await prefs.setInt("meal_plan_day_id", day.mealPlanDayId);
    await prefs.setInt("workout_day_number", day.workoutDayNumber);
    await prefs.setString("day_name", day.dayName);
    await prefs.setString("previous_day_workout_status", day.previousDayWorkoutStatus);
    await prefs.setString(
        "previous_day_workout_status_es", day.previousDayWorkoutStatusEs);
    await prefs.setString("target_weight_formatted", day.targetWeightFormatted);
    await prefs.setString("target_weight_day", day.targetWeight);
    await prefs.setString("target_weight_unit_day", day.targetWeightUnit);
    await prefs.setString("current_height_formatted", day.currentHeightFormatted);
    await prefs.setString("current_height", day.currentHeight);
    await prefs.setString("current_height_unit", day.currentHeightUnit);
    await prefs.setStringList("week_range", day.weekRange);
    await prefs.setString("week_number", day.weekNumber);
    await prefs.setInt("week", day.week);
    await prefs.setString("week_formatted", day.weekFormatted);

    /// -------------------------------
    /// Save AiTargetCalories
    /// -------------------------------
    final ai = data.aiTargetCalories;

    await prefs.setString("ai_target_calories", ai.targetCalories);
    await prefs.setString("ai_protein", ai.protein);
    await prefs.setString("ai_fat", ai.fat);
    await prefs.setString("ai_carbs", ai.carbs);
    await prefs.setString("ai_protein_gram", ai.proteinGram);
    await prefs.setString("ai_fat_gram", ai.fatGram);
    await prefs.setString("ai_carbs_gram", ai.carbsGram);

    /// Save Map mealwise as JSON string
    await prefs.setString("mealwise", jsonEncode(ai.mealwise));

    /// -------------------------------
    /// Save List<PhaseSummary>
    /// -------------------------------
    await prefs.setString(
      "phase_summary_dynamic",
      jsonEncode(data.phaseSummaryDynamic.map((e) => e.toJson()).toList()),
    );
  }

  /// --------------------------------------------------------
  /// ❗ LOAD FULL MODEL BACK (RECONSTRUCT FULL MODEL CLASS)
  /// --------------------------------------------------------
  static Future<FatLossModel?> getFatLossData() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("plan_type")) return null;

    /// Re-create nested DayDetails
    DayDetails day = DayDetails(
      day: prefs.getString("day") ?? "",
      dayId: prefs.getInt("day_id") ?? 0,
      mealPlanDayId: prefs.getInt("meal_plan_day_id") ?? 0,
      workoutDayNumber: prefs.getInt("workout_day_number") ?? 0,
      dayName: prefs.getString("day_name") ?? "",
      previousDayWorkoutStatus:
          prefs.getString("previous_day_workout_status") ?? "",
      previousDayWorkoutStatusEs:
          prefs.getString("previous_day_workout_status_es") ?? "",
      targetWeightFormatted: prefs.getString("target_weight_formatted") ?? "",
      targetWeight: prefs.getString("target_weight_day") ?? "",
      targetWeightUnit: prefs.getString("target_weight_unit_day") ?? "",
      currentHeightFormatted:
          prefs.getString("current_height_formatted") ?? "",
      currentHeight: prefs.getString("current_height") ?? "",
      currentHeightUnit: prefs.getString("current_height_unit") ?? "",
      weekRange: prefs.getStringList("week_range") ?? [],
      weekNumber: prefs.getString("week_number") ?? "",
      week: prefs.getInt("week") ?? 1,
      weekFormatted: prefs.getString("week_formatted") ?? "",
    );

    /// Re-create AiTargetCalories
    AiTargetCalories ai = AiTargetCalories(
      targetCalories: prefs.getString("ai_target_calories") ?? "",
      protein: prefs.getString("ai_protein") ?? "",
      fat: prefs.getString("ai_fat") ?? "",
      carbs: prefs.getString("ai_carbs") ?? "",
      proteinGram: prefs.getString("ai_protein_gram") ?? "",
      fatGram: prefs.getString("ai_fat_gram") ?? "",
      carbsGram: prefs.getString("ai_carbs_gram") ?? "",
      mealwise: jsonDecode(prefs.getString("mealwise") ?? "{}"),
    );

    /// Re-create PhaseSummary list
    List<dynamic> summaryList =
        jsonDecode(prefs.getString("phase_summary_dynamic") ?? "[]");

    List<PhaseSummary> phaseSummary = summaryList
        .map((e) => PhaseSummary.fromJson(e))
        .toList();

    /// Re-create FatLossData
    FatLossData data = FatLossData(
      planType: prefs.getString("plan_type") ?? "",
      weightValue: prefs.getString("weight_value") ?? "",
      gender: prefs.getString("gender") ?? "",
      dobAgeYear: prefs.getString("dob_age_year") ?? "",
      heightValue: prefs.getString("height_value") ?? "",
      woTime: prefs.getString("wo_time") ?? "",
      targetBfp: prefs.getString("target_bfp") ?? "",
      currentBfp: prefs.getString("current_bfp") ?? "",
      activityLevel: prefs.getString("activity_level") ?? "",
      howFastToReachGoal:
          prefs.getString("how_fast_to_reach_goal") ?? "",
      heightUnit: prefs.getString("height_unit") ?? "",
      weightUnit: prefs.getString("weight_unit") ?? "",
      currentWeightUnit:
          prefs.getString("current_weight_unit") ?? "",
      currentWeightValue:
          prefs.getString("current_weight_value") ?? "",
      planStartsAt: prefs.getString("plan_starts_at") ?? "",
      woGoal: prefs.getString("wo_goal") ?? "",
      lossGainTargetValue:
          prefs.getString("loss_gain_target_value") ?? "",
      lossGainTargetUnit:
          prefs.getString("loss_gain_target_unit") ?? "",
      currentWeek: prefs.getString("current_week") ?? "",
      initialBmi: prefs.getString("initial_bmi") ?? "",
      initialBmiCat: prefs.getString("initial_bmi_cat") ?? "",
      currentBmi: prefs.getString("current_bmi") ?? "",
      currentBmiCat: prefs.getString("current_bmi_cat") ?? "",
      targetBmi: prefs.getString("target_bmi") ?? "",
      targetBmiCat: prefs.getString("target_bmi_cat") ?? "",
      initialBfp: prefs.getString("initial_bfp") ?? "",
      initialBfpCat: prefs.getString("initial_bfp_cat") ?? "",
      currentBfpCat: prefs.getString("current_bfp_cat") ?? "",
      targetBfpCat: prefs.getString("target_bfp_cat") ?? "",
      initialBmr: prefs.getString("initial_bmr") ?? "",
      currentBmr: prefs.getString("current_bmr") ?? "",
      age: prefs.getString("age") ?? "",
      currentCaloriesIntake:
          prefs.getString("current_calories_intake") ?? "",
      targetBmr: prefs.getString("target_bmr") ?? "",
      idealbfpFitness: prefs.getString("idealbfp_fitness") ?? "",
      dayDetails: day,
      aiTargetCalories: ai,
      targetWeightDynamic:
          prefs.getString("target_weight_dynamic") ?? "",
      totalWeeks: prefs.getString("totalWeeks") ?? "",
      targetMaintenanceEstimate:
          prefs.getString("target_maintenance_estimate") ?? "",
      targetWeight: prefs.getString("target_weight") ?? "",
      targetWeightDynamic2:
          prefs.getString("targetWeightDynamic2") ?? "",
      totalLoss: prefs.getString("totalLoss") ?? "",
      weeksToTargetDynamic:
          prefs.getString("weeks_to_target_dynamic") ?? "",
      targetCaloriesForWeightLoss:
          prefs.getString("target_calories_for_weight_loss") ?? "",
      currentPhase: prefs.getString("current_phase") ?? "",
      durationWeeksPhase1:
          prefs.getString("duration_weeks_phase1") ?? "",
      durationWeeksPhase2:
          prefs.getString("duration_weeks_phase2") ?? "",
      targetWeightPhase1:
          prefs.getString("target_weight_phase1") ?? "",
      targetWeightPhase2:
          prefs.getString("target_weight_phase2") ?? "",
      phaseSummaryDynamic: phaseSummary,
      muscleGainOrNot:
          prefs.getBool("muscle_gain_or_not") ?? false,
      idealWeight: prefs.getDouble("ideal_weight") ?? 0.0,
    );

    return FatLossModel(
      success: prefs.getBool("success") ?? false,
      message: prefs.getString("message") ?? "",
      data: data,
    );
  }

  /// CLEAR ALL
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
