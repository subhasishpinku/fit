class NewsItem {
  final int id;
  final String title;
  final String description;
  final String vimeoLink;
  final String categoryTitle;
  final String createdAt;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.vimeoLink,
    required this.categoryTitle,
    required this.createdAt,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      vimeoLink: json['vimeo_link'] ?? '',
      categoryTitle: json['category_title'] ?? '',
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  // Formatted date getter with better error handling
  String get createdAtFormatted {
    try {
      if (createdAt.isEmpty) return 'Recent';
      final date = DateTime.parse(createdAt);
      return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    } catch (e) {
      print("Date parsing error for: $createdAt");
      return 'Recent';
    }
  }
}