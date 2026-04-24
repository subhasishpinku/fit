import 'package:flutter/material.dart';

class SigninTwentyFiveViewModel extends ChangeNotifier {
  double _progress = 0;
  double get progress => _progress;

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
