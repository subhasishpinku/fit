class SupplementModel {
  final int id;
  final String name;
  final String rawItem;
  final String? image;

  final String? description;
  final String? bestTime;
  final String? howToTake;
  final String? note;
  final String? category;

  SupplementModel({
    required this.id,
    required this.name,
    required this.rawItem,
    this.image,
    this.description,
    this.bestTime,
    this.howToTake,
    this.note,
    this.category,
  });

  factory SupplementModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl;

    if (json["media_decoded"] != null &&
        json["media_decoded"].isNotEmpty) {
      imageUrl = json["media_decoded"][0]["url"];
    }

    return SupplementModel(
      id: json["id"],
      name: json["name"],
      rawItem: json["raw_item"],
      image: imageUrl,
      description: json["description"],
      bestTime: json["best_time"],
      howToTake: json["how_to_take"],
      note: json["note"],
      category: json["sub_category"], // ✅ FIXED
    );
  }
}