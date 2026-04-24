import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool? success;
  String? message;
  DashboardData? data;

  DashboardModel({this.success, this.message, this.data});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DashboardData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

// ---------------------------------------------------------
// DASHBOARD DATA
// ---------------------------------------------------------

class DashboardData {
  UserDetails? userDetails;
  DayDetails? dayDetails;
  String? currentCaloriesIntake;
  String? targetCaloriesIntake;
  String? currentWeightFormatted;
  String? targetWeightFormatted;
  String? currentWeekTargetWeight;
  String? currentWeekTargetWeightValue;
  String? showWeightConfirmPopup;
  String? emailExist;
  String? currentWeekTargetCaloriesPercentage;
  int? currentMonth;
  int? showRewardsPopup;
  String? idealbfpFitness;
  int? weeksToTargetWeight;
  TargetCalories? targetCalories;
  String? currentBfp;
  String? currentBfpCat;
  String? targetBfp;
  String? targetBfpCat;
  NewAppData? newAppData;
  String? currentPhase;
  AiTargetCalories? aiTargetCalories;
  String? confirmPhaseWeightPopup;
  String? aiWeightLogAddedToday;
  WeekFlags? weekFlags;
  List<dynamic>? latestSkeletalMuscleLogs;
  List<dynamic>? latestWeightLogs;
  List<dynamic>? latestBodyFatPercentageLogs;
  List<dynamic>? latestTotalBodyWaterLogs;
  List<dynamic>? latestSubcutaneousFatLogs;
  List<dynamic>? latestVisceralFatLevelLogs;

