class RegisterResponse {
  bool? success;
  String? message;
  String? token;
  Data? data;

  RegisterResponse({this.success, this.message, this.token, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  UserDetails? userDetails;
  DayDetails? dayDetails;

  Data({this.userDetails, this.dayDetails});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userDetails: json['user_details'] != null
          ? UserDetails.fromJson(json['user_details'])
          : null,
      dayDetails: json['day_details'] != null
          ? DayDetails.fromJson(json['day_details'])
          : null,
    );
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
      image: json['image'] ?? "",
      birthYear: json['birth_year'],
      otp: json['otp'],
      token: json['token'], // API returns null sometimes
      active: json['active'],
    );
  }
}

class DayDetails {
  String? day;
  int? dayId;
  int? mealPlanDayId;
  int? workoutDayNumber;
  String? dayName;

  DayDetails({
    this.day,
    this.dayId,
    this.mealPlanDayId,
    this.workoutDayNumber,
    this.dayName,
  });

  factory DayDetails.fromJson(Map<String, dynamic> json) {
    return DayDetails(
      day: json['day'],
      dayId: json['day_id'],
      mealPlanDayId: json['meal_plan_day_id'],
      workoutDayNumber: json['workout_day_number'],
      dayName: json['day_name'],
    );
  }
}
