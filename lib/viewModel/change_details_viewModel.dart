import 'package:flutter/material.dart';
import '../models/change_details_model.dart';

class ChangeDetailsViewModel extends ChangeNotifier {
  ChangeDetailsModel details = ChangeDetailsModel();
  List<bool> _isExpanded = [true, true, true];

  List<bool> get isExpanded => _isExpanded;

  void toggleExpand(int index) {
    _isExpanded[index] = !_isExpanded[index];
    notifyListeners();
  }

  void updateHeight(String value) {
    details.height = value;
    notifyListeners();
  }

  void updateWeight(String value) {
    details.weight = value;
    notifyListeners();
  }

  void saveDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Alert"),
        content: const Text(
          "Changing your details will create a new exercise plan and your new plan will start from today. Do you want to proceed?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Details updated successfully!")),
              );
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );
  }
}
