import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninEleventhViewModel extends ChangeNotifier {
  int? selectedIndex;
  List<Map<String, dynamic>> bodyFatImages = [];

  /// Male images
  final List<Map<String, dynamic>> maleBodyFatImages = [
    {'image': 'assets/images/Current/40.png', 'percentage': 40},
    {'image': 'assets/images/Current/37.png', 'percentage': 37},
    {'image': 'assets/images/Current/33.png', 'percentage': 33},
    {'image': 'assets/images/Current/30.png', 'percentage': 30},
    {'image': 'assets/images/Current/27.png', 'percentage': 27},
    {'image': 'assets/images/Current/24.png', 'percentage': 24},
    {'image': 'assets/images/Current/21.png', 'percentage': 21},
    {'image': 'assets/images/Current/18.png', 'percentage': 18},
    {'image': 'assets/images/Current/15.png', 'percentage': 15},
  ];

  /// Female images
  final List<Map<String, dynamic>> femaleBodyFatImages = [
    {'image': 'assets/images/Current/40c.png', 'percentage': 40},
    {'image': 'assets/images/Current/37c.png', 'percentage': 37},
    {'image': 'assets/images/Current/33c.png', 'percentage': 33},
    {'image': 'assets/images/Current/30c.png', 'percentage': 30},
    {'image': 'assets/images/Current/27c.png', 'percentage': 27},
    {'image': 'assets/images/Current/24c.png', 'percentage': 24},
    {'image': 'assets/images/Current/21c.png', 'percentage': 21},
    {'image': 'assets/images/Current/18c.png', 'percentage': 18},
    {'image': 'assets/images/Current/15c.png', 'percentage': 15},
  ];

  SigninEleventhViewModel() {
    loadGender();
  }

  /// Load gender and images
  Future<void> loadGender() async {
    final prefs = await SharedPreferences.getInstance();
    final gender = prefs.getString('gender');

    bodyFatImages = (gender == 'F') ? femaleBodyFatImages : maleBodyFatImages;

    notifyListeners();
  }

  ///  SELECT + SAVE PERCENTAGE
  Future<void> selectIndex(int index) async {
    if (index < 0 || index >= bodyFatImages.length) return;

    selectedIndex = index;

    final percentage = bodyFatImages[index]['percentage'].toString();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_bfp', percentage);

    debugPrint('Saved current_bfp: $percentage');

    notifyListeners();
  }
}
