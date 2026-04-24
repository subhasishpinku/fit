class LoginResponse {
  bool? success;
  String? message;
  String? token;
  Data? data;

  LoginResponse({this.success, this.message, this.token, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  UserDetails? userDetails;
  DayDetails? dayDetails;

  Data({this.userDetails, this.dayDetails});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    dayDetails = json['day_details'] != null
        ? DayDetails.fromJson(json['day_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userDetails != null) data['user_details'] = userDetails!.toJson();
    if (dayDetails != null) data['day_details'] = dayDetails!.toJson();
    return data;
  }
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
  String? token;
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

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    deviceId = json['device_id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    birthYear = json['birth_year'];
    otp = json['otp'];
    token = json['token'];
    active = json['active'];
    winnerStatus = json['winner_status'];
    lastLoginAt = json['last_login_at'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    caloriesCronDone = json['calories_cron_done'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageFullUrl = json['image_full_url'];
    showWarningPopup = json['show_warning_popup'] != null
        ? ShowWarningPopup.fromJson(json['show_warning_popup'])
        : null;
    noOfDaysRegistered = json['no_of_days_registered'];
    winner = json['winner'];
    currentMonthCoinsCount = json['current_month_coins_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_type'] = userType;
    data['device_id'] = deviceId;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['image'] = image;
    data['birth_year'] = birthYear;
    data['otp'] = otp;
    data['token'] = token;
    data['active'] = active;
    data['winner_status'] = winnerStatus;
    data['last_login_at'] = lastLoginAt;
    data['device_type'] = deviceType;
    data['app_type'] = appType;
    data['calories_cron_done'] = caloriesCronDone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_full_url'] = imageFullUrl;
    if (showWarningPopup != null) {
      data['show_warning_popup'] = showWarningPopup!.toJson();
    }
    data['no_of_days_registered'] = noOfDaysRegistered;
    data['winner'] = winner;
    data['current_month_coins_count'] = currentMonthCoinsCount;
    return data;
  }
}

class ShowWarningPopup {
  bool? show;
  String? warningLabel;

  ShowWarningPopup({this.show, this.warningLabel});

  ShowWarningPopup.fromJson(Map<String, dynamic> json) {
    show = json['show'];
    warningLabel = json['warning_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['show'] = show;
    data['warning_label'] = warningLabel;
    return data;
  }
}

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

  DayDetails.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    dayId = json['day_id'];
    mealPlanDayId = json['meal_plan_day_id'];
    workoutDayNumber = json['workout_day_number'];
    dayName = json['day_name'];
    previousDayWorkoutStatus = json['previous_day_workout_status'];
    previousDayWorkoutStatusEs = json['previous_day_workout_status_es'];
    targetWeightFormatted = json['target_weight_formatted'];
    targetWeight = json['target_weight'];
    targetWeightUnit = json['target_weight_unit'];
    currentHeightFormatted = json['current_height_formatted'];
    currentHeight = json['current_height'];
    currentHeightUnit = json['current_height_unit'];

    // Safe parsing for weekRange
    if (json['week_range'] is List) {
      weekRange = List<String>.from(json['week_range']);
    }

    weekNumber = json['week_number'];
    week = json['week'];
    weekFormatted = json['week_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['day'] = day;
    data['day_id'] = dayId;
    data['meal_plan_day_id'] = mealPlanDayId;
    data['workout_day_number'] = workoutDayNumber;
    data['day_name'] = dayName;
    data['previous_day_workout_status'] = previousDayWorkoutStatus;
    data['previous_day_workout_status_es'] = previousDayWorkoutStatusEs;
    data['target_weight_formatted'] = targetWeightFormatted;
    data['target_weight'] = targetWeight;
    data['target_weight_unit'] = targetWeightUnit;
    data['current_height_formatted'] = currentHeightFormatted;
    data['current_height'] = currentHeight;
    data['current_height_unit'] = currentHeightUnit;
    data['week_range'] = weekRange;
    data['week_number'] = weekNumber;
    data['week'] = week;
    data['week_formatted'] = weekFormatted;
    return data;
  }
}
