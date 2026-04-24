import 'dart:convert';

import 'package:aifitness/models/login_response.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends ChangeNotifier {
  bool _isLoading = false;

  Future<void> loadingState(
    BuildContext context,
    String? email,
    String? password,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String deviceId = prefs.getString("device_id") ?? "";

      final response = await Dio().post(
        "https://aipoweredfitness.com/api/login",
        data: {"email": email, "password": password, "device_id": deviceId},
      );

      final json = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final loginResponse = LoginResponse.fromJson(json);

      if (loginResponse.success == true) {
        await prefs.setString(
          'name',
          loginResponse.data!.userDetails!.name ?? "",
        );
        await prefs.setString(
          'email',
          loginResponse.data!.userDetails!.email ?? "",
        );
        await prefs.setString(
          'image_full_url',
          loginResponse.data!.userDetails!.imageFullUrl ?? "",
        );
        await prefs.setString('password', password ?? "");
        await prefs.setInt('user_id', loginResponse.data!.userDetails!.id ?? 0);

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.dashboard);
        }
      } else {
        throw Exception(loginResponse.message);
      }
    } catch (e) {
      print("Login failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
