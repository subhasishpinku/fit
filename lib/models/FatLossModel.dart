import 'dart:convert';

class FatLossModel {
  final bool success;
  final String message;
  final FatLossData data;

  FatLossModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FatLossModel.fromJson(Map<String, dynamic> json) {
    return FatLossModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: FatLossData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data.toJson()};
  }
}

class FatLossData {
  final String planType;
  final String weightValue;
  final String gender;
  final String dobAgeYear;
  final String heightValue;
  final String woTime;
  final String targetBfp;
  final String currentBfp;
  final String activityLevel;
  final String howFastToReachGoal;
  final String heightUnit;
  final String weightUnit;
  final String currentWeightUnit;
  final String currentWeightValue;
  final String planStartsAt;
  final String woGoal;
  final String lossGainTargetValue;
  final String lossGainTargetUnit;
  final String currentWeek;
  final String initialBmi;
  final String initialBmiCat;
  final String currentBmi;
  final String currentBmiCat;
  final String targetBmi;
  final String targetBmiCat;
  final String initialBfp;
  final String initialBfpCat;
  final String currentBfpCat;
  final String targetBfpCat;
  final String initialBmr;
  final String currentBmr;
  final String age;
  final String currentCaloriesIntake;
  final String targetBmr;
  final String idealbfpFitness;
  final DayDetails dayDetails;
  final AiTargetCalories aiTargetCalories;
  final String targetWeightDynamic;
  final String totalWeeks;
  final String targetMaintenanceEstimate;
  final String targetWeight;
  final String targetWeightDynamic2;
  final String totalLoss;
  final String weeksToTargetDynamic;
  final String targetCaloriesForWeightLoss;
  final String currentPhase;
  final String durationWeeksPhase1;
  final String durationWeeksPhase2;
  final String targetWeightPhase1;
  final String targetWeightPhase2;
  final List<PhaseSummary> phaseSummaryDynamic;
  final bool muscleGainOrNot;
  final double idealWeight;

  FatLossData({
    required this.planType,
    required this.weightValue,
    required this.gender,
    required this.dobAgeYear,
    required this.heightValue,
    required this.woTime,
    required this.targetBfp,
    required this.currentBfp,
    required this.activityLevel,
    required this.howFastToReachGoal,
    required this.heightUnit,
    required this.weightUnit,
    required this.currentWeightUnit,
    required this.currentWeightValue,
    required this.planStartsAt,
    required this.woGoal,
    required this.lossGainTargetValue,
    required this.lossGainTargetUnit,
    required this.currentWeek,
    required this.initialBmi,
    required this.initialBmiCat,
    required this.currentBmi,
    required this.currentBmiCat,
    required this.targetBmi,
    required this.targetBmiCat,
    required this.initialBfp,
    required this.initialBfpCat,
    required this.currentBfpCat,
    required this.targetBfpCat,
    required this.initialBmr,
    required this.currentBmr,
    required this.age,
    required this.currentCaloriesIntake,
    required this.targetBmr,
    required this.idealbfpFitness,
    required this.dayDetails,
    required this.aiTargetCalories,
    required this.targetWeightDynamic,
    required this.totalWeeks,
    required this.targetMaintenanceEstimate,
    required this.targetWeight,
    required this.targetWeightDynamic2,
    required this.totalLoss,
    required this.weeksToTargetDynamic,
    required this.targetCaloriesForWeightLoss,
    required this.currentPhase,
    required this.durationWeeksPhase1,
    required this.durationWeeksPhase2,
    required this.targetWeightPhase1,
    required this.targetWeightPhase2,
    required this.phaseSummaryDynamic,
    required this.muscleGainOrNot,
    required this.idealWeight,
  });

