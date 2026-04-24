import 'package:aifitness/repository/ExerciseAddTrackerRepository.dart';
import 'package:flutter/material.dart';

class AddExerciseTrackerViewModel extends ChangeNotifier {
  final repo = ExerciseAddTrackerRepository();
  bool loading = false;

  Future<bool> saveTracker(Map<String, dynamic> body) async {
    print("bodyValue $body");
    loading = true;
    notifyListeners();

    try {
      bool result = await repo.saveExerciseTracker(body);
      loading = false;
      notifyListeners();
      return result;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
