import 'package:aifitness/repository/AccountSettingRepository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDeleteViewModel extends ChangeNotifier {
  final AccountSettingRepository _repo = AccountSettingRepository();
  bool isLoading = false;

  Future<void> deleteAccount(BuildContext context, int userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _repo.deleteProfile(userId);

      // response is already Map<String, dynamic>
      final Map<String, dynamic> responseMap = Map<String, dynamic>.from(
        response,
      );

      if (responseMap["success"] == true) {
        print("delete_Ac $userId ${responseMap["message"]}");

        debugPrint("delete_Ac $userId ${responseMap["message"]}");

        if (context.mounted) {
          // Clear previous snackbars and show the message
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  responseMap["message"] ?? "Account deleted successfully",
                ),
                duration: const Duration(seconds: 2),
              ),
            );
        }
        // Clear local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Delay to allow snackbar to show before navigation
        await Future.delayed(const Duration(seconds: 1));

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.getStartScreen,
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong!")),
          );
        }
      }
    } catch (e) {
      debugPrint("Error deleting profile: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error deleting profile.")),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
