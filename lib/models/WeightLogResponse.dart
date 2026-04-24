class WeightLogResponse {
  final bool success;
  final String message;
  final String? minValueForWeek;

  WeightLogResponse({
    required this.success,
    required this.message,
    this.minValueForWeek,
  });

  factory WeightLogResponse.fromJson(Map<String, dynamic> json) {
    return WeightLogResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      minValueForWeek: json['data']?['min_value_for_week'],
    );
  }
}
