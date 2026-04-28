import 'package:aifitness/viewModel/days_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/view_plan_repository.dart';
import '../view/NutritionPlanScreen.dart';

class ViewPlanViewModel extends ChangeNotifier {
  final ViewPlanRepository repo = ViewPlanRepository();

  List<int> workoutDays = [];
  List<int> nonWorkoutDays = [];
  List<bool> dayVisible = [];

  bool loading = true;

  ViewPlanViewModel() {
    fetchDays();
  }

  Future<void> fetchDays() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("device_id") ?? "123456";
    int userId = prefs.getInt("user_id") ?? 0;
    DaysModel? model = await repo.fetchDays(userId);

    if (model != null) {
      workoutDays = model.workoutDays;
      nonWorkoutDays = model.nonWorkoutDays;
    }

    loading = false;
    notifyListeners();
    _startAnimation();
  }

  void _startAnimation() async {
    final total = workoutDays.length + nonWorkoutDays.length;
    dayVisible = List.generate(total, (_) => false);

    for (int i = 0; i < total; i++) {
      await Future.delayed(Duration(milliseconds: 140));
      dayVisible[i] = true;
      notifyListeners();
    }
  }

  void openDayPlan(BuildContext context, int day, String dayType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NutritionPlanScreen(day: day, dayType: dayType),
      ),
    );
  }
}
