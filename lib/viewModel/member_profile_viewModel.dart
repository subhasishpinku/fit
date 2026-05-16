import 'package:aifitness/data/network/api_service.dart';
import 'package:flutter/material.dart';

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

      final response = await _apiService.postRequest(
        "get-all-machine-profiles",
        {
          "device_id": "123456jhg",
        },
      );

      final data = response.data;

      if (data["success"] == true) {
        final List profileList = data["data"];

        profiles =
            profileList
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
}