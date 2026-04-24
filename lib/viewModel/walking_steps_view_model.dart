import 'package:flutter/material.dart';
import 'package:aifitness/repository/dashboard_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class WalkingStepsViewModel extends ChangeNotifier {
//   final DashboardRepository _repo = DashboardRepository();

//   String walkingSteps = "0";
//   String caloriesBurn = "0";
//   bool isLoading = false;

//   Future<void> loadWalkingSteps() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       int userId = prefs.getInt("user_id") ?? 0;

//       final response = await _repo.fetchWalkingSteps(userId);

//       if (response["success"] == true) {
//         final list = response["data"];
//         if (list != null && list.isNotEmpty) {
//           walkingSteps = list[0]["walking_step"].toString();
//           caloriesBurn = list[0]["calories_burn"].toString();
//         }
//       }
//     } catch (e) {
//       print("Walking Steps Error = $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> saveSteps(
//     int userId,
//     double steps,
//     double calories,
//     BuildContext context,
//   ) async {
//     // Implement your save logic here
//     // This should call an API to save the steps

//     // After saving, reload the data
//     await loadWalkingSteps();

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("Steps saved successfully!")));
//   }
// }

class WalkingStepsViewModel extends ChangeNotifier {
  final DashboardRepository _repo = DashboardRepository();

  String walkingSteps = "0";
  String caloriesBurn = "0";
  bool isLoading = false;
  Future<void> loadWalkingSteps2() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("user_id") ?? 0;

      final response = await _repo.fetchWalkingSteps(userId);

      if (response["success"] == true) {
        final list = response["data"];
        if (list != null && list.isNotEmpty) {
          walkingSteps = list[0]["walking_step"].toString();
          caloriesBurn = list[0]["calories_burn"].toString();
        }
      }
    } catch (e) {
      print("Walking Steps Error = $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWalkingSteps1() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("user_id") ?? 0;

      final response = await _repo.fetchWalkingSteps(userId);

      if (response["success"] == true) {
        final list = response["data"];
        if (list != null && list.isNotEmpty) {
          walkingSteps = list[0]["walking_step"]?.toString() ?? "0";
          caloriesBurn = list[0]["calories_burn"]?.toString() ?? "0";
        } else {
          // Reset to zero if no data
          walkingSteps = "0";
          caloriesBurn = "0";
        }
      } else {
        walkingSteps = "0";
        caloriesBurn = "0";
      }
    } catch (e) {
      print("Walking Steps Error = $e");
      walkingSteps = "0";
      caloriesBurn = "0";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveSteps1(
    int userId,
    double steps,
    double calories,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      // Call the API to save steps
      final response = await _repo.saveWalkingSteps(
        userId: userId,
        steps: steps.toInt(),
        calories: calories,
      );

      if (response["success"] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"] ?? "Steps saved successfully!"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Reload the data to get the updated list
        await loadWalkingSteps();
      } else {
        // Show error message from API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"] ?? "Failed to save steps"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Save Steps Error = $e");

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving steps: ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> allRecords = [];

  Future<void> loadWalkingSteps() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("user_id") ?? 0;

      print('Loading walking steps for user: $userId');
      final response = await _repo.fetchWalkingSteps(userId);

      print('Walking API Response = $response');

      // Clear previous records
      allRecords.clear();

      // Check if the response contains data
      if (response.containsKey('data') && response['data'] != null) {
        final list = response['data'];
        if (list is List && list.isNotEmpty) {
          // Store all records
          allRecords = List<Map<String, dynamic>>.from(list);

          // Set the latest record for the slider
          walkingSteps = allRecords.first["walking_step"]?.toString() ?? "0";
          caloriesBurn = allRecords.first["calories_burn"]?.toString() ?? "0";

          print('Loaded ${allRecords.length} records');
          print('Latest steps: $walkingSteps, calories: $caloriesBurn');
        } else {
          print('No data found in response');
          walkingSteps = "0";
          caloriesBurn = "0";
        }
      } else {
        // Try alternative response structure
        if (response.containsKey('walking_step')) {
          walkingSteps = response['walking_step']?.toString() ?? "0";
          caloriesBurn = response['calories_burn']?.toString() ?? "0";

          // Add as a single record
          allRecords = [
            {
              'walking_step': walkingSteps,
              'calories_burn': caloriesBurn,
              'created_at': DateTime.now().toString(),
            },
          ];
        } else {
          print('Unexpected response format: $response');
          walkingSteps = "0";
          caloriesBurn = "0";
        }
      }
    } catch (e) {
      print("Walking Steps Error = $e");
      walkingSteps = "0";
      caloriesBurn = "0";
      allRecords.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveSteps(
    int userId,
    double steps,
    double calories,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      print('Saving steps - User: $userId, Steps: $steps, Calories: $calories');

      final response = await _repo.saveWalkingSteps(
        userId: userId,
        steps: steps.toInt(),
        calories: calories,
      );

      print('Save response: $response');

      if (response["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"] ?? "Steps saved successfully!"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Reload the data to get the updated list
        await loadWalkingSteps();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"] ?? "Failed to save steps"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Save Steps Error = $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving steps: ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
