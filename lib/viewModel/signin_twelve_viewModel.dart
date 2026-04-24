import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninTwelveViewModel extends ChangeNotifier {
  int? selectedIndex;
  List<Map<String, String>> bodyFatImages = [];

  /// Male target body fat images
  final List<Map<String, String>> maleBodyFatImages = [
    {'percent': '9%', 'image': 'assets/images/Desired/9.png'},
    {'percent': '11%', 'image': 'assets/images/Desired/11.png'},
    {'percent': '13%', 'image': 'assets/images/Desired/13.png'},
    {'percent': '15%', 'image': 'assets/images/Desired/15.png'},
    {'percent': '17%', 'image': 'assets/images/Desired/17.png'},
    {'percent': '19%', 'image': 'assets/images/Desired/19.png'},
    {'percent': '21%', 'image': 'assets/images/Desired/21.png'},
    {'percent': '23%', 'image': 'assets/images/Desired/23.png'},
    {'percent': '25%', 'image': 'assets/images/Desired/25.png'},
  ];

  /// Female target body fat images
  final List<Map<String, String>> femaleBodyFatImages = [
    {'percent': '9%', 'image': 'assets/images/Desired/9t.png'},
    {'percent': '11%', 'image': 'assets/images/Desired/11t.png'},
    {'percent': '13%', 'image': 'assets/images/Desired/13t.png'},
    {'percent': '15%', 'image': 'assets/images/Desired/15t.png'},
    {'percent': '17%', 'image': 'assets/images/Desired/17t.png'},
    {'percent': '19%', 'image': 'assets/images/Desired/19t.png'},
    {'percent': '21%', 'image': 'assets/images/Desired/21t.png'},
    {'percent': '23%', 'image': 'assets/images/Desired/23t.png'},
    {'percent': '25%', 'image': 'assets/images/Desired/25t.png'},
  ];

  SigninTwelveViewModel() {
    loadGender();
  }

  /// 🔹 Load gender & assign correct list
  Future<void> loadGender() async {
    final prefs = await SharedPreferences.getInstance();
    final gender = prefs.getString('gender'); // 'M' or 'F'

    bodyFatImages =
        (gender == 'F') ? femaleBodyFatImages : maleBodyFatImages;

    notifyListeners();
  }

  /// 🔹 Select + Save target BFP
  Future<void> selectIndex(int index) async {
    if (index < 0 || index >= bodyFatImages.length) return;

    selectedIndex = index;

    final percentage = bodyFatImages[index]['percent']!;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('target_bfp', percentage);

    debugPrint('Saved target_bfp: $percentage');

    notifyListeners();
  }
}
