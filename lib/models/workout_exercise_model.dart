import 'dart:convert';

class WorkoutExerciseModel {
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
  final int time;
  final double compTime;
  final double restTime;
  final int calories;
  final List<MediaItem> mediaDecoded;
  final List<ImageItem> imageUrlsDecoded;
  final String? existsInMedia;
  final String liftingCategory;
  final String newAppExercise;
  final String? lastDoneAt;
  final String statusDisplay;
  final NewSetReps newSetsReps;

  WorkoutExerciseModel({
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
    required this.mediaDecoded,
    required this.imageUrlsDecoded,
    required this.existsInMedia,
    required this.liftingCategory,
    required this.newAppExercise,
    required this.lastDoneAt,
    required this.statusDisplay,
    required this.newSetsReps,
  });

  // helpers
  static int _parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }

  static double _parseDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static List<T> _parseList1<T>(
    dynamic value,
    T Function(Map<String, dynamic>) mapper,
  ) {
    if (value == null) return <T>[];
    if (value is List) {
      return value.map<T>((e) {
        if (e is Map<String, dynamic>) return mapper(e);
        if (e is String) {
          try {
            final Map<String, dynamic> m = jsonDecode(e);
            return mapper(m);
          } catch (_) {
            // try decode each item if it's a JSON string list
            try {
              final parsed = jsonDecode(e);
              if (parsed is Map<String, dynamic>) return mapper(parsed);
            } catch (_) {}
          }
        }
        return mapper(<String, dynamic>{});
      }).toList();
    }
    // if it's a JSON string representing a list
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded
              .map<T>(
                (e) => mapper(
                  e is Map ? Map<String, dynamic>.from(e) : <String, dynamic>{},
                ),
              )
              .toList();
        }
      } catch (_) {}
    }
    return <T>[];
  }

  static List<T> _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) mapper,
  ) {
    final List<T> result = [];

    if (value == null) return result;

    List list;

    // If backend sends list
    if (value is List) {
      list = value;
    }
    // If backend sends JSON string
    else if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          list = decoded;
        } else {
          return result;
        }
      } catch (_) {
        return result;
      }
    } else {
      return result;
    }

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(mapper(item));
        } else if (item is Map) {
          result.add(mapper(Map<String, dynamic>.from(item)));
        } else if (item is String) {
          final m = jsonDecode(item);
          if (m is Map<String, dynamic>) {
            result.add(mapper(m));
          }
        }
      } catch (_) {
        // instead of adding empty {}, SKIP the item
        continue;
      }
    }

    return result;
  }

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    // media field sometimes is a JSON string (e.g. "[{...}]")
    final mediaDecoded = _parseList<MediaItem>(
      json['media_decoded'] ?? jsonDecodeSafe(json['media']),
      (m) => MediaItem.fromJson(Map<String, dynamic>.from(m)),
    );

    final imageDecoded = _parseList<ImageItem>(
      json['image_urls_decoded'] ?? jsonDecodeSafe(json['Imageurls']),
      (m) => ImageItem.fromJson(Map<String, dynamic>.from(m)),
    );

    // new_sets_reps may be object or list
    NewSetReps parseNewSets(dynamic v) {
      if (v == null) return NewSetReps(sets: 0, reps: 0);
      if (v is Map) {
        return NewSetReps.fromJson(Map<String, dynamic>.from(v));
      }
      if (v is List && v.isNotEmpty) {
        final first = v.first;
        if (first is Map)
          return NewSetReps.fromJson(Map<String, dynamic>.from(first));
      }
      if (v is String) {
        try {
          final d = jsonDecode(v);
          if (d is Map)
            return NewSetReps.fromJson(Map<String, dynamic>.from(d));
          if (d is List && d.isNotEmpty && d.first is Map) {
            return NewSetReps.fromJson(Map<String, dynamic>.from(d.first));
          }
        } catch (_) {}
      }
      return NewSetReps(sets: 0, reps: 0);
    }

    return WorkoutExerciseModel(
      id: _parseInt(json['id']),
      addedBy: json['added_by']?.toString() ?? '',
      special: json['special']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      mode: json['mode']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      cardioOrWeight: json['cardio_or_weight']?.toString() ?? '',
      goal: json['goal']?.toString() ?? '',
      forms: json['forms']?.toString(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      nameEs: json['name_es']?.toString() ?? '',
      descriptionEs: json['description_es']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      subcategory: json['subcategory']?.toString() ?? '',
      schedule: json['schedule']?.toString() ?? '',
      sets: _parseInt(json['sets']),
      reps: _parseInt(json['reps']),
      time: _parseInt(json['time']),
      compTime: _parseDouble(json['compTime']),
      restTime: _parseDouble(json['restTime']),
      calories: _parseInt(json['calories']),
      mediaDecoded: mediaDecoded,
      imageUrlsDecoded: imageDecoded,
      existsInMedia: json['exists_in_media']?.toString(),
      liftingCategory: json['lifting_category']?.toString() ?? '',
      newAppExercise: json['new_app_exercise']?.toString() ?? '',
      lastDoneAt: (json['last_done_at'] == null || json['last_done_at'] == "")
          ? null
          : json['last_done_at'].toString(),
      statusDisplay: json['status_display']?.toString() ?? '',
      newSetsReps: parseNewSets(json['new_sets_reps']),
    );
  }

  static dynamic jsonDecodeSafe(dynamic v) {
    if (v == null) return null;
    if (v is List || v is Map) return v;
    if (v is String && v.trim().isNotEmpty) {
      try {
        return jsonDecode(v);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

class MediaItem {
  final String uri;
  final String type;
  final String group;

  MediaItem({required this.uri, required this.type, required this.group});

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      uri: json['uri']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      group: json['group']?.toString() ?? '',
    );
  }
}

class ImageItem {
  final String uri;
  final String type;
  final String group;

  ImageItem({required this.uri, required this.type, required this.group});

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      uri: json['uri']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      group: json['group']?.toString() ?? '',
    );
  }
}

class NewSetReps {
  final int sets;
  final int reps;

  NewSetReps({required this.sets, required this.reps});

  factory NewSetReps.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => int.tryParse(v?.toString() ?? '') ?? 0;
    return NewSetReps(
      sets: parseInt(json['sets']),
      reps: parseInt(json['reps']),
    );
  }
}
