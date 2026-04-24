class MealSection {
  final String title;
  final String? iconPath;
  final List<MealItem> items;
  final String totalKcal;

  MealSection({
    required this.title,
    this.iconPath,
    required this.items,
    required this.totalKcal,
  });
}

class MealItem {
  final String name;
  final String image;
  final String carbs;
  final String protein;
  final String fats;

  MealItem({
    required this.name,
    required this.image,
    required this.carbs,
    required this.protein,
    required this.fats,
  });
}
