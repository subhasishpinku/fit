import 'dart:io';
import 'package:aifitness/repository/ImageRepository.dart';
import 'package:aifitness/viewModel/weight_progress_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BodyImageProgressViewModel extends ChangeNotifier {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  List<File> get images => _images;

  /// Open gallery to pick image
  Future<void> addImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // compress a bit
      );

      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  final ImageRepository _repo = ImageRepository();

  bool loading = false;
  List<WeightProgressData> aiDetails = [];

  Future<void> fetchAiDetails(String deviceId, int userId) async {
    loading = true;
    notifyListeners();

    try {
      final res = await _repo.getAiUserDetails(
        deviceId: deviceId,
        userId: userId,
      );

      aiDetails = res.data;

      if (aiDetails.isNotEmpty) {
        print("First Image URL: ${aiDetails[0].progressImageUrl}");
      }
    } catch (e) {
      debugPrint("Error fetching AI details: $e");
      print("Error fetching AI details: $e");
    }

    loading = false;
    notifyListeners();
  }

  /// Remove selected image
  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }
}
