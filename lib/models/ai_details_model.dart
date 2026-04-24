// lib/models/ai_details_response.dart
// Null-safe, complete model for the provided JSON structure.
// Usage: final resp = AiDetailsResponse.fromJson(jsonMap);

class AiDetailsResponse {
  bool? status;
  String? message;
  Data? data;

  AiDetailsResponse({this.status, this.message, this.data});

  factory AiDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AiDetailsResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

class Data {
  UserDetails? userDetails;
  NewAppData? newAppData;
  UserBodyMetrics? userBodyMetrics;

  Data({this.userDetails, this.newAppData, this.userBodyMetrics});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: json['user_details'] != null ? UserDetails.fromJson(json['user_details'] as Map<String, dynamic>) : null,
        newAppData: json['new_app_data'] != null ? NewAppData.fromJson(json['new_app_data'] as Map<String, dynamic>) : null,
        userBodyMetrics: json['user_body_metrics'] != null ? UserBodyMetrics.fromJson(json['user_body_metrics'] as Map<String, dynamic>) : null,
      );

  Map<String, dynamic> toJson() => {
        if (userDetails != null) 'user_details': userDetails!.toJson(),
        if (newAppData != null) 'new_app_data': newAppData!.toJson(),
        if (userBodyMetrics != null) 'user_body_metrics': userBodyMetrics!.toJson(),
      };
}

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
  dynamic token; // previously `Null? token;` -> dynamic to accept string/null/object
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
        id: json['id'] as int?,
        userType: json['user_type'] as String?,
        deviceId: json['device_id'] as String?,
        username: json['username'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        image: json['image'] as String?,
        birthYear: json['birth_year'] as String?,
        otp: json['otp'] as String?,
        token: json.containsKey('token') ? json['token'] : null,
        active: json['active'] is int ? json['active'] as int? : (json['active'] != null ? int.tryParse(json['active'].toString()) : null),
        winnerStatus: json['winner_status'] is int ? json['winner_status'] as int? : (json['winner_status'] != null ? int.tryParse(json['winner_status'].toString()) : null),
        lastLoginAt: json['last_login_at'] as String?,
        deviceType: json['device_type'] as String?,
        appType: json['app_type'] as String?,
        caloriesCronDone: json['calories_cron_done'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        imageFullUrl: json['image_full_url'] as String?,
        showWarningPopup: json['show_warning_popup'] != null ? ShowWarningPopup.fromJson(json['show_warning_popup'] as Map<String, dynamic>) : null,
        noOfDaysRegistered: json['no_of_days_registered'] is int ? json['no_of_days_registered'] as int? : (json['no_of_days_registered'] != null ? int.tryParse(json['no_of_days_registered'].toString()) : null),
        winner: json['winner'] as bool?,
        currentMonthCoinsCount: json['current_month_coins_count'] is int ? json['current_month_coins_count'] as int? : (json['current_month_coins_count'] != null ? int.tryParse(json['current_month_coins_count'].toString()) : null),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_type': userType,
        'device_id': deviceId,
        'username': username,
        'name': name,
        'email': email,
        'gender': gender,
        'image': image,
        'birth_year': birthYear,
        'otp': otp,
        'token': token,
        'active': active,
        'winner_status': winnerStatus,
        'last_login_at': lastLoginAt,
        'device_type': deviceType,
        'app_type': appType,
        'calories_cron_done': caloriesCronDone,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'image_full_url': imageFullUrl,
        if (showWarningPopup != null) 'show_warning_popup': showWarningPopup!.toJson(),
        'no_of_days_registered': noOfDaysRegistered,
        'winner': winner,
        'current_month_coins_count': currentMonthCoinsCount,
      };
}

class ShowWarningPopup {
  bool? show;
  String? warningLabel;

  ShowWarningPopup({this.show, this.warningLabel});

