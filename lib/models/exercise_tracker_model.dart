class ExerciseTrackerModel {
  final int id;
  final String exerciseName;
  final SetItem? set1;
  final SetItem? set2;
  final SetItem? set3;
  final String createdAt;

  ExerciseTrackerModel({
    required this.id,
    required this.exerciseName,
    this.set1,
    this.set2,
    this.set3,
    required this.createdAt,
  });

  factory ExerciseTrackerModel.fromJson(Map<String, dynamic> json) {
    return ExerciseTrackerModel(
      id: json['id'] ?? 0,
      exerciseName: json['exercise_name'] ?? '',
      set1: json['set_1'] != null ? SetItem.fromJson(json['set_1']) : null,
      set2: json['set_2'] != null ? SetItem.fromJson(json['set_2']) : null,
      set3: json['set_3'] != null ? SetItem.fromJson(json['set_3']) : null,
      createdAt: json['created_at'] ?? '',
    );
  }
}

class SetItem {
  final int? reps;
  final int? weight;

  SetItem({this.reps, this.weight});

  // factory SetItem.fromJson(Map<String, dynamic> json) {
  //   return SetItem(
  //     reps: json['reps'],
  //     weight: json['weight'],
  //   );
  // }
  factory SetItem.fromJson(Map<String, dynamic> json) {
    return SetItem(reps: json['reps'] ?? 0, weight: json['weight'] ?? 0);
  }
}
