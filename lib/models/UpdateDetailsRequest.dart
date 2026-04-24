class UpdateDetailsRequest {
  final bool? status;
  final String? message;
  final Data? data;

  UpdateDetailsRequest({this.status, this.message, this.data});

  factory UpdateDetailsRequest.fromJson(Map<String, dynamic> json) {
    return UpdateDetailsRequest(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

class Data {
  final UserDetails? userDetails;
  final UserBodyMetrics? userBodyMetrics;

  Data({this.userDetails, this.userBodyMetrics});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userDetails: json['user_details'] != null
          ? UserDetails.fromJson(json['user_details'])
          : null,
      userBodyMetrics: json['user_body_metrics'] != null
          ? UserBodyMetrics.fromJson(json['user_body_metrics'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (userDetails != null) 'user_details': userDetails!.toJson(),
        if (userBodyMetrics != null) 'user_body_metrics': userBodyMetrics!.toJson(),
      };
}

class UserDetails {
  final int? id;
  final String? userType;
  final String? deviceId;
  final String? username;
  final String? name;
  final String? email;
  final String? gender;
  final String? image;
  final String? birthYear;
  final String? otp;
  final dynamic token;
  final int? active;
  final int? winnerStatus;
  final String? lastLoginAt;
  final String? deviceType;
  final String? appType;
  final String? caloriesCronDone;
  final String? createdAt;
  final String? updatedAt;
  final String? imageFullUrl;
  final ShowWarningPopup? showWarningPopup;
  final int? noOfDaysRegistered;
  final bool? winner;
  final int? currentMonthCoinsCount;

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

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      userType: json['user_type'],
      deviceId: json['device_id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      image: json['image'],
      birthYear: json['birth_year'],
      otp: json['otp'],
      token: json['token'],
      active: json['active'],
      winnerStatus: json['winner_status'],
      lastLoginAt: json['last_login_at'],
      deviceType: json['device_type'],
      appType: json['app_type'],
      caloriesCronDone: json['calories_cron_done'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageFullUrl: json['image_full_url'],
      showWarningPopup: json['show_warning_popup'] != null
          ? ShowWarningPopup.fromJson(json['show_warning_popup'])
          : null,
      noOfDaysRegistered: json['no_of_days_registered'],
      winner: json['winner'],
      currentMonthCoinsCount: json['current_month_coins_count'],
    );
  }

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
  final bool? show;
  final String? warningLabel;

  ShowWarningPopup({this.show, this.warningLabel});

  factory ShowWarningPopup.fromJson(Map<String, dynamic> json) {
    return ShowWarningPopup(
      show: json['show'],
      warningLabel: json['warning_label'],
    );
  }

  Map<String, dynamic> toJson() => {
        'show': show,
        'warning_label': warningLabel,
      };
}

class UserBodyMetrics {
  final int? id;
  final String? userId;
  final String? idealWeight;
  final String? musclesDone;
  final int? activePlanId;
  final dynamic initialBmi;
  final String? initialBmiCat;
  final dynamic initialBfp;
  final String? initialBfpCat;
  final dynamic initialBmr;
  final dynamic currentBmi;
  final String? currentBmiCat;
  final dynamic currentBfp;
  final String? currentBfpCat;
  final dynamic currentBmr;
  final dynamic currentCaloriesIntake;
  final dynamic targetCaloriesIntake;
  final dynamic targetCaloriesIntakeWeek;
  final String? caloriesTargetDayWise;
  final dynamic targetBmi;
  final String? targetBmiCat;
  final dynamic targetBfp;
  final String? targetBfpCat;
  final dynamic targetBmr;
  final dynamic targetWeightValue;
  final String? targetWeightUnit;
  final dynamic weightValue;
  final String? weightUnit;
  final String? heightValue;
  final String? heightUnit;

  // … Keeping the rest unchanged (too long)

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
  });

  factory UserBodyMetrics.fromJson(Map<String, dynamic> json) {
    return UserBodyMetrics(
      id: json['id'],
      userId: json['userId'],
      idealWeight: json['ideal_weight'],
      musclesDone: json['muscles_done'],
      activePlanId: json['active_plan_id'],
      initialBmi: json['initial_bmi'],
      initialBmiCat: json['initial_bmi_cat'],
      initialBfp: json['initial_bfp'],
      initialBfpCat: json['initial_bfp_cat'],
      initialBmr: json['initial_bmr'],
      currentBmi: json['current_bmi'],
      currentBmiCat: json['current_bmi_cat'],
      currentBfp: json['current_bfp'],
      currentBfpCat: json['current_bfp_cat'],
      currentBmr: json['current_bmr'],
      currentCaloriesIntake: json['current_calories_intake'],
      targetCaloriesIntake: json['target_calories_intake'],
      targetCaloriesIntakeWeek: json['target_calories_intake_week'],
      caloriesTargetDayWise: json['calories_target_day_wise'],
      targetBmi: json['target_bmi'],
      targetBmiCat: json['target_bmi_cat'],
      targetBfp: json['target_bfp'],
      targetBfpCat: json['target_bfp_cat'],
      targetBmr: json['target_bmr'],
      targetWeightValue: json['target_weight_value'],
      targetWeightUnit: json['target_weight_unit'],
      weightValue: json['weight_value'],
      weightUnit: json['weight_unit'],
      heightValue: json['height_value'],
      heightUnit: json['height_unit'],
    );
  }

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
      };
}