  factory ShowWarningPopup.fromJson(Map<String, dynamic> json) => ShowWarningPopup(
        show: json['show'] as bool?,
        warningLabel: json['warning_label'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'show': show,
        'warning_label': warningLabel,
      };
}

class NewAppData {
  AiTargetCalories? aiTargetCalories;
  String? targetWeightDynamic;
  String? totalWeeks;
  List<PhaseSummaryDynamic>? phaseSummaryDynamic;
  String? targetMaintenanceEstimate;
  String? targetWeight;
  String? targetWeightDynamicCamel; // kept original duplication name different
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
    this.targetWeightDynamicCamel,
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
        aiTargetCalories: json['ai_target_calories'] != null ? AiTargetCalories.fromJson(json['ai_target_calories'] as Map<String, dynamic>) : null,
        targetWeightDynamic: json['target_weight_dynamic'] as String?,
        totalWeeks: json['totalWeeks'] as String?,
        phaseSummaryDynamic: json['phase_summary_dynamic'] != null
            ? (json['phase_summary_dynamic'] as List).map((e) => PhaseSummaryDynamic.fromJson(e as Map<String, dynamic>)).toList()
            : null,
        targetMaintenanceEstimate: json['target_maintenance_estimate'] as String?,
        targetWeight: json['target_weight'] as String?,
        targetWeightDynamicCamel: json['targetWeightDynamic'] as String?,
        totalLoss: json['totalLoss'] as String?,
        weeksToTargetDynamic: json['weeks_to_target_dynamic'] as String?,
        targetCaloriesForWeightLoss: json['target_calories_for_weight_loss'] as String?,
        currentPhase: json['current_phase'] as String?,
        durationWeeksPhase1: json['duration_weeks_phase1'] as String?,
        durationWeeksPhase2: json['duration_weeks_phase2'] as String?,
        targetWeightPhase1: json['target_weight_phase1'] as String?,
        targetWeightPhase2: json['target_weight_phase2'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (aiTargetCalories != null) 'ai_target_calories': aiTargetCalories!.toJson(),
        'target_weight_dynamic': targetWeightDynamic,
        'totalWeeks': totalWeeks,
        if (phaseSummaryDynamic != null) 'phase_summary_dynamic': phaseSummaryDynamic!.map((e) => e.toJson()).toList(),
        'target_maintenance_estimate': targetMaintenanceEstimate,
        'target_weight': targetWeight,
        'targetWeightDynamic': targetWeightDynamicCamel,
        'totalLoss': totalLoss,
        'weeks_to_target_dynamic': weeksToTargetDynamic,
        'target_calories_for_weight_loss': targetCaloriesForWeightLoss,
        'current_phase': currentPhase,
        'duration_weeks_phase1': durationWeeksPhase1,
        'duration_weeks_phase2': durationWeeksPhase2,
        'target_weight_phase1': targetWeightPhase1,
        'target_weight_phase2': targetWeightPhase2,
      };
}

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
  int? lunch;
  double? snacks;
  int? dinner;

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

  factory AiTargetCalories.fromJson(Map<String, dynamic> json) => AiTargetCalories(
        targetCalories: json['target_calories']?.toString(),
        protein: json['protein']?.toString(),
        fat: json['fat']?.toString(),
        carbs: json['carbs']?.toString(),
        proteinGram: json['protein_gram']?.toString(),
        fatGram: json['fat_gram']?.toString(),
        carbsGram: json['carbs_gram']?.toString(),
        mealwise: json['mealwise'] != null ? Mealwise.fromJson(json['mealwise'] as Map<String, dynamic>) : null,
        breakfast: json['breakfast'] != null ? (json['breakfast'] as num).toDouble() : null,
        lunch: json['lunch'] is int ? json['lunch'] as int? : (json['lunch'] != null ? int.tryParse(json['lunch'].toString()) : null),
        snacks: json['snacks'] != null ? (json['snacks'] as num).toDouble() : null,
        dinner: json['dinner'] is int ? json['dinner'] as int? : (json['dinner'] != null ? int.tryParse(json['dinner'].toString()) : null),
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'fat': fat,
        'carbs': carbs,
        'protein_gram': proteinGram,
        'fat_gram': fatGram,
        'carbs_gram': carbsGram,
        if (mealwise != null) 'mealwise': mealwise!.toJson(),
        'breakfast': breakfast,
        'lunch': lunch,
        'snacks': snacks,
        'dinner': dinner,
      };
}

