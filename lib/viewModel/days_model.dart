class DaysModel {
  final List<int> workoutDays;
  final List<int> nonWorkoutDays;

  DaysModel({required this.workoutDays, required this.nonWorkoutDays});

  factory DaysModel.fromJson(Map<String, dynamic> json) {
    List<int> workout = [];
    List<int> nonWorkout = [];

    if (json["workout_days"] != null) {
      workout = List<int>.from(json["workout_days"].map((e) => e["day"]));
    }

    if (json["non_workout_days"] != null) {
      nonWorkout = List<int>.from(json["non_workout_days"].map((e) => e["day"]));
    }

    return DaysModel(
      workoutDays: workout,
      nonWorkoutDays: nonWorkout,
    );
  }
}
