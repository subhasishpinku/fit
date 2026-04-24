class FullBodyPlanModel {
  final bool success;
  final String message;
  final FullBodyData data;

  FullBodyPlanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FullBodyPlanModel.fromJson(Map<String, dynamic> json) {
    return FullBodyPlanModel(
      success: json['success'],
      message: json['message'],
      data: FullBodyData.fromJson(json['data']),
    );
  }
}

class FullBodyData {
  final String title;
  final List<WorkoutDay> days;

  FullBodyData({
    required this.title,
    required this.days,
  });

  factory FullBodyData.fromJson(Map<String, dynamic> json) {
    return FullBodyData(
      title: json['title'],
      days: (json['days'] as List)
          .map((day) => WorkoutDay.fromJson(day))
          .toList(),
    );
  }
}

class WorkoutDay {
  final String label;
  final String day;

  WorkoutDay({
    required this.label,
    required this.day,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      label: json['label'],
      day: json['day'],
    );
  }
}
