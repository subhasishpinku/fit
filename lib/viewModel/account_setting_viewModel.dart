import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingViewModel extends ChangeNotifier {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  String userName = "ghhjh";
  String userEmail = "fhuhj@gmail.com";
  String joined = "1 day ago";

  File? get profileImage => _profileImage;

  Future<void> pickProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}
