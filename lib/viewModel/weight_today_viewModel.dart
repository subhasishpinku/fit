import 'package:aifitness/models/WeightLogModel.dart';
import 'package:aifitness/repository/WeightHistoryRepository.dart';
import 'package:aifitness/repository/WeightRepository.dart';
import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class WeightTodayViewModel extends ChangeNotifier {
  final WeightRepository _repo = WeightRepository();
  final WeightHistoryRepository _repo1 = WeightHistoryRepository();

  List<WeightLogModel> _weightLogs = [];
  List<WeightLogModel> get weightLogs => _weightLogs;

  bool _loading = false;
  bool get loading => _loading;

  String? minValueForWeek;
  String message = "";

  final TextEditingController weightController = TextEditingController();

  final List<WeightEntry> _history = [];
  List<WeightEntry> get history => _history;

  // ---------------- FETCH ----------------
  Future<void> fetchWeightLogs({
    required int userId,
    required String week,
    required String day,
    required String logType,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      final logs = await _repo1.getWeightLogs({
        "user_id": userId,
        "week": week,
        "day": day,
        "log_type": logType,
      });
      print(
        "Params -> user_id: $userId, week: $week, day: $day, log_type: $logType",
      );
      _history.clear();

      for (var log in logs) {
        print("Readable time: ${log.createdAtFormatted}");
        _history.add(
          WeightEntry(
            double.tryParse(log.logValue) ?? 0.0,
            log.createdAtFormatted,
          ),
        );
      }
    } catch (e) {
      message = "Failed to fetch logs: $e";
    }

    _loading = false;
    notifyListeners();
  }

  // ---------------- SUBMIT ----------------
  Future<void> submitWeight(
    BuildContext context, {
    required int userId,
    required String week,
    required String day,
    required String logType,
    required String logValue,
  }) async {
    final text = weightController.text.trim();

    if (text.isEmpty) {
      message = "Please enter weight";
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    try {
      final response = await _repo.addWeightLog({
        "user_id": userId,
        "log_value": logValue,
        "week": week,
        "day": day,
        "log_type": logType,
      });
      print(
        "ParamsaddWeightLog -> user_id: $userId, week: $week, day: $day, log_type: $logType log_value: $logValue",
      );
      message = response.message ?? "Weight updated successfully";
      
      minValueForWeek = response.minValueForWeek;
      print("timeValueWeight $minValueForWeek");
      final weight = double.tryParse(text);
      final String times = timeago.format(DateTime.now());
      if (weight != null) {
        _history.insert(0, WeightEntry(weight, times));
        weightController.clear();
      }

      notifyListeners();

      final dashboardVM = context.read<DashboardBodyViewModel>();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: const Text(
              "Success",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                await dashboardVM.loadDashboard();
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      message = "Something went wrong: $e";
      notifyListeners();
    }

    _loading = false;
    notifyListeners();
  }

  // ---------------- DELETE ----------------
  void deleteWeight(int index) {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
}

class WeightEntry {
  final double weight;
  String time;
  WeightEntry(this.weight, this.time);
}
