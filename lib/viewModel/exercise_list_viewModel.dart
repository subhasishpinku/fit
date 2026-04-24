import 'package:aifitness/models/FullBodyPlanModel.dart';
import 'package:aifitness/repository/FullBodyPlanRepository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseListViewModel extends ChangeNotifier {
  final _repo = FullBodyPlanRepository();

  bool _loading = false;
  bool get loading => _loading;

  FullBodyData? _data;
  FullBodyData? get data => _data;

  String errorMessage = "";

  /// Visibility list for animation
  List<bool> isVisible = [];

  /// Selected day
  String? selectedDay;

  /// Fetch API data
  Future<void> getPlan() async {
    _loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("user_id") ?? 0;
    String? deviceId = prefs.getString("device_id");

    try {
      final body = {
        "user_id": userId.toString(),
        "device_id": deviceId,
        "days": "true",
      };

      final response = await _repo.fetchFullBodyPlan(body);
      _data = response.data;

      /// Create visibility list same length as API list (all hidden initially)
      isVisible = List.filled(_data!.days.length, false);

      /// Start animation
      startAnimation();

      errorMessage = "";
    } catch (e) {
      errorMessage = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  /// Staggered animation based on API list count
  void startAnimation() async {
    for (int i = 0; i < isVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle day selection
  void selectDay(BuildContext context, String day) {
    selectedDay = day;
    Navigator.pushNamed(context, RouteNames.exerciseListDetails);
    notifyListeners();
  }
}
