import 'package:aifitness/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/member_profile_model.dart';

class MemberProfileViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MemberProfileModel> profiles = [];

  bool isLoading = false;

  int selectedIndex = 0;

  Future<void> getProfiles() async {
    try {
      isLoading = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString("device_id");
      final response = await _apiService.postRequest(
        "get-all-machine-profiles",
        {"device_id": deviceId},
      );

      final data = response.data;

      if (data["success"] == true) {
        final List profileList = data["data"];

        profiles = profileList
            .map((e) => MemberProfileModel.fromJson(e))
            .toList();

        /// machine_profile_active == 1 selected
        final activeIndex = profiles.indexWhere(
          (e) => e.machineProfileActive == "1",
        );

        if (activeIndex != -1) {
          selectedIndex = activeIndex;
        }
      }
    } catch (e) {
      debugPrint("ERROR => $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeProfile(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  MemberProfileModel? get selectedProfile {
    if (profiles.isEmpty) return null;
    return profiles[selectedIndex];
  }
Future<bool> activateProfile(String profileId) async {
  try {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString("device_id");
      print("activateProfile $profileId  $deviceId");

    final response = await _apiService.postRequest(
      "make-machine-profile-active",
      {
        "device_id": deviceId,
        "profile_id": profileId,
      },
    );

    final data = response.data;

    if (data["success"] == true) {

      /// update local list
      for (int i = 0; i < profiles.length; i++) {
        profiles[i] = profiles[i].copyWith(
          machineProfileActive:
              profiles[i].id.toString() == profileId ? "1" : "0",
        );

        if (profiles[i].id.toString() == profileId) {
          selectedIndex = i;
        }
      }

      notifyListeners();
      return true;
    }

    return false;
  } catch (e) {
    debugPrint("Activate ERROR => $e");
    return false;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
  // Fixed activateProfile method using copyWith


  // Fixed deleteProfile method
  Future<bool> deleteProfile(String profileId) async {
    try {
      isLoading = true;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString("device_id");
      
      final response = await _apiService.postRequest(
        "delete-machine-profile",
        {
          "device_id": deviceId,
          "profile_id": profileId,
        },
      );
      
      final data = response.data;
      
      if (data["success"] == true) {
        // Remove from local list
        final index = profiles.indexWhere((p) => p.id.toString() == profileId);
        if (index != -1) {
          profiles.removeAt(index);
          
          // Adjust selected index
          if (selectedIndex >= profiles.length) {
            selectedIndex = profiles.length - 1;
          }
          if (selectedIndex < 0 && profiles.isNotEmpty) {
            selectedIndex = 0;
          }
        }
        
        debugPrint("Profile deleted successfully: $profileId");
        return true;
      } else {
        debugPrint("Failed to delete profile: ${data["message"]}");
        return false;
      }
    } catch (e) {
      debugPrint("ERROR deleting profile: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}