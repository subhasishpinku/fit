class RegisterRequestModel {
  String? name;
  String? hip;
  int? noOfDaysPerWeek;
  String? woTime;
  String? password;
  String? email;
  String? fitnessGoal;
  String? currentBfp;

  String? grains;
  String? fruits;
  String? carbs;
  String? vegetables;
  String? nuts;
  String? proteins;
  String? fats;
  String? fibers;
  String? focusMuscle;
  String? woDays;

  String? waist;
  String? planType;
  String? currentBodyShape;
  String? heightUnit;
  String? desiredBodyShape;
  String? woModeSubOption;
  String? targetBfp;
  String? currentWeightValue;

  String? activityLevel;
  String? hipUnit;
  String? waistUnit;
  String? dobAgeMonth;
  String? woGoal;
  String? deviceId;
  String? woMode;

  String? skeletalMuscle;
  String? subcutaneousFatPercentage;
  String? dobAgeYear;
  String? heightValue;
  String? howFastToReachGoal;
  String? visceralFat;
  String? waterWeight;
  String? currentWeightUnit;
  String? lossGainTargetValue;
  String? gender;
  String? mealTypeSubOption;
  String? mealType;

  RegisterRequestModel({
    this.name,
    this.hip,
    this.noOfDaysPerWeek,
    this.woTime,
    this.password,
    this.email,
    this.fitnessGoal,
    this.currentBfp,
    this.grains,
    this.fruits,
    this.carbs,
    this.vegetables,
    this.nuts,
    this.proteins,
    this.fats,
    this.fibers,
    this.focusMuscle,
    this.woDays,
    this.waist,
    this.planType,
    this.currentBodyShape,
    this.heightUnit,
    this.desiredBodyShape,
    this.woModeSubOption,
    this.targetBfp,
    this.currentWeightValue,
    this.activityLevel,
    this.hipUnit,
    this.waistUnit,
    this.dobAgeMonth,
    this.woGoal,
    this.deviceId,
    this.woMode,
    this.skeletalMuscle,
    this.subcutaneousFatPercentage,
    this.dobAgeYear,
    this.heightValue,
    this.howFastToReachGoal,
    this.visceralFat,
    this.waterWeight,
    this.currentWeightUnit,
    this.lossGainTargetValue,
    this.gender,
    this.mealTypeSubOption,
    this.mealType,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "hip": hip,
    "no_of_days_per_week": noOfDaysPerWeek,
    "wo_time": woTime,
    "password": password,
    "email": email,
    "fitness_goal": fitnessGoal,
    "current_bfp": currentBfp,

    "grains": grains,
    "fruits": fruits,
    "carbs": carbs,
    "vegetables": vegetables,
    "nuts": nuts,
    "proteins": proteins,
    "fats": fats,
    "fibers": fibers,
    "focus_muscle": focusMuscle,
    "wo_days": woDays,

    "waist": waist,
    "plan_type": planType,
    "current_body_shape": currentBodyShape,
    "height_unit": heightUnit,
    "desired_body_shape": desiredBodyShape,
    "wo_mode_sub_option": woModeSubOption,
    "target_bfp": targetBfp,
    "current_weight_value": currentWeightValue,

    "activity_level": activityLevel,
    "hip_unit": hipUnit,
    "waist_unit": waistUnit,
    "dob_age_month": dobAgeMonth,
    "wo_goal": woGoal,
    "device_id": deviceId,
    "wo_mode": woMode,

    "skeletal_muscle": skeletalMuscle,
    "subcutaneous_fat_percentage": subcutaneousFatPercentage,
    "dob_age_year": dobAgeYear,
    "height_value": heightValue,
    "how_fast_to_reach_goal": howFastToReachGoal,
    "visceral_fat": visceralFat,
    "water_weight": waterWeight,
    "current_weight_unit": currentWeightUnit,
    "loss_gain_target_value": lossGainTargetValue,
    "gender": gender,
    "meal_type_sub_option": mealTypeSubOption,
    "meal_type": mealType,
  };
}
