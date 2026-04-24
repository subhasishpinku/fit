import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool? success;
  String? message;
  String? token;
  Data? data;

  LoginResponseModel({this.success, this.message, this.token, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  UserDetails? userDetails;
  DayDetails? dayDetails;

  Data({this.userDetails, this.dayDetails});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: json["user_details"] != null
            ? UserDetails.fromJson(json["user_details"])
            : null,
        dayDetails: json["day_details"] != null
            ? DayDetails.fromJson(json["day_details"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "user_details": userDetails?.toJson(),
        "day_details": dayDetails?.toJson(),
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
  dynamic token;
  int? active;
  int? winnerStatus;
  dynamic lastLoginAt;
  dynamic deviceType;
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
        showWarningPopup: json["show_warning_popup"] != null
            ? ShowWarningPopup.fromJson(json["show_warning_popup"])
            : null,
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

class ShowWarningPopup {
  bool? show;
  String? warningLabel;

  ShowWarningPopup({this.show, this.warningLabel});

  factory ShowWarningPopup.fromJson(Map<String, dynamic> json) =>
      ShowWarningPopup(
        show: json["show"],
        warningLabel: json["warning_label"],
      );

  Map<String, dynamic> toJson() => {
        "show": show,
        "warning_label": warningLabel,
      };
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
        weekRange: json["week_range"] != null
            ? List<String>.from(json["week_range"])
            : [],
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
