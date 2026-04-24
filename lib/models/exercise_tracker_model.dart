class ExerciseTrackerModel {
  final int id;
  final String exerciseName;
  final SetItem set1;
  final SetItem set2;
  final SetItem set3;
  final String createdAt;

  ExerciseTrackerModel({
    required this.id,
    required this.exerciseName,
    required this.set1,
    required this.set2,
    required this.set3,
    required this.createdAt,
  });

  factory ExerciseTrackerModel.fromJson(Map<String, dynamic> json) {
    return ExerciseTrackerModel(
      id: json['id'],
      exerciseName: json['exercise_name'],
      set1: SetItem.fromJson(json['set_1']),
      set2: SetItem.fromJson(json['set_2']),
      set3: SetItem.fromJson(json['set_3']),
      createdAt: json['created_at'],
    );
  }
}

class SetItem {
  final int reps;
  final int weight;

  SetItem({required this.reps, required this.weight});

  factory SetItem.fromJson(Map<String, dynamic> json) {
    return SetItem(
      reps: json['reps'],
      weight: json['weight'],
    );
  }
}