class Mealwise {
  Preworkout? preworkout;
  IntraWorkout? intraWorkout;
  PostWorkout? postWorkout;
  PostWorkout? breakfast;
  Lunch? lunch;
  Lunch? dinner;
  PostWorkout? snack;
  PostWorkoutDiet? postWorkoutDiet;
  PreWorkoutDiet? preWorkoutDiet;

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
        preworkout: json['preworkout'] != null ? Preworkout.fromJson(json['preworkout'] as Map<String, dynamic>) : null,
        intraWorkout: json['intra_workout'] != null ? IntraWorkout.fromJson(json['intra_workout'] as Map<String, dynamic>) : null,
        postWorkout: json['post_workout'] != null ? PostWorkout.fromJson(json['post_workout'] as Map<String, dynamic>) : null,
        breakfast: json['breakfast'] != null ? PostWorkout.fromJson(json['breakfast'] as Map<String, dynamic>) : null,
        lunch: json['lunch'] != null ? Lunch.fromJson(json['lunch'] as Map<String, dynamic>) : null,
        dinner: json['dinner'] != null ? Lunch.fromJson(json['dinner'] as Map<String, dynamic>) : null,
        snack: json['snack'] != null ? PostWorkout.fromJson(json['snack'] as Map<String, dynamic>) : null,
        postWorkoutDiet: json['post_workout_diet'] != null ? PostWorkoutDiet.fromJson(json['post_workout_diet'] as Map<String, dynamic>) : null,
        preWorkoutDiet: json['pre_workout_diet'] != null ? PreWorkoutDiet.fromJson(json['pre_workout_diet'] as Map<String, dynamic>) : null,
      );

  Map<String, dynamic> toJson() => {
        if (preworkout != null) 'preworkout': preworkout!.toJson(),
        if (intraWorkout != null) 'intra_workout': intraWorkout!.toJson(),
        if (postWorkout != null) 'post_workout': postWorkout!.toJson(),
        if (breakfast != null) 'breakfast': breakfast!.toJson(),
        if (lunch != null) 'lunch': lunch!.toJson(),
        if (dinner != null) 'dinner': dinner!.toJson(),
        if (snack != null) 'snack': snack!.toJson(),
        if (postWorkoutDiet != null) 'post_workout_diet': postWorkoutDiet!.toJson(),
        if (preWorkoutDiet != null) 'pre_workout_diet': preWorkoutDiet!.toJson(),
      };
}

class Preworkout {
  double? targetCalories;
  double? protein;
  double? proteinGram;
  double? fat;
  double? fatGram;
  int? carbs;
  double? carbsGram;
  double? lysineGram;

