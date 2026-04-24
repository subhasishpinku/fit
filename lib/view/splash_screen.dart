import 'package:aifitness/view/get_start_screen.dart';
import 'package:aifitness/view/get_start_screen_view.dart';
import 'package:aifitness/viewModel/splash_screen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? deviceId = "";
  String? email = "";
  String? password = "";
  String? imageFullUrl = "";
  String? name = "";
  int userId = 0;
  @override
  void initState() {
    super.initState();
    load();
  }
  load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt("user_id") ?? 0;
      deviceId = prefs.getString("device_id");
      name = prefs.getString("name");
      email = prefs.getString("email");
      imageFullUrl = prefs.getString("image_full_url");
      password = prefs.getString("password");
    });
    // ---- SESSION CHECK ----
    if (email != null &&
        password != null &&
        email!.isNotEmpty &&
        password!.isNotEmpty) {
      final vm = Provider.of<SplashScreenViewModel>(context, listen: false);
      vm.loadingState(context, email, password);
    } else {
      // Auto navigate after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetStartScreenView()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/cg55.jpg"), // your image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
