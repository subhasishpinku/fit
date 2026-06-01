import 'dart:convert';
import 'package:aifitness/data/network/api_service.dart';
import 'package:aifitness/models/device_profile_model.dart';
import 'package:aifitness/models/weight_summary_model.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';

// class DeviceDashboardViewModel extends ChangeNotifier {
//   final ApiService _apiService = ApiService();

//   bool isLoading = false;

//   List<dynamic> profileList = [];

//   Map<String, dynamic>? activeProfile;

//   Future<void> getAllProfiles() async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       final response =
//           await _apiService.postContractRequest(
//         "get-all-machine-profiles",
//         {
//           "device_id": "123456jhg",
//         },
//       );

//       if (response["success"] == true) {
//         profileList = response["data"] ?? [];

//         activeProfile = profileList.firstWhere(
//           (profile) =>
//               profile["machine_profile_active"] ==
//               "1",
//           orElse: () => profileList.first,
//         );
//       }
//     } catch (e) {
//       print("ERROR => $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   String getProfileImage() {
//     if (activeProfile == null) {
//       return "assets/images/avtarMale/male_avtar1.jpg";
//     }

//     final profilePic =
//         activeProfile!["profile_pic"];

//     if (profilePic == null ||
//         profilePic.toString().isEmpty) {
//       return "assets/images/avtarMale/male_avtar1.jpg";
//     }

//     return "assets/images/avtarMale/$profilePic.jpg";
//   }

//   String getUserName() {
//     if (activeProfile == null) {
//       return "Guest";
//     }

//     return activeProfile!["name"] ?? "Guest";
//   }

//   String getMemberSince() {
//     if (activeProfile == null) {
//       return "";
//     }

//     final days =
//         activeProfile!["no_of_days_registered"] ??
//             0;

//     return "Registered $days days ago";
//   }

//   String getCurrentWeight() {
//     try {
//       if (activeProfile == null) {
//         return "0 KG";
//       }

//       final dashboardData =
//           activeProfile!["current_dashboard_data"];

//       if (dashboardData == null) {
//         return "0 KG";
//       }

//       final decoded = dashboardData is String
//           ? jsonDecode(dashboardData)
//           : dashboardData;

//       return decoded["current_weight_formatted"] ??
//           "0 KG";
//     } catch (e) {
//       return "0 KG";
//     }
//   }

//   String getTargetWeight() {
//     try {
//       if (activeProfile == null) {
//         return "0 KG";
//       }

//       final dashboardData =
//           activeProfile!["current_dashboard_data"];

//       if (dashboardData == null) {
//         return "0 KG";
//       }

//       final decoded = dashboardData is String
//           ? jsonDecode(dashboardData)
//           : dashboardData;

//       return decoded["target_weight_formatted"] ??
//           "0 KG";
//     } catch (e) {
//       return "0 KG";
//     }
//   }
// }

import 'package:aifitness/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceDashboardViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;

  List<DeviceProfileModel> profiles = [];

  DeviceProfileModel? activeProfile;

  List<WeightSummaryModel> weightList = [];

Future<void> getAllProfiles(BuildContext context) async {
  try {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString("device_id");

    final response = await _apiService.postContractRequest(
      "get-all-machine-profiles",
      {"device_id": deviceId},
    );

    if (response["success"] == true) {
      final data = response["data"] as List;

      profiles = data
          .map((e) => DeviceProfileModel.fromJson(e))
          .toList();

      // Debug
      for (final p in profiles) {
        debugPrint(
          "Profile => id=${p.id}, active='${p.machineProfileActive}'",
        );
      }

      /// Find active profile safely
      final activeIndex = profiles.indexWhere(
        (e) => e.machineProfileActive.trim() == "1",
      );

      if (activeIndex != -1) {
        activeProfile = profiles[activeIndex];
      } else {
        activeProfile = profiles.isNotEmpty ? profiles.first : null;
      }

      generateWeightSummary();
    } else {
      Navigator.pushNamed(context, RouteNames.addMember);
    }
  } catch (e) {
    debugPrint("ERROR => $e");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  /// ================= WEIGHT SUMMARY =================

  void generateWeightSummary() {
    weightList.clear();

    try {
      final dashboard = activeProfile?.dashboardJson ?? {};

      final newAppData = dashboard["new_app_data"] ?? {};

      final phaseSummary = newAppData["phase_summary_dynamic"] ?? [];

      final createdDate = formatDate(activeProfile?.createdAt);

      final updatedDate = formatDate(activeProfile?.updatedAt);

      /// CURRENT WEIGHT
      weightList.add(
        WeightSummaryModel(
          weight:
              dashboard["current_weight_formatted"]?.toString().replaceAll(
                "KG",
                "",
              ) ??
              "0",
          date: updatedDate,
        ),
      );

      /// PHASE DATA
      for (int i = 0; i < phaseSummary.length; i++) {
        final item = phaseSummary[i];

        /// START WEIGHT
        weightList.add(
          WeightSummaryModel(
            weight: item["start_weight"].toString(),
            date: createdDate,
          ),
        );

        /// END WEIGHT
        weightList.add(
          WeightSummaryModel(
            weight: item["end_weight"].toString(),
            date: updatedDate,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// DATE FORMAT
  String formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return "--";
    }

    try {
      final parsed = DateTime.parse(date);

      return "${parsed.day.toString().padLeft(2, '0')}-"
          "${parsed.month.toString().padLeft(2, '0')}-"
          "${parsed.year}";
    } catch (e) {
      return "--";
    }
  }

  /// PROFILE IMAGE
  String getProfileImage() {
    if (activeProfile?.profilePic == null) {
      return "assets/images/avtarMale/male_avtar1.jpg";
    }

    return "assets/images/avtarMale/${activeProfile!.profilePic}.jpg";
  }

  /// USER NAME
  String getUserName() {
    return activeProfile?.name ?? "Guest";
  }

  /// MEMBER SINCE
  String getMemberSince() {
    // return "Registered ${activeProfile?.noOfDaysRegistered ?? 0} days ago";
    return "Active Profile";
  }
}
