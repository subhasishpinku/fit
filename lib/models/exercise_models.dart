class Exercise {
  final int id;
  final String addedBy;
  final String special;
  final String gender;
  final String mode;
  final String status;
  final String type;
  final String cardioOrWeight;
  final String goal;
  final String? forms;
  final String name;
  final String description;
  final String nameEs;
  final String descriptionEs;
  final String category;
  final String subcategory;
  final String schedule;

  final int sets;
  final int reps;
  final double time;
  final double compTime;
  final double restTime;
  final double calories;

  final String media;
  final String imageUrls;

  final String createdAt;
  final String updatedAt;

  final String? existsInMedia;
  final String liftingCategory;
  final String newAppExercise;

  final List<dynamic> imageUrlsDecoded;
  final List<dynamic> mediaDecoded;

  final String lastDoneAt;
  final String statusDisplay;

  final int newSets;
  final int newReps;

  Exercise({
    required this.id,
    required this.addedBy,
    required this.special,
    required this.gender,
    required this.mode,
    required this.status,
    required this.type,
    required this.cardioOrWeight,
    required this.goal,
    required this.forms,
    required this.name,
    required this.description,
    required this.nameEs,
    required this.descriptionEs,
    required this.category,
    required this.subcategory,
    required this.schedule,
    required this.sets,
    required this.reps,
    required this.time,
    required this.compTime,
    required this.restTime,
    required this.calories,
    required this.media,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.existsInMedia,
    required this.liftingCategory,
    required this.newAppExercise,
    required this.imageUrlsDecoded,
    required this.mediaDecoded,
    required this.lastDoneAt,
    required this.statusDisplay,
    required this.newSets,
    required this.newReps,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["id"] ?? 0,
      addedBy: json["added_by"] ?? "",
      special: json["special"]?.toString() ?? "",
      gender: json["gender"] ?? "",
      mode: json["mode"] ?? "",
      status: json["status"] ?? "",
      type: json["type"] ?? "",
      cardioOrWeight: json["cardio_or_weight"] ?? "",
      goal: json["goal"] ?? "",
      forms: json["forms"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      nameEs: json["name_es"] ?? "",
      descriptionEs: json["description_es"] ?? "",
      category: json["category"] ?? "",
      subcategory: json["subcategory"] ?? "",
      schedule: json["schedule"] ?? "",
      sets: (json["sets"] ?? 0).toInt(),
      reps: (json["reps"] ?? 0).toInt(),
      time: (json["time"] ?? 0).toDouble(),
      compTime: (json["compTime"] ?? 0).toDouble(),
      restTime: (json["restTime"] ?? 0).toDouble(),
      calories: (json["calories"] ?? 0).toDouble(),
      media: json["media"] ?? "",
      imageUrls: json["Imageurls"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      existsInMedia: json["exists_in_media"],
      liftingCategory: json["lifting_category"]?.toString() ?? "",
      newAppExercise: json["new_app_exercise"]?.toString() ?? "",
      imageUrlsDecoded: json["image_urls_decoded"] ?? [],
      mediaDecoded: json["media_decoded"] ?? [],
      lastDoneAt: json["last_done_at"] ?? "",
      statusDisplay: json["status_display"] ?? "",
      newSets: json["new_sets_reps"]?["sets"] ?? 0,
      newReps: json["new_sets_reps"]?["reps"] ?? 0,
    );
  }
}
  