// wrong_diet_history_model.dart

class WrongDietHistoryModel {
  final bool success;
  final String message;
  final List<WrongDietItem> data;

  WrongDietHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WrongDietHistoryModel.fromJson(Map<String, dynamic> json) {
    return WrongDietHistoryModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null
          ? List<WrongDietItem>.from(
              json["data"].map((x) => WrongDietItem.fromJson(x)))
          : [],
    );
  }
}

class WrongDietItem {
  final int id;
  final String userId;
  final String week;
  final String day;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String createdAtHuman;
  final String createdAtDate;

  WrongDietItem({
    required this.id,
    required this.userId,
    required this.week,
    required this.day,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtHuman,
    required this.createdAtDate,
  });

  factory WrongDietItem.fromJson(Map<String, dynamic> json) {
    return WrongDietItem(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? "",
      week: json["week"] ?? "",
      day: json["day"] ?? "",
      description: json["description"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      createdAtHuman: json["created_at_human"] ?? "",
      createdAtDate: json["created_at_date"] ?? "",
    );
  }
}
