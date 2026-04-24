class NewsCategoryResponse {
  final bool success;
  final String message;
  final List<NewsCategory> data;

  NewsCategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NewsCategoryResponse.fromJson(Map<String, dynamic> json) {
    return NewsCategoryResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>)
          .map((e) => NewsCategory.fromJson(e))
          .toList(),
    );
  }
}

class NewsCategory {
  final int id;
  final String title;
  final String? titleEs;
  final String? type;
  final String? appType;
  final int? parentId;
  final String? createdAt;
  final String? updatedAt;
  final String? createdAtFormatted;

  NewsCategory({
    required this.id,
    required this.title,
    this.titleEs,
    this.type,
    this.appType,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.createdAtFormatted,
  });

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      titleEs: json["title_es"],
      type: json["type"],
      appType: json["app_type"],
      parentId: json["parent_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      createdAtFormatted: json["created_at_formatted"],
    );
  }
}
