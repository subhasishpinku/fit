class NewsItem {
  final int id;
  final String title;
  final String description;
  final String vimeoLink;
  final String categoryTitle;
  final String createdAt; // <-- ADD THIS

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.vimeoLink,
    required this.categoryTitle,
    required this.createdAt, // <-- ADD THIS
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      vimeoLink: json['vimeo_link'],
      categoryTitle: json['category_title'],
      createdAt: json['created_at'] ?? "", // <-- ADD THIS
    );
  }

  // ----------------------------------
  // FORMATTED DATE GETTER (NOW WORKS)
  // ----------------------------------
  String get createdAtFormatted {
    try {
      final date = DateTime.parse(createdAt);
      return "${date.day}-${date.month}-${date.year}";
    } catch (_) {
      return createdAt;
    }
  }
}
