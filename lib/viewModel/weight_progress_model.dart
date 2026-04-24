class WeightProgressResponse {
  final bool success;
  final String message;
  final List<WeightProgressData> data;

  WeightProgressResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WeightProgressResponse.fromJson(Map<String, dynamic> json) {
    return WeightProgressResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>? ?? [])
          .map((item) => WeightProgressData.fromJson(item))
          .toList(),
    );
  }
}

class WeightProgressData {
  final int id;
  final int userId;
  final String progressImage;
  final String createdAt;
  final String updatedAt;
  final String progressImageUrl;

  WeightProgressData({
    required this.id,
    required this.userId,
    required this.progressImage,
    required this.createdAt,
    required this.updatedAt,
    required this.progressImageUrl,
  });

  factory WeightProgressData.fromJson(Map<String, dynamic> json) {
    return WeightProgressData(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      progressImage: json["progress_image"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      progressImageUrl: json["progress_image_url"] ?? "",
    );
  }
}
