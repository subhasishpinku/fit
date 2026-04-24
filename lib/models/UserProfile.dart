import 'dart:convert';

class UserProfile {
  final int woTime; // in minutes
  final String woMode;
  final double currentBfp;
  final String? activityLevel;
  final String fitnessGoal;
  final int userId;
  final String deviceId;
  final int dobAgeMonth;
  final String heightUnit;
  final String currentWeightUnit;
  final double heightValue;
  final double targetBfp;
  final String mealType;
  final int dobAgeYear;
  final int noOfDaysPerWeek;
  final String gender;
  final double currentWeightValue;

  UserProfile({
    required this.woTime,
    required this.woMode,
    required this.currentBfp,
    this.activityLevel,
    required this.fitnessGoal,
    required this.userId,
    required this.deviceId,
    required this.dobAgeMonth,
    required this.heightUnit,
    required this.currentWeightUnit,
    required this.heightValue,
    required this.targetBfp,
    required this.mealType,
    required this.dobAgeYear,
    required this.noOfDaysPerWeek,
    required this.gender,
    required this.currentWeightValue,
  });

  // Factory from Map (handles numeric values provided as strings)
  factory UserProfile.fromJson(Map<String, dynamic> map) {
    int parseInt(dynamic v, {int fallback = 0}) {
      if (v == null) return fallback;
      if (v is int) return v;
      if (v is double) return v.toInt();
      if (v is String) {
        return int.tryParse(v) ?? double.tryParse(v)?.toInt() ?? fallback;
      }
      return fallback;
    }

    double parseDouble(dynamic v, {double fallback = 0.0}) {
      if (v == null) return fallback;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? fallback;
      return fallback;
    }

    String? parseString(dynamic v) {
      if (v == null) return null;
      return v.toString();
    }

    return UserProfile(
      woTime: parseInt(map['wo_time'], fallback: 0),
      woMode: parseString(map['wo_mode']) ?? '',
      currentBfp: parseDouble(map['current_bfp'], fallback: 0.0),
      activityLevel: parseString(map['activity_level']),
      fitnessGoal: parseString(map['fitness_goal']) ?? '',
      userId: parseInt(map['user_id']),
      deviceId: parseString(map['device_id']) ?? '',
      dobAgeMonth: parseInt(map['dob_age_month']),
      heightUnit: parseString(map['height_unit']) ?? '',
      currentWeightUnit: parseString(map['current_weight_unit']) ?? '',
      heightValue: parseDouble(map['height_value'], fallback: 0.0),
      targetBfp: parseDouble(map['target_bfp'], fallback: 0.0),
      mealType: parseString(map['meal_type']) ?? '',
      dobAgeYear: parseInt(map['dob_age_year']),
      noOfDaysPerWeek: parseInt(map['no_of_days_per_week']),
      gender: parseString(map['gender']) ?? '',
      currentWeightValue:
          parseDouble(map['current_weight_value'], fallback: 0.0),
    );
  }

  // Convert back to Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'wo_time': woTime.toString(),
      'wo_mode': woMode,
      'current_bfp': currentBfp.toString(),
      'activity_level': activityLevel ?? '',
      'fitness_goal': fitnessGoal,
      'user_id': userId.toString(),
      'device_id': deviceId,
      'dob_age_month': dobAgeMonth.toString(),
      'height_unit': heightUnit,
      'current_weight_unit': currentWeightUnit,
      'height_value': heightValue.toString(),
      'target_bfp': targetBfp.toString(),
      'meal_type': mealType,
      'dob_age_year': dobAgeYear.toString(),
      'no_of_days_per_week': noOfDaysPerWeek.toString(),
      'gender': gender,
      'current_weight_value': currentWeightValue.toString(),
    };
  }

  // Optional: return a JSON string
  String toJsonString() => json.encode(toJson());

  // copyWith for immutability convenience
  UserProfile copyWith({
    int? woTime,
    String? woMode,
    double? currentBfp,
    String? activityLevel,
    String? fitnessGoal,
    int? userId,
    String? deviceId,
    int? dobAgeMonth,
    String? heightUnit,
    String? currentWeightUnit,
    double? heightValue,
    double? targetBfp,
    String? mealType,
    int? dobAgeYear,
    int? noOfDaysPerWeek,
    String? gender,
    double? currentWeightValue,
  }) {
    return UserProfile(
      woTime: woTime ?? this.woTime,
      woMode: woMode ?? this.woMode,
      currentBfp: currentBfp ?? this.currentBfp,
      activityLevel: activityLevel ?? this.activityLevel,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      dobAgeMonth: dobAgeMonth ?? this.dobAgeMonth,
      heightUnit: heightUnit ?? this.heightUnit,
      currentWeightUnit: currentWeightUnit ?? this.currentWeightUnit,
      heightValue: heightValue ?? this.heightValue,
      targetBfp: targetBfp ?? this.targetBfp,
      mealType: mealType ?? this.mealType,
      dobAgeYear: dobAgeYear ?? this.dobAgeYear,
      noOfDaysPerWeek: noOfDaysPerWeek ?? this.noOfDaysPerWeek,
      gender: gender ?? this.gender,
      currentWeightValue: currentWeightValue ?? this.currentWeightValue,
    );
  }

  @override
  String toString() {
    return 'UserProfile(woTime: $woTime, woMode: $woMode, currentBfp: $currentBfp, activityLevel: $activityLevel, fitnessGoal: $fitnessGoal, userId: $userId, deviceId: $deviceId, dobAgeMonth: $dobAgeMonth, heightUnit: $heightUnit, heightValue: $heightValue, targetBfp: $targetBfp, mealType: $mealType, dobAgeYear: $dobAgeYear, noOfDaysPerWeek: $noOfDaysPerWeek, gender: $gender, currentWeightValue: $currentWeightValue)';
  }
}
