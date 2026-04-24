// model/pre_register_model.dart

class PreRegisterDetail {
  final bool success;
  final String message;
  final PreRegisterData? data;

  PreRegisterDetail({
    required this.success,
    required this.message,
    this.data,
  });

  factory PreRegisterDetail.fromJson(Map<String, dynamic> json) {
    return PreRegisterDetail(
      success: json['success'] == true,
      message: json['message'] ?? '',
      data: json['data'] != null ? PreRegisterData.fromJson(json['data']) : null,
    );
  }
}

class PreRegisterData {
  final String planType;
  final String weightValue;
  final String gender;
  final String dobAgeYear;
  final String heightValue;
  final int woTime;
  final String targetBfp;
  final String currentBfp;
  final String activityLevel;
  final String howFastToReachGoal;
  final Map<String, dynamic> extras;

  PreRegisterData({
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
    required this.extras,
  });

  factory PreRegisterData.fromJson(Map<String, dynamic> json) {
    return PreRegisterData(
      planType: json['plan_type']?.toString() ?? '',
      weightValue: json['weight_value']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      dobAgeYear: json['dob_age_year']?.toString() ?? '',
      heightValue: json['height_value']?.toString() ?? '',
      woTime: (json['wo_time'] is int)
          ? json['wo_time']
          : int.tryParse(json['wo_time']?.toString() ?? '0') ?? 0,
      targetBfp: json['target_bfp']?.toString() ?? '',
      currentBfp: json['current_bfp']?.toString() ?? '',
      activityLevel: json['activity_level']?.toString() ?? '',
      howFastToReachGoal: json['how_fast_to_reach_goal']?.toString() ?? '',
      extras: Map<String, dynamic>.from(json)..removeWhere(
        (k, _) => _coreKeys.contains(k),
      ),
    );
  }

  static const _coreKeys = [
    'plan_type',
    'weight_value',
    'gender',
    'dob_age_year',
    'height_value',
    'wo_time',
    'target_bfp',
    'current_bfp',
    'activity_level',
    'how_fast_to_reach_goal',
  ];
}
