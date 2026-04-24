class WalkingStepsModel {
  final int userId;
  final String walkingStep;
  final String caloriesBurn;

  WalkingStepsModel({
    required this.userId,
    required this.walkingStep,
    required this.caloriesBurn,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "walking_step": walkingStep,
      "calories_burn": caloriesBurn,
    };
  }
}