  DashboardData({
    this.userDetails,
    this.dayDetails,
    this.currentCaloriesIntake,
    this.targetCaloriesIntake,
    this.currentWeightFormatted,
    this.targetWeightFormatted,
    this.currentWeekTargetWeight,
    this.currentWeekTargetWeightValue,
    this.showWeightConfirmPopup,
    this.emailExist,
    this.currentWeekTargetCaloriesPercentage,
    this.currentMonth,
    this.showRewardsPopup,
    this.idealbfpFitness,
    this.weeksToTargetWeight,
    this.targetCalories,
    this.currentBfp,
    this.currentBfpCat,
    this.targetBfp,
    this.targetBfpCat,
    this.newAppData,
    this.currentPhase,
    this.aiTargetCalories,
    this.confirmPhaseWeightPopup,
    this.aiWeightLogAddedToday,
    this.weekFlags,
    this.latestSkeletalMuscleLogs,
    this.latestWeightLogs,
    this.latestBodyFatPercentageLogs,
    this.latestTotalBodyWaterLogs,
    this.latestSubcutaneousFatLogs,
    this.latestVisceralFatLevelLogs,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    userDetails: json["user_details"] == null
        ? null
        : UserDetails.fromJson(json["user_details"]),
    dayDetails: json["day_details"] == null
        ? null
        : DayDetails.fromJson(json["day_details"]),
    currentCaloriesIntake: json["current_calories_intake"],
    targetCaloriesIntake: json["target_calories_intake"],
    currentWeightFormatted: json["current_weight_formatted"],
    targetWeightFormatted: json["target_weight_formatted"],
    currentWeekTargetWeight: json["current_week_target_weight"],
    currentWeekTargetWeightValue: json["current_week_target_weight_value"],
    showWeightConfirmPopup: json["show_weight_confirm_popup"],
    emailExist: json["email_exist"],
    currentWeekTargetCaloriesPercentage:
        json["current_week_target_calories_percentage"],
    currentMonth: json["current_month"],
    showRewardsPopup: json["show_rewards_popup"],
    idealbfpFitness: json["idealbfp_fitness"],
    weeksToTargetWeight: json["weeks_to_target_weight"],
    targetCalories: json["target_calories"] == null
        ? null
        : TargetCalories.fromJson(json["target_calories"]),
    currentBfp: json["current_bfp"],
    currentBfpCat: json["current_bfp_cat"],
    targetBfp: json["target_bfp"],
    targetBfpCat: json["target_bfp_cat"],
    newAppData: json["new_app_data"] == null
        ? null
        : NewAppData.fromJson(json["new_app_data"]),
    currentPhase: json["current_phase"],
    aiTargetCalories: json["ai_target_calories"] == null
        ? null
        : AiTargetCalories.fromJson(json["ai_target_calories"]),
    confirmPhaseWeightPopup: json["confirm_phase_weight_popup"],
    aiWeightLogAddedToday: json["ai_weight_log_added_today"],
    weekFlags: json["week_flags"] == null
        ? null
        : WeekFlags.fromJson(json["week_flags"]),
    latestSkeletalMuscleLogs: json["latest_skeletal_muscle_logs"] ?? [],
    latestWeightLogs: json["latest_weight_logs"] ?? [],
    latestBodyFatPercentageLogs: json["latest_body_fat_percentage_logs"] ?? [],
    latestTotalBodyWaterLogs: json["latest_total_body_water_logs"] ?? [],
    latestSubcutaneousFatLogs: json["latest_subcutaneous_fat_logs"] ?? [],
    latestVisceralFatLevelLogs: json["latest_visceral_fat_level_logs"] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "user_details": userDetails?.toJson(),
    "day_details": dayDetails?.toJson(),
    "current_calories_intake": currentCaloriesIntake,
    "target_calories_intake": targetCaloriesIntake,
    "current_weight_formatted": currentWeightFormatted,
    "target_weight_formatted": targetWeightFormatted,
    "current_week_target_weight": currentWeekTargetWeight,
    "current_week_target_weight_value": currentWeekTargetWeightValue,
    "show_weight_confirm_popup": showWeightConfirmPopup,
    "email_exist": emailExist,
    "current_week_target_calories_percentage":
        currentWeekTargetCaloriesPercentage,
    "current_month": currentMonth,
    "show_rewards_popup": showRewardsPopup,
    "idealbfp_fitness": idealbfpFitness,
    "weeks_to_target_weight": weeksToTargetWeight,
    "target_calories": targetCalories?.toJson(),
    "current_bfp": currentBfp,
    "current_bfp_cat": currentBfpCat,
    "target_bfp": targetBfp,
    "target_bfp_cat": targetBfpCat,
    "new_app_data": newAppData?.toJson(),
    "current_phase": currentPhase,
    "ai_target_calories": aiTargetCalories?.toJson(),
    "confirm_phase_weight_popup": confirmPhaseWeightPopup,
    "ai_weight_log_added_today": aiWeightLogAddedToday,
    "week_flags": weekFlags?.toJson(),
    "latest_skeletal_muscle_logs": latestSkeletalMuscleLogs,
    "latest_weight_logs": latestWeightLogs,
    "latest_body_fat_percentage_logs": latestBodyFatPercentageLogs,
    "latest_total_body_water_logs": latestTotalBodyWaterLogs,
    "latest_subcutaneous_fat_logs": latestSubcutaneousFatLogs,
    "latest_visceral_fat_level_logs": latestVisceralFatLevelLogs,
  };
}

// ---------------------------------------------------------
// USER DETAILS
// ---------------------------------------------------------

class UserDetails {
  int? id;
  String? userType;
  String? deviceId;
  String? username;
  String? name;
  String? email;
  String? gender;
  String? image;
  String? birthYear;
  String? otp;
  dynamic token;
  int? active;
  int? winnerStatus;
  String? lastLoginAt;
  String? deviceType;
  String? appType;
  String? caloriesCronDone;
  String? createdAt;
  String? updatedAt;
  String? imageFullUrl;
  ShowWarningPopup? showWarningPopup;
  int? noOfDaysRegistered;
  bool? winner;
  int? currentMonthCoinsCount;

