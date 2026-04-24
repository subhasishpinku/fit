// import 'package:aifitness/utils/routes/routes_names.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SigninViewModel extends ChangeNotifier {
//   final List<String> topics = [
//     "Weight Loss Fat-Burning Diet & \n Exercise Plan",
//     "Weight Loss Ketogenic Diet & \n Exercise Plan",
//     "Weight Loss Diabetic-Friendly Diet & \n Exercise Plan",
//     "High-Protein Diet & Exercise Plan",
//     "Muscle Gain Diet & Exercise Plan",
//   ];

//   final List<bool> _isVisible = [false, false, false, false, false];
//   List<bool> get isVisible => _isVisible;

//   SigninViewModel() {
//     _animateButtonsSequentially();
//   }

//   /// Sequential animation for button appearance
//   Future<void> _animateButtonsSequentially() async {
//     for (int i = 0; i < topics.length; i++) {
//       await Future.delayed(const Duration(milliseconds: 250));
//       _isVisible[i] = true;
//       notifyListeners();
//     }
//   }

//   /// Handle topic button click
//   Future<void> onTopicSelected(BuildContext context, String topic) async {
//     final prefs = await SharedPreferences.getInstance();

//     String planType = '';

//     if (topic == "Weight Loss Fat-Burning Diet & \n Exercise Plan") {
//       planType = 'weight_fat_loss';
//     } else if (topic == "Weight Loss Ketogenic Diet & \n Exercise Plan") {
//       planType = 'weight_loss_ketogenic';
//     } else if (topic ==
//         "Weight Loss Diabetic-Friendly Diet & \n Exercise Plan") {
//       planType = 'weight_loss_diabetic';
//     } else if (topic == "High-Protein Diet & Exercise Plan") {
//       planType = 'high_protein';
//     } else if (topic == "Muscle Gain Diet & Exercise Plan") {
//       planType = 'muscle_gain';
//     }

//     //  Always use lowercase consistent key
//     await prefs.setString('plan_type', planType);
//     // Optional: reload to ensure value syncs
//     await prefs.reload();
//     final selectedTopic = prefs.getString('plan_type');
//     debugPrint('Saved plan_type: $selectedTopic');
//     // ScaffoldMessenger.of(
//     //   context,
//     // ).showSnackBar(SnackBar(content: Text("Selected: $topic")));
//     //  Navigate after value saved
//     Navigator.pushNamed(context, RouteNames.signinScreenSecond);
//   }
// }
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninViewModel extends ChangeNotifier {
  final List<String> topics = [
    "Weight (Fat) Loss: Fat-Burning Diet & \n Exercise Plan",
    "Weight (Fat) Loss: Ketogenic Diet & \n Exercise Plan",
    "Weight (Fat) Loss: Diabetic-Friendly Diet & \n Exercise Plan",
    "Weight (Fat) Loss: High-Protein Diet & \n Exercise Plan",
    "Muscle Gain Diet & Exercise Plan",
  ];

  final List<bool> _isVisible = [false, false, false, false, false];
  List<bool> get isVisible => _isVisible;

  SigninViewModel() {
    _animateButtonsSequentially();
  }

  /// Sequential animation for button appearance
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < topics.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle topic button click
  Future<void> onTopicSelected(BuildContext context, String topic) async {
    final prefs = await SharedPreferences.getInstance();

    String planType = '';

    if (topic == "Weight (Fat) Loss: Fat-Burning Diet & Exercise Plan") {
      planType = 'weight_fat_loss';
    } else if (topic == "Weight (Fat) Loss: Ketogenic Diet & Exercise Plan") {
      planType = 'weight_loss_ketogenic';
    } else if (topic == "Weight (Fat) Loss: Diabetic-Friendly Diet & Exercise Plan") {
      planType = 'weight_loss_diabetic';
    } else if (topic == "Weight (Fat) Loss: High-Protein Diet & Exercise Plan") {
      planType = 'high_protein';
    } else if (topic == "Muscle Gain Diet & Exercise Plan") {
      planType = 'muscle_gain';
    }

    // Always use lowercase consistent key
    await prefs.setString('plan_type', planType);
    // Optional: reload to ensure value syncs
    await prefs.reload();
    final selectedTopic = prefs.getString('plan_type');
    debugPrint('Saved plan_type: $selectedTopic');
    
    // Navigate after value saved
    Navigator.pushNamed(context, RouteNames.signinScreenSecond);
  }
}