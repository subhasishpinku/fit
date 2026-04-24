import 'dart:convert';

class FoodModel {
  final int id;
  final String name;
  final String rawItem;
  final String type;
  final String classification;
  final String image;
  final String description;

  final String category;
  final String goal;
  final String time;

  final String carbs;
  final String fat;
  final String protein;
  final String fiber;
  final String calories;
  final String lysine;

  final String quantityUnit;
  final String quantityLimit;
  final String quantityUnitDisplay;

  final String fixedQuantity;
  final String mealTypeSubOption;

  FoodModel({
    required this.id,
    required this.name,
    required this.rawItem,
    required this.type,
    required this.classification,
    required this.image,
    required this.description,

    required this.category,
    required this.goal,
    required this.time,

    required this.carbs,
    required this.fat,
    required this.protein,
    required this.fiber,
    required this.calories,
    required this.lysine,

    required this.quantityUnit,
    required this.quantityLimit,
    required this.quantityUnitDisplay,

    required this.fixedQuantity,
    required this.mealTypeSubOption,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    List mediaList = [];

    // backend media: string → decode
    if (json["media"] != null && json["media"] is String) {
      try {
        final decoded = jsonDecode(json["media"]);
        if (decoded is List) mediaList = decoded;
      } catch (_) {}
    }

    // backend media_decoded: array → direct
    if (json["media_decoded"] != null && json["media_decoded"] is List) {
      mediaList = json["media_decoded"];
    }

    // get URL
    String imageUrl = "";
    if (mediaList.isNotEmpty &&
        mediaList[0] is Map &&
        mediaList[0]["url"] != null) {
      imageUrl = mediaList[0]["url"];
    }

    return FoodModel(
      id: json["id"] is int
          ? json["id"]
          : int.tryParse(json["id"].toString()) ?? 0,

      name: json["name"] ?? "",
      rawItem: json["raw_item"] ?? "",

      type: json["type"] ?? "",
      classification: json["classification"] ?? "",
      image: imageUrl,
      description: json["description"] ?? "",

      category: json["category"] ?? "",
      goal: json["goal"] ?? "",
      time: json["time"] ?? "",

      carbs: json["carbs"] ?? "0",
      fat: json["fat"] ?? "0",
      protein: json["protein"] ?? "0",
      fiber: json["fiber"] ?? "0",
      calories: json["calories"] ?? "0",
      lysine: json["lysine"] ?? "0",

      quantityUnit: json["quantity_unit"] ?? "",
      quantityLimit: json["quantity_limit"] ?? "0",
      quantityUnitDisplay: json["quantity_unit_display"] ?? "",

      fixedQuantity: json["fixed_quantity"] ?? "",
      mealTypeSubOption: json["meal_type_sub_option"] ?? "",
    );
  }
}
