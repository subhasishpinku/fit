// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/supplement_model.dart';
// import '../repository/supplement_repository.dart';
// import '../utils/routes/routes_names.dart';

// class SupplementProvider extends ChangeNotifier {
//   final SupplementRepository repository;

//   SupplementProvider(this.repository);

//   List<SupplementModel> supplements = [];

//   bool loading = false;
//   String errorMessage = "";

//   /// API LOAD
//   Future<void> loadSupplements() async {
//     loading = true;
//     notifyListeners();

//     try {
//       supplements = await repository.fetchSupplements();

//       if (supplements.isEmpty) {
//         errorMessage = "No supplements found";
//       }
//     } catch (e) {
//       errorMessage = "Failed to load supplements";
//     }

//     loading = false;
//     notifyListeners();
//   }

//   /// Selection Logic
//   final List<int> selectedIds = [];

//   bool get canProceed => selectedIds.length >= 1 && selectedIds.length <= 5;

//   void toggleSelection(int id) {
//     if (selectedIds.contains(id)) {
//       selectedIds.remove(id);
//     } else {
//       if (selectedIds.length < 5) {
//         selectedIds.add(id);
//       }
//     }

//     notifyListeners();
//   }

//   bool isSelected(int id) {
//     return selectedIds.contains(id);
//   }

//   /// Save Selected
//   Future<void> saveSelectedItems() async {
//     final prefs = await SharedPreferences.getInstance();

//     /// selected id থেকে name বের করা
//     List<String> selectedNames = supplements
//         .where((item) => selectedIds.contains(item.id))
//         .map((item) => item.name)
//         .toList();

//     String jsonString = jsonEncode(selectedNames);

//     await prefs.setString("supplements", jsonString);

//     print("Saved supplements: $jsonString");
//   }

//   /// Next Button
//   void onNextPressed(BuildContext context) async {
//     if (canProceed) {
//       await saveSelectedItems();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Proceeding to next step..."),
//           duration: Duration(seconds: 1),
//         ),
//       );

//       // Navigator.pushNamed(context, RouteNames.signinScreenTwentyFour);
//       Navigator.pushNamed(context, RouteNames.addMealScreen);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select between 5 supplements.")),
//       );
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/supplement_model.dart';
import '../repository/supplement_repository.dart';
import '../utils/routes/routes_names.dart';

class SupplementProvider extends ChangeNotifier {
  final SupplementRepository repository;

  SupplementProvider(this.repository);

  List<SupplementModel> supplements = [];
  bool loading = false;

  String selectedCategory = "All";

  /// LOAD API
  Future<void> loadSupplements() async {
    loading = true;
    notifyListeners();

    try {
      supplements = await repository.fetchSupplements(
        type: "Non Veg",
        gender: "All",
        subCategory: selectedCategory == "All" ? null : selectedCategory,
      );
    } catch (e) {
      debugPrint("Error: $e");
    }

    loading = false;
    notifyListeners();
  }

  /// CATEGORY CHANGE
  Future<void> setCategory(String category) async {
    selectedCategory = category;
    notifyListeners();
    await loadSupplements();
  }

  /// SELECTION
  final List<int> selectedIds = [];

  /// 🔥 EXACTLY 5 REQUIRED
  // bool get canProceed => selectedIds.length == 5;
  bool get canProceed => selectedIds.isNotEmpty;

  void toggleSelection(int id, BuildContext context) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      if (selectedIds.length >= 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You can only select maximum 5 supplements"),
          ),
        );
        return;
      }

      selectedIds.add(id);
    }

    notifyListeners();
  }

  bool isSelected(int id) => selectedIds.contains(id);

  /// SAVE
  Future<void> saveSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> selectedNames = supplements
        .where((item) => selectedIds.contains(item.id))
        .map((item) => item.name)
        .toList();

    await prefs.setString("supplements", jsonEncode(selectedNames));
  }

  /// NEXT
  void onNextPressed(BuildContext context) async {
    if (selectedIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least 1 supplement")),
      );
      return;
    }

    await saveSelectedItems();
    Navigator.pushNamed(context, RouteNames.addMealScreen);
  }

  /// SKIP
  void onSkip(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.addMealScreen);
  }
}
