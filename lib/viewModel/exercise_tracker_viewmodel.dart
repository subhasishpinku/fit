import 'package:flutter/material.dart';
import '../models/exercise_tracker_model.dart';
import '../repository/exercise_tracker_repository.dart';

class ExerciseTrackerViewModel extends ChangeNotifier {
  final repo = ExerciseTrackerRepository();

  bool loading = false;
  List<ExerciseTrackerModel> history = [];

  Future fetchExerciseTracker(int userId, int exerciseId) async {
    loading = true;
    notifyListeners();

    try {
      history = await repo.getExerciseHistory(userId, exerciseId);
    } catch (e) {
      debugPrint("Error in getExerciseTracker -> $e");
    }

    loading = false;
    notifyListeners();
  }
}
