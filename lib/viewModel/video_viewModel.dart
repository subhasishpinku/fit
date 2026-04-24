import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';

class VideoViewModel extends ChangeNotifier {
  /// Called when user clicks "Complete"
  void onComplete(BuildContext context) {
    // Example: Go to next workout screen
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("Warm-up complete! Let's begin workout ")),
    // );
    Navigator.pushNamed(context, RouteNames.iamReady);

    // Example navigation (uncomment and update route name if needed)
    // Navigator.pushNamed(context, RouteNames.exerciseListDetails);
  }
}
