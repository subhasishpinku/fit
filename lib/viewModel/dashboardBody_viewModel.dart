import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/dashboard_repository.dart';

class DashboardBodyViewModel extends ChangeNotifier {
  final DashboardRepository _repo = DashboardRepository();

  bool isLoading = false;
  
  // Add a flag to track if we're already loading
  bool _isLoadingDashboard = false;
  bool _isLoadingWalkingSteps = false;

  double currentWeight = 0;
  String targetWeight = "";
  double dailyCalories = 0;
  double weekProgress = 0;

  int weekNumber = 1;
  String gender = "";
  String day = "";

  List<double> weightData = [];
  List<double> bfpData = [];
  List<double> skeletalData = [];
  List<double> waterData = [];
  List<double> subcutaneousData = [];
  List<double> visceralData = [];

  String walkingSteps = "0";
  String caloriesBurn = "0";

  bool get hasData =>
      weightData.isNotEmpty ||
      bfpData.isNotEmpty ||
      skeletalData.isNotEmpty ||
      walkingSteps != "0";

  /// MAIN API CALL
  Future<void> loadDashboard() async {
    // Prevent multiple simultaneous calls
    if (_isLoadingDashboard) return;
    
    try {
      _isLoadingDashboard = true;
      isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      String deviceId = prefs.getString("device_id") ?? "123456";
      int userId = prefs.getInt("user_id") ?? 0;

      final model = await _repo.fetchDashboardData(
        userId: userId,
        deviceId: deviceId,
        deviceType: "android",
      );

      final data = model.data;

      if (data != null) {
        weekNumber = data.dayDetails?.week ?? 1;
        day = data.dayDetails?.day ?? "1";
        gender = data.userDetails?.gender ?? "";

        weightData = _toDoubleList(data.latestWeightLogs);
        skeletalData = _toDoubleList(data.latestSkeletalMuscleLogs);
        bfpData = _toDoubleList(data.latestBodyFatPercentageLogs);
        waterData = _toDoubleList(data.latestTotalBodyWaterLogs);
        subcutaneousData = _toDoubleList(data.latestSubcutaneousFatLogs);
        visceralData = _toDoubleList(data.latestVisceralFatLevelLogs);

        final phaseList = data.newAppData?.phaseSummaryDynamic ?? [];
        final currentPhase = data.newAppData?.currentPhase;

        for (var item in phaseList) {
          if (item.phase == currentPhase) {
            currentWeight = double.tryParse(item.startWeight ?? "0") ?? 0;
            dailyCalories = double.tryParse(item.dailyCalories ?? "0") ?? 0;
          }
        }

        targetWeight = data.currentWeekTargetWeightValue ?? "";

        const totalWeeks = 4;
        int week = data.dayDetails?.week ?? 1;
        weekProgress = (week / totalWeeks).clamp(0.0, 1.0);
      }

      // Call walking API without immediate notification
      await loadWalkingSteps(callNotify: false);
      
    } catch (e) {
      print("ERROR = $e");
    } finally {
      isLoading = false;
      _isLoadingDashboard = false;
      notifyListeners(); // Single notification at the end
    }
  }

  /// WALKING API
  Future<void> loadWalkingSteps({bool callNotify = true}) async {
    // Prevent multiple simultaneous calls
    if (_isLoadingWalkingSteps) return;
    
    try {
      _isLoadingWalkingSteps = true;
      
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("user_id") ?? 0;

      final response = await _repo.fetchWalkingSteps(userId);

      if (response["success"] == true && response["data"] != null) {
        final list = response["data"];

        if (list.isNotEmpty) {
          walkingSteps = list[0]["walking_step"]?.toString() ?? "0";
          caloriesBurn = list[0]["calories_burn"]?.toString() ?? "0";
        }
      } else {
        walkingSteps = "0";
        caloriesBurn = "0";
      }

      if (callNotify) notifyListeners();
    } catch (e) {
      print("Walking Steps Error = $e");
    } finally {
      _isLoadingWalkingSteps = false;
    }
  }

  List<double> _toDoubleList(dynamic list) {
    try {
      if (list == null || list.isEmpty) return [];

      return List<double>.from(
        list.map((e) {
          final value = e["log_value"];
          return double.tryParse(value.toString()) ?? 0;
        }),
      );
    } catch (e) {
      print("Parse Error = $e");
      return [];
    }
  }
}