  factory FatLossData.fromJson(Map<String, dynamic> json) {
    return FatLossData(
      planType: json["plan_type"] ?? "",
      weightValue: json["weight_value"] ?? "",
      gender: json["gender"] ?? "",
      dobAgeYear: json["dob_age_year"] ?? "",
      heightValue: json["height_value"] ?? "",
      woTime: json["wo_time"] ?? "",
      targetBfp: json["target_bfp"] ?? "",
      currentBfp: json["current_bfp"] ?? "",
      activityLevel: json["activity_level"] ?? "",
      howFastToReachGoal: json["how_fast_to_reach_goal"] ?? "",
      heightUnit: json["height_unit"] ?? "",
      weightUnit: json["weight_unit"] ?? "",
      currentWeightUnit: json["current_weight_unit"] ?? "",
      currentWeightValue: json["current_weight_value"] ?? "",
      planStartsAt: json["plan_starts_at"] ?? "",
      woGoal: json["wo_goal"] ?? "",
      lossGainTargetValue: json["loss_gain_target_value"] ?? "",
      lossGainTargetUnit: json["loss_gain_target_unit"] ?? "",
      currentWeek: json["current_week"] ?? "",
      initialBmi: json["initial_bmi"] ?? "",
      initialBmiCat: json["initial_bmi_cat"] ?? "",
      currentBmi: json["current_bmi"] ?? "",
      currentBmiCat: json["current_bmi_cat"] ?? "",
      targetBmi: json["target_bmi"] ?? "",
      targetBmiCat: json["target_bmi_cat"] ?? "",
      initialBfp: json["initial_bfp"] ?? "",
      initialBfpCat: json["initial_bfp_cat"] ?? "",
      currentBfpCat: json["current_bfp_cat"] ?? "",
      targetBfpCat: json["target_bfp_cat"] ?? "",
      initialBmr: json["initial_bmr"] ?? "",
      currentBmr: json["current_bmr"] ?? "",
      age: json["age"] ?? "",
      currentCaloriesIntake: json["current_calories_intake"] ?? "",
      targetBmr: json["target_bmr"] ?? "",
      idealbfpFitness: json["idealbfp_fitness"] ?? "",

      /// SAFE NESTED MODELS
      dayDetails: json["day_details"] != null
          ? DayDetails.fromJson(json["day_details"])
          : DayDetails.empty(),

      aiTargetCalories: json["ai_target_calories"] != null
          ? AiTargetCalories.fromJson(json["ai_target_calories"])
          : AiTargetCalories.empty(),

      targetWeightDynamic: json["target_weight_dynamic"] ?? "",
      totalWeeks: json["totalWeeks"] ?? "",
      targetMaintenanceEstimate: json["target_maintenance_estimate"] ?? "",
      targetWeight: json["target_weight"] ?? "",
      targetWeightDynamic2: json["targetWeightDynamic"] ?? "",
      totalLoss: json["totalLoss"] ?? "",
      weeksToTargetDynamic: json["weeks_to_target_dynamic"] ?? "",
      targetCaloriesForWeightLoss:
          json["target_calories_for_weight_loss"] ?? "",
      currentPhase: json["current_phase"] ?? "",
      durationWeeksPhase1: json["duration_weeks_phase1"] ?? "",
      durationWeeksPhase2: json["duration_weeks_phase2"] ?? "",
      targetWeightPhase1: json["target_weight_phase1"] ?? "",
      targetWeightPhase2: json["target_weight_phase2"] ?? "",

      /// SAFE LIST PARSING
      phaseSummaryDynamic: json["phase_summary_dynamic"] != null
          ? (json["phase_summary_dynamic"] as List)
                .map((e) => PhaseSummary.fromJson(e))
                .toList()
          : [],

      muscleGainOrNot: json["muscle_gain_or_not"] ?? false,
      idealWeight: (json["ideal_weight"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "plan_type": planType,
    "weight_value": weightValue,
    "gender": gender,
    "dob_age_year": dobAgeYear,
    "height_value": heightValue,
    "wo_time": woTime,
    "target_bfp": targetBfp,
    "current_bfp": currentBfp,
    "activity_level": activityLevel,
    "how_fast_to_reach_goal": howFastToReachGoal,
    "height_unit": heightUnit,
    "weight_unit": weightUnit,
    "current_weight_unit": currentWeightUnit,
    "current_weight_value": currentWeightValue,
    "plan_starts_at": planStartsAt,
    "wo_goal": woGoal,
    "loss_gain_target_value": lossGainTargetValue,
    "loss_gain_target_unit": lossGainTargetUnit,
    "current_week": currentWeek,
    "initial_bmi": initialBmi,
    "initial_bmi_cat": initialBmiCat,
    "current_bmi": currentBmi,
    "current_bmi_cat": currentBmiCat,
    "target_bmi": targetBmi,
    "target_bmi_cat": targetBmiCat,
    "initial_bfp": initialBfp,
    "initial_bfp_cat": initialBfpCat,
    "current_bfp_cat": currentBfpCat,
    "target_bfp_cat": targetBfpCat,
    "initial_bmr": initialBmr,
    "current_bmr": currentBmr,
    "age": age,
    "current_calories_intake": currentCaloriesIntake,
    "target_bmr": targetBmr,
    "idealbfp_fitness": idealbfpFitness,
    "day_details": dayDetails.toJson(),
    "ai_target_calories": aiTargetCalories.toJson(),
    "target_weight_dynamic": targetWeightDynamic,
    "totalWeeks": totalWeeks,
    "target_maintenance_estimate": targetMaintenanceEstimate,
    "target_weight": targetWeight,
    "targetWeightDynamic": targetWeightDynamic2,
    "totalLoss": totalLoss,
    "weeks_to_target_dynamic": weeksToTargetDynamic,
    "target_calories_for_weight_loss": targetCaloriesForWeightLoss,
    "current_phase": currentPhase,
    "duration_weeks_phase1": durationWeeksPhase1,
    "duration_weeks_phase2": durationWeeksPhase2,
    "target_weight_phase1": targetWeightPhase1,
    "target_weight_phase2": targetWeightPhase2,
    "phase_summary_dynamic": phaseSummaryDynamic
        .map((e) => e.toJson())
        .toList(),
    "muscle_gain_or_not": muscleGainOrNot,
    "ideal_weight": idealWeight,
  };
}

class DayDetails {
  final String day;
  final int dayId;
  final int mealPlanDayId;
  final int workoutDayNumber;
  final String dayName;
  final String previousDayWorkoutStatus;
  final String previousDayWorkoutStatusEs;
  final String targetWeightFormatted;
  final String targetWeight;
  final String targetWeightUnit;
  final String currentHeightFormatted;
  final String currentHeight;
  final String currentHeightUnit;
  final List<String> weekRange;
  final String weekNumber;
  final int week;
  final String weekFormatted;

  DayDetails({
    required this.day,
    required this.dayId,
    required this.mealPlanDayId,
    required this.workoutDayNumber,
    required this.dayName,
    required this.previousDayWorkoutStatus,
    required this.previousDayWorkoutStatusEs,
    required this.targetWeightFormatted,
    required this.targetWeight,
    required this.targetWeightUnit,
    required this.currentHeightFormatted,
    required this.currentHeight,
    required this.currentHeightUnit,
    required this.weekRange,
    required this.weekNumber,
    required this.week,
    required this.weekFormatted,
  });

  factory DayDetails.fromJson(Map<String, dynamic> json) {
    return DayDetails(
      day: json["day"] ?? "",
      dayId: json["day_id"] ?? 0,
      mealPlanDayId: json["meal_plan_day_id"] ?? 0,
      workoutDayNumber: json["workout_day_number"] ?? 0,
      dayName: json["day_name"] ?? "",
      previousDayWorkoutStatus: json["previous_day_workout_status"] ?? "",
      previousDayWorkoutStatusEs: json["previous_day_workout_status_es"] ?? "",
      targetWeightFormatted: json["target_weight_formatted"] ?? "",
      targetWeight: json["target_weight"] ?? "",
      targetWeightUnit: json["target_weight_unit"] ?? "",
      currentHeightFormatted: json["current_height_formatted"] ?? "",
      currentHeight: json["current_height"] ?? "",
      currentHeightUnit: json["current_height_unit"] ?? "",
      weekRange: List<String>.from(json["week_range"] ?? []),
      weekNumber: json["week_number"] ?? "",
      week: json["week"] ?? 0,
      weekFormatted: json["week_formatted"] ?? "",
    );
  }

  /// EMPTY FALLBACK
  factory DayDetails.empty() {
    return DayDetails(
      day: "",
      dayId: 0,
      mealPlanDayId: 0,
      workoutDayNumber: 0,
      dayName: "",
      previousDayWorkoutStatus: "",
      previousDayWorkoutStatusEs: "",
      targetWeightFormatted: "",
      targetWeight: "",
      targetWeightUnit: "",
      currentHeightFormatted: "",
      currentHeight: "",
      currentHeightUnit: "",
      weekRange: [],
      weekNumber: "",
      week: 0,
      weekFormatted: "",
    );
  }

  Map<String, dynamic> toJson() => {
    "day": day,
    "day_id": dayId,
    "meal_plan_day_id": mealPlanDayId,
    "workout_day_number": workoutDayNumber,
    "day_name": dayName,
    "previous_day_workout_status": previousDayWorkoutStatus,
    "previous_day_workout_status_es": previousDayWorkoutStatusEs,
    "target_weight_formatted": targetWeightFormatted,
    "target_weight": targetWeight,
    "target_weight_unit": targetWeightUnit,
    "current_height_formatted": currentHeightFormatted,
    "current_height": currentHeight,
    "current_height_unit": currentHeightUnit,
    "week_range": weekRange,
    "week_number": weekNumber,
    "week": week,
    "week_formatted": weekFormatted,
  };
}

class AiTargetCalories {
  final String targetCalories;
  final String protein;
  final String fat;
  final String carbs;
  final String proteinGram;
  final String fatGram;
  final String carbsGram;
  final Map<String, dynamic> mealwise;

  AiTargetCalories({
    required this.targetCalories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.proteinGram,
    required this.fatGram,
    required this.carbsGram,
    required this.mealwise,
  });

  factory AiTargetCalories.fromJson(Map<String, dynamic> json) {
    return AiTargetCalories(
      targetCalories: json["target_calories"] ?? "",
      protein: json["protein"] ?? "",
      fat: json["fat"] ?? "",
      carbs: json["carbs"] ?? "",
      proteinGram: json["protein_gram"] ?? "",
      fatGram: json["fat_gram"] ?? "",
      carbsGram: json["carbs_gram"] ?? "",
      mealwise: json["mealwise"] ?? {},
    );
  }

  /// EMPTY FALLBACK
  factory AiTargetCalories.empty() {
    return AiTargetCalories(
      targetCalories: "",
      protein: "",
      fat: "",
      carbs: "",
      proteinGram: "",
      fatGram: "",
      carbsGram: "",
      mealwise: {},
    );
  }

  Map<String, dynamic> toJson() => {
    "target_calories": targetCalories,
    "protein": protein,
    "fat": fat,
    "carbs": carbs,
    "protein_gram": proteinGram,
    "fat_gram": fatGram,
    "carbs_gram": carbsGram,
    "mealwise": mealwise,
  };
}

class PhaseSummary {
  final String phase;
  final String durationWeeks;
  final String startWeight;
  final String endWeight;
  final String targetWeightPhase;
  final String dailyCalories;
  final String maintenanceEstimate;
  final String deficientCalories;

  PhaseSummary({
    required this.phase,
    required this.durationWeeks,
    required this.startWeight,
    required this.endWeight,
    required this.targetWeightPhase,
    required this.dailyCalories,
    required this.maintenanceEstimate,
    required this.deficientCalories,
  });

  factory PhaseSummary.fromJson(Map<String, dynamic> json) {
    return PhaseSummary(
      phase: json["phase"] ?? "",
      durationWeeks:
          json["duration_weeks"] ?? json["duration_weeks_phase1"] ?? "",
      startWeight: json["start_weight"] ?? "",
      endWeight: json["end_weight"] ?? "",
      targetWeightPhase:
          json["target_weight_phase1"] ?? json["target_weight_phase2"] ?? "",
      dailyCalories: json["daily_calories"] ?? "",
      maintenanceEstimate: json["maintenance_estimate"] ?? "",
      deficientCalories: json["deficient_calories"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "phase": phase,
    "duration_weeks": durationWeeks,
    "start_weight": startWeight,
    "end_weight": endWeight,
    "target_weight_phase": targetWeightPhase,
    "daily_calories": dailyCalories,
    "maintenance_estimate": maintenanceEstimate,
    "deficient_calories": deficientCalories,
  };
}
