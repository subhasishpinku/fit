import 'package:aifitness/models/DietData.dart';
import 'package:aifitness/models/FoodItem.dart';
import 'package:aifitness/repository/DietRepository.dart';
import 'package:flutter/foundation.dart';

class NutritionPlanViewModel extends ChangeNotifier {
  final DietRepository _repo = DietRepository();

  bool isLoading = false;
  Map<String, List<FoodItem>> meals = {};
  DietData? dietData;
  String? errorMessage;

  Future<void> getDiet({
    required int week,
    required int userId,
    required String dayType,
    required String day,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _repo.getDietPlan(
        week: week,
        userId: userId,
        dayType: dayType,
        day: day,
      );
      
      print("Diet API Response for week: $week, userId: $userId, dayType: $dayType, day: $day");

      if (response.success) {
        dietData = response.data;
        
        meals = {
          "breakfast": response.data!.breakfast ?? [],
          "lunch": response.data!.lunch ?? [],
          "dinner": response.data!.dinner ?? [],
          "pre_workout": response.data!.preWorkout ?? [],
          "post_workout": response.data!.postWorkout ?? [],
          "snacks": response.data!.snacks ?? [],
          "supplements": response.data!.supplements ?? [],
        };

        print("Breakfast items: ${response.data!.breakfast?.length ?? 0}");
        print("Lunch items: ${response.data!.lunch?.length ?? 0}");
        print("Dinner items: ${response.data!.dinner?.length ?? 0}");
        print("Pre-workout items: ${response.data!.preWorkout?.length ?? 0}");
        print("Post-workout items: ${response.data!.postWorkout?.length ?? 0}");
        print("Snacks items: ${response.data!.snacks?.length ?? 0}");
        print("Supplements items: ${response.data!.supplements?.length ?? 0}");
        
        // Alternative foods
        print("Breakfast alternatives: ${response.data!.breakfastAlternative?.length ?? 0}");
        print("Lunch alternatives: ${response.data!.lunchAlternative?.length ?? 0}");
        print("Dinner alternatives: ${response.data!.dinnerAlternative?.length ?? 0}");
        print("Snack alternatives: ${response.data!.snackAlternative?.length ?? 0}");
      } else {
        errorMessage = response.message;
      }
    } catch (e) {
      print("Error fetching diet: $e");
      errorMessage = "Failed to load diet plan";
    }

    isLoading = false;
    notifyListeners();
  }

  // Getters for meals
  List<FoodItem> get breakfast => meals["breakfast"] ?? [];
  List<FoodItem> get lunch => meals["lunch"] ?? [];
  List<FoodItem> get dinner => meals["dinner"] ?? [];
  List<FoodItem> get snacks => meals["snacks"] ?? [];
  List<FoodItem> get postWorkout => meals["post_workout"] ?? [];
  List<FoodItem> get preWorkout => meals["pre_workout"] ?? [];
  List<FoodItem> get supplements => meals["supplements"] ?? [];
  
  // Getters for alternative foods
  List<FoodItem> get breakfastAlternative => dietData?.breakfastAlternative ?? [];
  List<FoodItem> get lunchAlternative => dietData?.lunchAlternative ?? [];
  List<FoodItem> get dinnerAlternative => dietData?.dinnerAlternative ?? [];
  List<FoodItem> get snackAlternative => dietData?.snackAlternative ?? [];
}