  Preworkout({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory Preworkout.fromJson(Map<String, dynamic> json) => Preworkout(
        targetCalories: json['target_calories'] != null ? (json['target_calories'] as num).toDouble() : null,
        protein: json['protein'] != null ? (json['protein'] as num).toDouble() : null,
        proteinGram: json['protein_gram'] != null ? (json['protein_gram'] as num).toDouble() : null,
        fat: json['fat'] != null ? (json['fat'] as num).toDouble() : null,
        fatGram: json['fat_gram'] != null ? (json['fat_gram'] as num).toDouble() : null,
        carbs: json['carbs'] is int ? json['carbs'] as int? : (json['carbs'] != null ? int.tryParse(json['carbs'].toString()) : null),
        carbsGram: json['carbs_gram'] != null ? (json['carbs_gram'] as num).toDouble() : null,
        lysineGram: json['lysine_gram'] != null ? (json['lysine_gram'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'protein_gram': proteinGram,
        'fat': fat,
        'fat_gram': fatGram,
        'carbs': carbs,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class IntraWorkout {
  int? targetCalories;
  int? protein;
  int? fat;
  int? carbs;
  int? proteinGram;
  int? fatGram;
  int? carbsGram;
  int? lysineGram;

  IntraWorkout({
    this.targetCalories,
    this.protein,
    this.fat,
    this.carbs,
    this.proteinGram,
    this.fatGram,
    this.carbsGram,
    this.lysineGram,
  });

  factory IntraWorkout.fromJson(Map<String, dynamic> json) => IntraWorkout(
        targetCalories: json['target_calories'] is int ? json['target_calories'] as int? : (json['target_calories'] != null ? int.tryParse(json['target_calories'].toString()) : null),
        protein: json['protein'] is int ? json['protein'] as int? : (json['protein'] != null ? int.tryParse(json['protein'].toString()) : null),
        fat: json['fat'] is int ? json['fat'] as int? : (json['fat'] != null ? int.tryParse(json['fat'].toString()) : null),
        carbs: json['carbs'] is int ? json['carbs'] as int? : (json['carbs'] != null ? int.tryParse(json['carbs'].toString()) : null),
        proteinGram: json['protein_gram'] is int ? json['protein_gram'] as int? : (json['protein_gram'] != null ? int.tryParse(json['protein_gram'].toString()) : null),
        fatGram: json['fat_gram'] is int ? json['fat_gram'] as int? : (json['fat_gram'] != null ? int.tryParse(json['fat_gram'].toString()) : null),
        carbsGram: json['carbs_gram'] is int ? json['carbs_gram'] as int? : (json['carbs_gram'] != null ? int.tryParse(json['carbs_gram'].toString()) : null),
        lysineGram: json['lysine_gram'] is int ? json['lysine_gram'] as int? : (json['lysine_gram'] != null ? int.tryParse(json['lysine_gram'].toString()) : null),
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'fat': fat,
        'carbs': carbs,
        'protein_gram': proteinGram,
        'fat_gram': fatGram,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class PostWorkout {
  double? targetCalories;
  double? protein;
  double? proteinGram;
  double? fat;
  double? fatGram;
  double? carbs;
  double? carbsGram;
  double? lysineGram;

  PostWorkout({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory PostWorkout.fromJson(Map<String, dynamic> json) => PostWorkout(
        targetCalories: json['target_calories'] != null ? (json['target_calories'] as num).toDouble() : null,
        protein: json['protein'] != null ? (json['protein'] as num).toDouble() : null,
        proteinGram: json['protein_gram'] != null ? (json['protein_gram'] as num).toDouble() : null,
        fat: json['fat'] != null ? (json['fat'] as num).toDouble() : null,
        fatGram: json['fat_gram'] != null ? (json['fat_gram'] as num).toDouble() : null,
        carbs: json['carbs'] != null ? (json['carbs'] as num).toDouble() : null,
        carbsGram: json['carbs_gram'] != null ? (json['carbs_gram'] as num).toDouble() : null,
        lysineGram: json['lysine_gram'] != null ? (json['lysine_gram'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'protein_gram': proteinGram,
        'fat': fat,
        'fat_gram': fatGram,
        'carbs': carbs,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class Lunch {
  int? targetCalories;
  double? protein;
  double? proteinGram;
  double? fat;
  double? fatGram;
  double? carbs;
  double? carbsGram;
  double? lysineGram;

  Lunch({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory Lunch.fromJson(Map<String, dynamic> json) => Lunch(
        targetCalories: json['target_calories'] is int ? json['target_calories'] as int? : (json['target_calories'] != null ? int.tryParse(json['target_calories'].toString()) : null),
        protein: json['protein'] != null ? (json['protein'] as num).toDouble() : null,
        proteinGram: json['protein_gram'] != null ? (json['protein_gram'] as num).toDouble() : null,
        fat: json['fat'] != null ? (json['fat'] as num).toDouble() : null,
        fatGram: json['fat_gram'] != null ? (json['fat_gram'] as num).toDouble() : null,
        carbs: json['carbs'] != null ? (json['carbs'] as num).toDouble() : null,
        carbsGram: json['carbs_gram'] != null ? (json['carbs_gram'] as num).toDouble() : null,
        lysineGram: json['lysine_gram'] != null ? (json['lysine_gram'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'protein_gram': proteinGram,
        'fat': fat,
        'fat_gram': fatGram,
        'carbs': carbs,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class PostWorkoutDiet {
  int? targetCalories;
  int? protein;
  int? proteinGram;
  int? fat;
  double? fatGram;
  int? carbs;
  double? carbsGram;
  int? lysineGram;

  PostWorkoutDiet({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory PostWorkoutDiet.fromJson(Map<String, dynamic> json) => PostWorkoutDiet(
        targetCalories: json['target_calories'] is int ? json['target_calories'] as int? : (json['target_calories'] != null ? int.tryParse(json['target_calories'].toString()) : null),
        protein: json['protein'] is int ? json['protein'] as int? : (json['protein'] != null ? int.tryParse(json['protein'].toString()) : null),
        proteinGram: json['protein_gram'] is int ? json['protein_gram'] as int? : (json['protein_gram'] != null ? int.tryParse(json['protein_gram'].toString()) : null),
        fat: json['fat'] is int ? json['fat'] as int? : (json['fat'] != null ? int.tryParse(json['fat'].toString()) : null),
        fatGram: json['fat_gram'] != null ? (json['fat_gram'] as num).toDouble() : null,
        carbs: json['carbs'] is int ? json['carbs'] as int? : (json['carbs'] != null ? int.tryParse(json['carbs'].toString()) : null),
        carbsGram: json['carbs_gram'] != null ? (json['carbs_gram'] as num).toDouble() : null,
        lysineGram: json['lysine_gram'] is int ? json['lysine_gram'] as int? : (json['lysine_gram'] != null ? int.tryParse(json['lysine_gram'].toString()) : null),
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'protein_gram': proteinGram,
        'fat': fat,
        'fat_gram': fatGram,
        'carbs': carbs,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class PreWorkoutDiet {
  int? targetCalories;
  double? protein;
  double? proteinGram;
  int? fat;
  double? fatGram;
  double? carbs;
  double? carbsGram;
  double? lysineGram;

  PreWorkoutDiet({
    this.targetCalories,
    this.protein,
    this.proteinGram,
    this.fat,
    this.fatGram,
    this.carbs,
    this.carbsGram,
    this.lysineGram,
  });

  factory PreWorkoutDiet.fromJson(Map<String, dynamic> json) => PreWorkoutDiet(
        targetCalories: json['target_calories'] is int ? json['target_calories'] as int? : (json['target_calories'] != null ? int.tryParse(json['target_calories'].toString()) : null),
        protein: json['protein'] != null ? (json['protein'] as num).toDouble() : null,
        proteinGram: json['protein_gram'] != null ? (json['protein_gram'] as num).toDouble() : null,
        fat: json['fat'] is int ? json['fat'] as int? : (json['fat'] != null ? int.tryParse(json['fat'].toString()) : null),
        fatGram: json['fat_gram'] != null ? (json['fat_gram'] as num).toDouble() : null,
        carbs: json['carbs'] != null ? (json['carbs'] as num).toDouble() : null,
        carbsGram: json['carbs_gram'] != null ? (json['carbs_gram'] as num).toDouble() : null,
        lysineGram: json['lysine_gram'] != null ? (json['lysine_gram'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'target_calories': targetCalories,
        'protein': protein,
        'protein_gram': proteinGram,
        'fat': fat,
        'fat_gram': fatGram,
        'carbs': carbs,
        'carbs_gram': carbsGram,
        'lysine_gram': lysineGram,
      };
}

class PhaseSummaryDynamic {
  String? phase;
  String? durationWeeksPhase1;
  String? durationWeeks;
  String? startWeight;
  String? endWeight;
  String? targetWeightPhase1;
  String? dailyCalories;
  String? maintenanceEstimate;
  String? deficientCalories;
  String? durationWeeksPhase2;
  String? targetWeightPhase2;

  PhaseSummaryDynamic({
    this.phase,
    this.durationWeeksPhase1,
    this.durationWeeks,
    this.startWeight,
    this.endWeight,
    this.targetWeightPhase1,
    this.dailyCalories,
    this.maintenanceEstimate,
    this.deficientCalories,
    this.durationWeeksPhase2,
    this.targetWeightPhase2,
  });

  factory PhaseSummaryDynamic.fromJson(Map<String, dynamic> json) => PhaseSummaryDynamic(
        phase: json['phase'] as String?,
        durationWeeksPhase1: json['duration_weeks_phase1'] as String?,
        durationWeeks: json['duration_weeks'] as String?,
        startWeight: json['start_weight'] as String?,
        endWeight: json['end_weight'] as String?,
        targetWeightPhase1: json['target_weight_phase1'] as String?,
        dailyCalories: json['daily_calories'] as String?,
        maintenanceEstimate: json['maintenance_estimate'] as String?,
        deficientCalories: json['deficient_calories'] as String?,
        durationWeeksPhase2: json['duration_weeks_phase2'] as String?,
        targetWeightPhase2: json['target_weight_phase2'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'phase': phase,
        'duration_weeks_phase1': durationWeeksPhase1,
        'duration_weeks': durationWeeks,
        'start_weight': startWeight,
        'end_weight': endWeight,
        'target_weight_phase1': targetWeightPhase1,
        'daily_calories': dailyCalories,
        'maintenance_estimate': maintenanceEstimate,
        'deficient_calories': deficientCalories,
        'duration_weeks_phase2': durationWeeksPhase2,
        'target_weight_phase2': targetWeightPhase2,
      };
}

class UserBodyMetrics {
  String? id;
  String? userId;
  String? idealWeight;
  String? musclesDone;
  String? activePlanId;
  String? initialBmi;
  String? initialBmiCat;
  String? initialBfp;
  String? initialBfpCat;
  String? initialBmr;
  String? currentBmi;
  String? currentBmiCat;
  String? currentBfp;
  String? currentBfpCat;
  String? currentBmr;
  String? currentCaloriesIntake;
  String? targetCaloriesIntake;
  String? targetCaloriesIntakeWeek;
  String? caloriesTargetDayWise;
  String? targetBmi;
  String? targetBmiCat;
  String? targetBfp;
  String? targetBfpCat;
  String? targetBmr;
  String? targetWeightValue;
  String? targetWeightUnit;
  String? weightValue;
  String? weightUnit;
  String? heightValue;
  String? heightUnit;
  String? age;
  String? dobAgeMonth;
  String? dobAgeYear;
  String? neckValue;
  String? neckUnit;
  String? waistValue;
  String? waistUnit;
  String? hipValue;
  String? hipUnit;
  String? activityLevel;
  String? woMode;
  String? woModeSubOption;
  String? woGoal;
  String? lossGainTargetValue;
  String? lossGainTargetUnit;
  String? mealType;
  String? mealTypeSubOption;
  String? mealCategory;
  String? woDays;
  String? woTime;
  String? currentWeightValue;
  String? currentWeightUnit;
  String? foodYouLike;
  String? howFastToReachGoal;
  String? focusMuscle;
  String? currentBodyShape;
  String? desiredBodyShape;
  String? gender;
  String? musclesPopupDone;
  String? planStartsAt;
  String? rewardsPopupDate;
  String? currentMonth;
  String? popupFullBodyMonth;
  String? popupCardioMonth;
  String? popupCustomMuscleMonth;
  String? weightConfirmPopupShownAt;
  String? musclesPopup;
  String? noOfDaysPerWeek;
  String? fitnessGoal;
  String? currentPhase;
  String? durationWeeksPhase1;
  String? durationWeeksPhase2;
  String? moreWeekNeededPhase1;
  String? moreWeekNeededPhase2;
  String? targetWeightPhase1;
  String? targetWeightPhase2;
  String? moreWeekNeeded;
  String? createdAt;
  String? updatedAt;

  UserBodyMetrics({
    this.id,
    this.userId,
    this.idealWeight,
    this.musclesDone,
    this.activePlanId,
    this.initialBmi,
    this.initialBmiCat,
    this.initialBfp,
    this.initialBfpCat,
    this.initialBmr,
    this.currentBmi,
    this.currentBmiCat,
    this.currentBfp,
    this.currentBfpCat,
    this.currentBmr,
    this.currentCaloriesIntake,
    this.targetCaloriesIntake,
    this.targetCaloriesIntakeWeek,
    this.caloriesTargetDayWise,
    this.targetBmi,
    this.targetBmiCat,
    this.targetBfp,
    this.targetBfpCat,
    this.targetBmr,
    this.targetWeightValue,
    this.targetWeightUnit,
    this.weightValue,
    this.weightUnit,
    this.heightValue,
    this.heightUnit,
    this.age,
    this.dobAgeMonth,
    this.dobAgeYear,
    this.neckValue,
    this.neckUnit,
    this.waistValue,
    this.waistUnit,
    this.hipValue,
    this.hipUnit,
    this.activityLevel,
    this.woMode,
    this.woModeSubOption,
    this.woGoal,
    this.lossGainTargetValue,
    this.lossGainTargetUnit,
    this.mealType,
    this.mealTypeSubOption,
    this.mealCategory,
    this.woDays,
    this.woTime,
    this.currentWeightValue,
    this.currentWeightUnit,
    this.foodYouLike,
    this.howFastToReachGoal,
    this.focusMuscle,
    this.currentBodyShape,
    this.desiredBodyShape,
    this.gender,
    this.musclesPopupDone,
    this.planStartsAt,
    this.rewardsPopupDate,
    this.currentMonth,
    this.popupFullBodyMonth,
    this.popupCardioMonth,
    this.popupCustomMuscleMonth,
    this.weightConfirmPopupShownAt,
    this.musclesPopup,
    this.noOfDaysPerWeek,
    this.fitnessGoal,
    this.currentPhase,
    this.durationWeeksPhase1,
    this.durationWeeksPhase2,
    this.moreWeekNeededPhase1,
    this.moreWeekNeededPhase2,
    this.targetWeightPhase1,
    this.targetWeightPhase2,
    this.moreWeekNeeded,
    this.createdAt,
    this.updatedAt,
  });

  factory UserBodyMetrics.fromJson(Map<String, dynamic> json) => UserBodyMetrics(
        id: json['id']?.toString(),
        userId: json['userId']?.toString(),
        idealWeight: json['ideal_weight']?.toString(),
        musclesDone: json['muscles_done']?.toString(),
        activePlanId: json['active_plan_id']?.toString(),
        initialBmi: json['initial_bmi']?.toString(),
        initialBmiCat: json['initial_bmi_cat']?.toString(),
        initialBfp: json['initial_bfp']?.toString(),
        initialBfpCat: json['initial_bfp_cat']?.toString(),
        initialBmr: json['initial_bmr']?.toString(),
        currentBmi: json['current_bmi']?.toString(),
        currentBmiCat: json['current_bmi_cat']?.toString(),
        currentBfp: json['current_bfp']?.toString(),
        currentBfpCat: json['current_bfp_cat']?.toString(),
        currentBmr: json['current_bmr']?.toString(),
        currentCaloriesIntake: json['current_calories_intake']?.toString(),
        targetCaloriesIntake: json['target_calories_intake']?.toString(),
        targetCaloriesIntakeWeek: json['target_calories_intake_week']?.toString(),
        caloriesTargetDayWise: json['calories_target_day_wise']?.toString(),
        targetBmi: json['target_bmi']?.toString(),
        targetBmiCat: json['target_bmi_cat']?.toString(),
        targetBfp: json['target_bfp']?.toString(),
        targetBfpCat: json['target_bfp_cat']?.toString(),
        targetBmr: json['target_bmr']?.toString(),
        targetWeightValue: json['target_weight_value']?.toString(),
        targetWeightUnit: json['target_weight_unit']?.toString(),
        weightValue: json['weight_value']?.toString(),
        weightUnit: json['weight_unit']?.toString(),
        heightValue: json['height_value']?.toString(),
        heightUnit: json['height_unit']?.toString(),
        age: json['age']?.toString(),
        dobAgeMonth: json['dob_age_month']?.toString(),
        dobAgeYear: json['dob_age_year']?.toString(),
        neckValue: json['neck_value']?.toString(),
        neckUnit: json['neck_unit']?.toString(),
        waistValue: json['waist_value']?.toString(),
        waistUnit: json['waist_unit']?.toString(),
        hipValue: json['hip_value']?.toString(),
        hipUnit: json['hip_unit']?.toString(),
        activityLevel: json['activity_level']?.toString(),
        woMode: json['wo_mode']?.toString(),
        woModeSubOption: json['wo_mode_sub_option']?.toString(),
        woGoal: json['wo_goal']?.toString(),
        lossGainTargetValue: json['loss_gain_target_value']?.toString(),
        lossGainTargetUnit: json['loss_gain_target_unit']?.toString(),
        mealType: json['meal_type']?.toString(),
        mealTypeSubOption: json['meal_type_sub_option']?.toString(),
        mealCategory: json['meal_category']?.toString(),
        woDays: json['wo_days']?.toString(),
        woTime: json['wo_time']?.toString(),
        currentWeightValue: json['current_weight_value']?.toString(),
        currentWeightUnit: json['current_weight_unit']?.toString(),
        foodYouLike: json['food_you_like']?.toString(),
        howFastToReachGoal: json['how_fast_to_reach_goal']?.toString(),
        focusMuscle: json['focus_muscle']?.toString(),
        currentBodyShape: json['current_body_shape']?.toString(),
        desiredBodyShape: json['desired_body_shape']?.toString(),
        gender: json['gender']?.toString(),
        musclesPopupDone: json['muscles_popup_done']?.toString(),
        planStartsAt: json['plan_starts_at']?.toString(),
        rewardsPopupDate: json['rewards_popup_date']?.toString(),
        currentMonth: json['current_month']?.toString(),
        popupFullBodyMonth: json['popup_full_body_month']?.toString(),
        popupCardioMonth: json['popup_cardio_month']?.toString(),
        popupCustomMuscleMonth: json['popup_custom_muscle_month']?.toString(),
        weightConfirmPopupShownAt: json['weight_confirm_popup_shown_at']?.toString(),
        musclesPopup: json['muscles_popup']?.toString(),
        noOfDaysPerWeek: json['no_of_days_per_week']?.toString(),
        fitnessGoal: json['fitness_goal']?.toString(),
        currentPhase: json['current_phase']?.toString(),
        durationWeeksPhase1: json['duration_weeks_phase1']?.toString(),
        durationWeeksPhase2: json['duration_weeks_phase2']?.toString(),
        moreWeekNeededPhase1: json['more_week_needed_phase1']?.toString(),
        moreWeekNeededPhase2: json['more_week_needed_phase2']?.toString(),
        targetWeightPhase1: json['target_weight_phase1']?.toString(),
        targetWeightPhase2: json['target_weight_phase2']?.toString(),
        moreWeekNeeded: json['more_week_needed']?.toString(),
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'ideal_weight': idealWeight,
        'muscles_done': musclesDone,
        'active_plan_id': activePlanId,
        'initial_bmi': initialBmi,
        'initial_bmi_cat': initialBmiCat,
        'initial_bfp': initialBfp,
        'initial_bfp_cat': initialBfpCat,
        'initial_bmr': initialBmr,
        'current_bmi': currentBmi,
        'current_bmi_cat': currentBmiCat,
        'current_bfp': currentBfp,
        'current_bfp_cat': currentBfpCat,
        'current_bmr': currentBmr,
        'current_calories_intake': currentCaloriesIntake,
        'target_calories_intake': targetCaloriesIntake,
        'target_calories_intake_week': targetCaloriesIntakeWeek,
        'calories_target_day_wise': caloriesTargetDayWise,
        'target_bmi': targetBmi,
        'target_bmi_cat': targetBmiCat,
        'target_bfp': targetBfp,
        'target_bfp_cat': targetBfpCat,
        'target_bmr': targetBmr,
        'target_weight_value': targetWeightValue,
        'target_weight_unit': targetWeightUnit,
        'weight_value': weightValue,
        'weight_unit': weightUnit,
        'height_value': heightValue,
        'height_unit': heightUnit,
        'age': age,
        'dob_age_month': dobAgeMonth,
        'dob_age_year': dobAgeYear,
        'neck_value': neckValue,
        'neck_unit': neckUnit,
        'waist_value': waistValue,
        'waist_unit': waistUnit,
        'hip_value': hipValue,
        'hip_unit': hipUnit,
        'activity_level': activityLevel,
        'wo_mode': woMode,
        'wo_mode_sub_option': woModeSubOption,
        'wo_goal': woGoal,
        'loss_gain_target_value': lossGainTargetValue,
        'loss_gain_target_unit': lossGainTargetUnit,
        'meal_type': mealType,
        'meal_type_sub_option': mealTypeSubOption,
        'meal_category': mealCategory,
        'wo_days': woDays,
        'wo_time': woTime,
        'current_weight_value': currentWeightValue,
        'current_weight_unit': currentWeightUnit,
        'food_you_like': foodYouLike,
        'how_fast_to_reach_goal': howFastToReachGoal,
        'focus_muscle': focusMuscle,
        'current_body_shape': currentBodyShape,
        'desired_body_shape': desiredBodyShape,
        'gender': gender,
        'muscles_popup_done': musclesPopupDone,
        'plan_starts_at': planStartsAt,
        'rewards_popup_date': rewardsPopupDate,
        'current_month': currentMonth,
        'popup_full_body_month': popupFullBodyMonth,
        'popup_cardio_month': popupCardioMonth,
        'popup_custom_muscle_month': popupCustomMuscleMonth,
        'weight_confirm_popup_shown_at': weightConfirmPopupShownAt,
        'muscles_popup': musclesPopup,
        'no_of_days_per_week': noOfDaysPerWeek,
        'fitness_goal': fitnessGoal,
        'current_phase': currentPhase,
        'duration_weeks_phase1': durationWeeksPhase1,
        'duration_weeks_phase2': durationWeeksPhase2,
        'more_week_needed_phase1': moreWeekNeededPhase1,
        'more_week_needed_phase2': moreWeekNeededPhase2,
        'target_weight_phase1': targetWeightPhase1,
        'target_weight_phase2': targetWeightPhase2,
        'more_week_needed': moreWeekNeeded,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
