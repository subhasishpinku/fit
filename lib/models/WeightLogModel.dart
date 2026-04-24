class WeightLogModel {
  final int id;
  final String userId;
  final String week;
  final String day;
  final String logType;
  final String logValue;
  final String logDate;
  final String createdAtFormatted;

  WeightLogModel({
    required this.id,
    required this.userId,
    required this.week,
    required this.day,
    required this.logType,
    required this.logValue,
    required this.logDate,
    required this.createdAtFormatted,
  });

  factory WeightLogModel.fromJson(Map<String, dynamic> json) {
    return WeightLogModel(
      id: json['id'],
      userId: json['user_id'],
      week: json['week'],
      day: json['day'],
      logType: json['log_type'],
      logValue: json['log_value'],
      logDate: json['log_date'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}
