import 'dart:convert';

import 'package:aifitness/models/login_response.dart';
import 'package:aifitness/res/widgets/dashboard.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../repository/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final LoginRepository _repository = LoginRepository();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;

  int networkStatus = 1; // 1 = online, 0 = offline

  void updateNetworkStatus(int status) {
    networkStatus = status;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Future<void> login(BuildContext context) async {
  //   if (!formKey.currentState!.validate()) return;

  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     String? device = prefs.getString("device_id");
  //     String deviceId = device!; // Replace with real deviceId

  //     final request = LoginRequest(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //       deviceId: deviceId,
  //     );

  //     final response = await _repository.login(request);

  //     _isLoading = false;
  //     notifyListeners();

  //     if (response.success) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text(response.message)));

  //       print("TOKEN => ${response.token}");
  //       print("USER => ${response.userDetails.name}");

  //       // Navigate to home:
  //       Navigator.pushNamed(context, RouteNames.signinScreenTwentyFive);
  //     } else {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text(response.message)));
  //     }
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     print(e);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Error: $e")));
  //   }
  // }

  /// Store device ID
  Future<void> initDeviceId() async {
    final plugin = MobileDeviceIdentifier();
    String deviceId;

    try {
      deviceId = await plugin.getDeviceId() ?? 'Unknown Device ID';
    } catch (e) {
      deviceId = 'Failed to get device ID';
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("device_id", deviceId);
  }

  LoginViewModel() {
    // Demo credentials
    // emailController.text = "debjit23@gmail.com";
    // passwordController.text = "Test@123";
    emailController.text = "";
    passwordController.text = "";
    initDeviceId();
  }
  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String? device = prefs.getString("device_id");
      String deviceId = device!; // Replace with real deviceId
      await prefs.setString('password', passwordController.text.trim());
      final response = await Dio().post(
        "https://aipoweredfitness.com/api/login",
        data: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "device_id": deviceId,
        },
      );
      print("RAW RESPONSE: ${response.data} $device");

      // FIX: JSON decode first
      final Map<String, dynamic> json = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final loginResponse = LoginResponse.fromJson(json);
      await prefs.setString(
        'name',
        loginResponse.data!.userDetails!.name.toString(),
      );
      await prefs.setString(
        'name',
        loginResponse.data!.userDetails!.name.toString(),
      );
      await prefs.setString(
        'email',
        loginResponse.data!.userDetails!.email.toString(),
      );
      await prefs.setString(
        'image_full_url',
        loginResponse.data!.userDetails!.imageFullUrl.toString(),
      );
      //loginResponse.data!.userDetails!.id!
      //2870
      int? userIds = loginResponse.data!.userDetails!.id;
      await prefs.setInt('user_id', userIds!);
      print("UserIdResponse ${loginResponse.data!.userDetails!.id}");
      _isLoading = false;
      notifyListeners();

      if (loginResponse.success == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login Successful!")));
        Navigator.pushNamed(context, RouteNames.dashboard);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid Credentials!")));
        throw Exception(loginResponse.message);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid Credentials!")));
      throw Exception("Invalid Credentials: $e");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
