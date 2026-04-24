import 'package:aifitness/models/exercise_models.dart';
import 'package:aifitness/repository/workout_repository.dart';
import 'package:flutter/material.dart';

class WorkoutViewModel extends ChangeNotifier {
  final WorkoutRepository _repo = WorkoutRepository();

  bool _loading = false;
  bool get loading => _loading;

  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  List<dynamic> muscles = [];

  String? _error;
  String? get error => _error;

  Future<void> getWorkouts(int userId, String day, String deviceId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _exercises = await _repo.fetchWorkouts(
        userId: userId,
        day: day,
        deviceId: deviceId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
}
