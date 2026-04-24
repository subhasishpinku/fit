class WrongDietModel {
  final int id;
  final int userId;
  final String description;
  final String week;
  final String day;
  final String createdAtHuman;
  final String createdAtDate;

  WrongDietModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.week,
    required this.day,
    required this.createdAtHuman,
    required this.createdAtDate,
  });

  factory WrongDietModel.fromJson(Map<String, dynamic> json) {
    return WrongDietModel(
      id: json["id"],
      userId: json["user_id"],
      description: json["description"],
      week: json["week"].toString(),
      day: json["day"].toString(),
      createdAtHuman: json["created_at_human"] ?? "",
      createdAtDate: json["created_at_date"] ?? "",
    );
  }
}
