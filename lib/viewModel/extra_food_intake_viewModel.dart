import 'package:aifitness/models/WrongDietHistoryModel.dart';
import 'package:aifitness/models/wrong_diet_model.dart';
import 'package:aifitness/repository/WrongDietHistoryRepository.dart';
import 'package:aifitness/repository/wrong_diet_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraFoodIntakeViewModel extends ChangeNotifier {
  final WrongDietRepository _repo = WrongDietRepository();
  final WrongDietHistoryRepository _repo1 = WrongDietHistoryRepository();

  final TextEditingController intakeController = TextEditingController();
  bool _loading = false;
  bool get loading => _loading;

  List<WrongDietModel> _wrongDietList = [];
  List<WrongDietModel> get wrongDietList => _wrongDietList;

  List<WrongDietItem> _intakeHistory = [];
  List<WrongDietItem> get intakeHistory => _intakeHistory;
  String message = "";
  String errorMessage = "";

  Future<void> submitWrongDiet({
    required int userId,
    required String week,
    required String day,
  }) async {
    final description = intakeController.text.trim();

    if (description.isEmpty) {
      message = "Please enter description";
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    try {
      final result = await _repo.addWrongDiet({
        "user_id": userId,
        "week": week,
        "day": day,
        "description": description,
      });

      // Add to local list
      _wrongDietList.insert(0, result);

      message = "Wrong diet added successfully";
      intakeController.clear();
      final prefs = await SharedPreferences.getInstance();
      int userId1 = prefs.getInt("user_id") ?? 0;
      int week1 = prefs.getInt("week") ?? 0;
      fetchWrongDietHistory(week1.toString(), userId1);
    } catch (e) {
      message = "Error: $e";
    }

    _loading = false;
    notifyListeners();
  }

  // ----------------------------
  // Fetch Wrong Diet History
  // ----------------------------
  Future<void> fetchWrongDietHistory(String week, int userId) async {
    try {
      _loading = true;
      notifyListeners();

      final result = await _repo1.getWrongDietHistory(week, userId);

      if (result.success) {
        _intakeHistory = result.data;
      } else {
        errorMessage = result.message;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
  // void submitIntake() {
  //   final text = intakeController.text.trim();
  //   if (text.isNotEmpty) {
  //     _intakeHistory.add(text);
  //     intakeController.clear();
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    intakeController.dispose();
    intakeController.clear();
    super.dispose();
  }
}