  UserDetails({
    this.id,
    this.userType,
    this.deviceId,
    this.username,
    this.name,
    this.email,
    this.gender,
    this.image,
    this.birthYear,
    this.otp,
    this.token,
    this.active,
    this.winnerStatus,
    this.lastLoginAt,
    this.deviceType,
    this.appType,
    this.caloriesCronDone,
    this.createdAt,
    this.updatedAt,
    this.imageFullUrl,
    this.showWarningPopup,
    this.noOfDaysRegistered,
    this.winner,
    this.currentMonthCoinsCount,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    userType: json["user_type"],
    deviceId: json["device_id"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    image: json["image"],
    birthYear: json["birth_year"],
    otp: json["otp"],
    token: json["token"],
    active: json["active"],
    winnerStatus: json["winner_status"],
    lastLoginAt: json["last_login_at"],
    deviceType: json["device_type"],
    appType: json["app_type"],
    caloriesCronDone: json["calories_cron_done"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    imageFullUrl: json["image_full_url"],
    showWarningPopup: json["show_warning_popup"] == null
        ? null
        : ShowWarningPopup.fromJson(json["show_warning_popup"]),
    noOfDaysRegistered: json["no_of_days_registered"],
    winner: json["winner"],
    currentMonthCoinsCount: json["current_month_coins_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userType,
    "device_id": deviceId,
    "username": username,
    "name": name,
    "email": email,
    "gender": gender,
    "image": image,
    "birth_year": birthYear,
    "otp": otp,
    "token": token,
    "active": active,
    "winner_status": winnerStatus,
    "last_login_at": lastLoginAt,
    "device_type": deviceType,
    "app_type": appType,
    "calories_cron_done": caloriesCronDone,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_full_url": imageFullUrl,
    "show_warning_popup": showWarningPopup?.toJson(),
    "no_of_days_registered": noOfDaysRegistered,
    "winner": winner,
    "current_month_coins_count": currentMonthCoinsCount,
  };
}

// ---------------------------------------------------------

class ShowWarningPopup {
  bool? show;
  String? warningLabel;

  ShowWarningPopup({this.show, this.warningLabel});

  factory ShowWarningPopup.fromJson(Map<String, dynamic> json) =>
      ShowWarningPopup(show: json["show"], warningLabel: json["warning_label"]);

  Map<String, dynamic> toJson() => {
    "show": show,
    "warning_label": warningLabel,
  };
}

// ---------------------------------------------------------
// DAY DETAILS
// ---------------------------------------------------------

class DayDetails {
  String? day;
  int? dayId;
  int? mealPlanDayId;
  int? workoutDayNumber;
  String? dayName;
  String? previousDayWorkoutStatus;
  String? previousDayWorkoutStatusEs;
  String? targetWeightFormatted;
  String? targetWeight;
  String? targetWeightUnit;
  String? currentHeightFormatted;
  String? currentHeight;
  String? currentHeightUnit;
  List<String>? weekRange;
  String? weekNumber;
  int? week;
  String? weekFormatted;

  DayDetails({
    this.day,
    this.dayId,
    this.mealPlanDayId,
    this.workoutDayNumber,
    this.dayName,
    this.previousDayWorkoutStatus,
    this.previousDayWorkoutStatusEs,
    this.targetWeightFormatted,
    this.targetWeight,
    this.targetWeightUnit,
    this.currentHeightFormatted,
    this.currentHeight,
    this.currentHeightUnit,
    this.weekRange,
    this.weekNumber,
    this.week,
    this.weekFormatted,
  });

  factory DayDetails.fromJson(Map<String, dynamic> json) => DayDetails(
    day: json["day"],
    dayId: json["day_id"],
    mealPlanDayId: json["meal_plan_day_id"],
    workoutDayNumber: json["workout_day_number"],
    dayName: json["day_name"],
    previousDayWorkoutStatus: json["previous_day_workout_status"],
    previousDayWorkoutStatusEs: json["previous_day_workout_status_es"],
    targetWeightFormatted: json["target_weight_formatted"],
    targetWeight: json["target_weight"],
    targetWeightUnit: json["target_weight_unit"],
    currentHeightFormatted: json["current_height_formatted"],
    currentHeight: json["current_height"],
    currentHeightUnit: json["current_height_unit"],
    weekRange: json["week_range"] == null
        ? []
        : List<String>.from(json["week_range"].map((x) => x)),
    weekNumber: json["week_number"],
    week: json["week"],
    weekFormatted: json["week_formatted"],
  );

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

// ---------------------------------------------------------

class TargetCalories {
  String? breakfast;
  String? lunch;
  String? dinner;
  String? snacks;
  String? totalCalories;
  String? proteinCaloriesPercentage;
  String? fatCaloriesPercentage;
  String? carbsCaloriesPercentage;

  TargetCalories({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks,
    this.totalCalories,
    this.proteinCaloriesPercentage,
    this.fatCaloriesPercentage,
    this.carbsCaloriesPercentage,
  });

  factory TargetCalories.fromJson(Map<String, dynamic> json) => TargetCalories(
    breakfast: json["breakfast"],
    lunch: json["lunch"],
    dinner: json["dinner"],
    snacks: json["snacks"],
    totalCalories: json["total_calories"],
    proteinCaloriesPercentage: json["protein_calories_percentage"],
    fatCaloriesPercentage: json["fat_calories_percentage"],
    carbsCaloriesPercentage: json["carbs_calories_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "breakfast": breakfast,
    "lunch": lunch,
    "dinner": dinner,
    "snacks": snacks,
    "total_calories": totalCalories,
    "protein_calories_percentage": proteinCaloriesPercentage,
    "fat_calories_percentage": fatCaloriesPercentage,
    "carbs_calories_percentage": carbsCaloriesPercentage,
  };
}

// ---------------------------------------------------------
// NEW APP DATA
// ---------------------------------------------------------

class NewAppData {
  AiTargetCalories? aiTargetCalories;
  String? targetWeightDynamic;
  String? totalWeeks;
  List<PhaseSummary>? phaseSummaryDynamic;
  String? targetMaintenanceEstimate;
  String? targetWeight;
  String? targetWeightDynamic2;
  String? totalLoss;
  String? weeksToTargetDynamic;
  String? targetCaloriesForWeightLoss;
  String? currentPhase;
  String? durationWeeksPhase1;
  String? durationWeeksPhase2;
  String? targetWeightPhase1;
  String? targetWeightPhase2;

  NewAppData({
    this.aiTargetCalories,
    this.targetWeightDynamic,
    this.totalWeeks,
    this.phaseSummaryDynamic,
    this.targetMaintenanceEstimate,
    this.targetWeight,
    this.targetWeightDynamic2,
    this.totalLoss,
    this.weeksToTargetDynamic,
    this.targetCaloriesForWeightLoss,
    this.currentPhase,
    this.durationWeeksPhase1,
    this.durationWeeksPhase2,
    this.targetWeightPhase1,
    this.targetWeightPhase2,
  });

  factory NewAppData.fromJson(Map<String, dynamic> json) => NewAppData(
    aiTargetCalories: json["ai_target_calories"] == null
        ? null
        : AiTargetCalories.fromJson(json["ai_target_calories"]),
    targetWeightDynamic: json["target_weight_dynamic"],
    totalWeeks: json["totalWeeks"],
    phaseSummaryDynamic: json["phase_summary_dynamic"] == null
        ? []
        : List<PhaseSummary>.from(
            json["phase_summary_dynamic"].map((x) => PhaseSummary.fromJson(x)),
          ),
    targetMaintenanceEstimate: json["target_maintenance_estimate"],
    targetWeight: json["target_weight"],
    targetWeightDynamic2: json["targetWeightDynamic"],
    totalLoss: json["totalLoss"],
    weeksToTargetDynamic: json["weeks_to_target_dynamic"],
    targetCaloriesForWeightLoss: json["target_calories_for_weight_loss"],
    currentPhase: json["current_phase"],
    durationWeeksPhase1: json["duration_weeks_phase1"],
    durationWeeksPhase2: json["duration_weeks_phase2"],
    targetWeightPhase1: json["target_weight_phase1"],
    targetWeightPhase2: json["target_weight_phase2"],
  );

  Map<String, dynamic> toJson() => {
    "ai_target_calories": aiTargetCalories?.toJson(),
    "target_weight_dynamic": targetWeightDynamic,
    "totalWeeks": totalWeeks,
    "phase_summary_dynamic": phaseSummaryDynamic
        ?.map((x) => x.toJson())
        .toList(),
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
  };
}

// ---------------------------------------------------------

class PhaseSummary {
  String? phase;
  String? durationWeeksPhase1;
  String? durationWeeks;
  String? startWeight;
  String? endWeight;
  String? targetWeightPhase1;
  String? dailyCalories;
  String? maintenanceEstimate;
  String? deficientCalories;

  PhaseSummary({
    this.phase,
    this.durationWeeksPhase1,
    this.durationWeeks,
    this.startWeight,
    this.endWeight,
    this.targetWeightPhase1,
    this.dailyCalories,
    this.maintenanceEstimate,
    this.deficientCalories,
  });

  factory PhaseSummary.fromJson(Map<String, dynamic> json) => PhaseSummary(
    phase: json["phase"],
    durationWeeksPhase1: json["duration_weeks_phase1"],
    durationWeeks: json["duration_weeks"],
    startWeight: json["start_weight"],
    endWeight: json["end_weight"],
    targetWeightPhase1: json["target_weight_phase1"],
    dailyCalories: json["daily_calories"],
    maintenanceEstimate: json["maintenance_estimate"],
    deficientCalories: json["deficient_calories"],
  );

  Map<String, dynamic> toJson() => {
    "phase": phase,
    "duration_weeks_phase1": durationWeeksPhase1,
    "duration_weeks": durationWeeks,
    "start_weight": startWeight,
    "end_weight": endWeight,
    "target_weight_phase1": targetWeightPhase1,
    "daily_calories": dailyCalories,
    "maintenance_estimate": maintenanceEstimate,
    "deficient_calories": deficientCalories,
  };
}

// ---------------------------------------------------------
// AI TARGET CALORIES
// ---------------------------------------------------------

class AiTargetCalories {
  String? targetCalories;
  String? protein;
  String? fat;
  String? carbs;
  String? proteinGram;
  String? fatGram;
  String? carbsGram;
  Mealwise? mealwise;
  double? breakfast;
  double? lunch;
  double? snacks;
  double? dinner;

  AiTargetCalories({
    this.targetCalories,
    this.protein,
    this.fat,
    this.carbs,
    this.proteinGram,
    this.fatGram,
    this.carbsGram,
    this.mealwise,
    this.breakfast,
    this.lunch,
    this.snacks,
    this.dinner,
  });

  factory AiTargetCalories.fromJson(Map<String, dynamic> json) =>
      AiTargetCalories(
        targetCalories: json["target_calories"]?.toString(),
        protein: json["protein"]?.toString(),
        fat: json["fat"]?.toString(),
        carbs: json["carbs"]?.toString(),
        proteinGram: json["protein_gram"]?.toString(),
        fatGram: json["fat_gram"]?.toString(),
        carbsGram: json["carbs_gram"]?.toString(),
        mealwise: json["mealwise"] == null
            ? null
            : Mealwise.fromJson(json["mealwise"]),
        breakfast: (json["breakfast"] ?? 0).toDouble(),
        lunch: (json["lunch"] ?? 0).toDouble(),
        snacks: (json["snacks"] ?? 0).toDouble(),
        dinner: (json["dinner"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "target_calories": targetCalories,
    "protein": protein,
    "fat": fat,
    "carbs": carbs,
    "protein_gram": proteinGram,
    "fat_gram": fatGram,
    "carbs_gram": carbsGram,
    "mealwise": mealwise?.toJson(),
    "breakfast": breakfast,
    "lunch": lunch,
    "snacks": snacks,
    "dinner": dinner,
  };
}

// ---------------------------------------------------------

class Mealwise {
  MealItem? preworkout;
  MealItem? intraWorkout;
  MealItem? postWorkout;
  MealItem? breakfast;
  MealItem? lunch;
  MealItem? dinner;
  MealItem? snack;
  MealItem? postWorkoutDiet;
  MealItem? preWorkoutDiet;

  Mealwise({
    this.preworkout,
    this.intraWorkout,
    this.postWorkout,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,
    this.postWorkoutDiet,
    this.preWorkoutDiet,
  });

  factory Mealwise.fromJson(Map<String, dynamic> json) => Mealwise(
    preworkout: MealItem.fromJson(json["preworkout"]),
    intraWorkout: MealItem.fromJson(json["intra_workout"]),
    postWorkout: MealItem.fromJson(json["post_workout"]),
    breakfast: MealItem.fromJson(json["breakfast"]),
    lunch: MealItem.fromJson(json["lunch"]),
    dinner: MealItem.fromJson(json["dinner"]),
    snack: MealItem.fromJson(json["snack"]),
    postWorkoutDiet: MealItem.fromJson(json["post_workout_diet"]),
    preWorkoutDiet: MealItem.fromJson(json["pre_workout_diet"]),
  );

  Map<String, dynamic> toJson() => {
    "preworkout": preworkout?.toJson(),
    "intra_workout": intraWorkout?.toJson(),
    "post_workout": postWorkout?.toJson(),
    "breakfast": breakfast?.toJson(),
    "lunch": lunch?.toJson(),
    "dinner": dinner?.toJson(),
    "snack": snack?.toJson(),
    "post_workout_diet": postWorkoutDiet?.toJson(),
    "pre_workout_diet": preWorkoutDiet?.toJson(),
  };
}

// ---------------------------------------------------------

class MealItem {
  dynamic targetCalories;
  dynamic protein;
  dynamic proteinGram;
  dynamic fat;
  dynamic fatGram;
  dynamic carbs;
  dynamic carbsGram;
  dynamic lysineGram;

  MealItem({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) => MealItem(
    targetCalories: json["target_calories"],
    protein: json["protein"],
    proteinGram: json["protein_gram"],
    fat: json["fat"],
    fatGram: json["fat_gram"],
    carbs: json["carbs"],
    carbsGram: json["carbs_gram"],
    lysineGram: json["lysine_gram"],
  );

  Map<String, dynamic> toJson() => {
    "target_calories": targetCalories,
    "protein": protein,
    "protein_gram": proteinGram,
    "fat": fat,
    "fat_gram": fatGram,
    "carbs": carbs,
    "carbs_gram": carbsGram,
    "lysine_gram": lysineGram,
  };
}

// ---------------------------------------------------------

class WeekFlags {
  String? deloadWeek;
  String? progressiveWeek;

  WeekFlags({this.deloadWeek, this.progressiveWeek});

  factory WeekFlags.fromJson(Map<String, dynamic> json) => WeekFlags(
    deloadWeek: json["deload_week"],
    progressiveWeek: json["progressive_week"],
  );

  Map<String, dynamic> toJson() => {
    "deload_week": deloadWeek,
    "progressive_week": progressiveWeek,
  };
}
