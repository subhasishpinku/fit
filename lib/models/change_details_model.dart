class ChangeDetailsModel {
  String height;
  String weight;
  String fitnessGoal;
  String activityLevel;
  String currentBodyFat;
  String targetBodyFat;
  String workoutDays;
  String workoutMode;
  String dietType;

  ChangeDetailsModel({
    this.height = "150 CM",
    this.weight = "60 KG",
    this.fitnessGoal = "Strength Training",
    this.activityLevel = "Moderate",
    this.currentBodyFat = "40%",
    this.targetBodyFat = "9%",
    this.workoutDays = "1 Day / Week (6 days rest)",
    this.workoutMode = "Gym",
    this.dietType = "Non Veg",
  });
}
