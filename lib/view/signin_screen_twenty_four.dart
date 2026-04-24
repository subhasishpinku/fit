import 'package:aifitness/repository/RegisterRepository.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/services/network_service.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/RegisterViewModel.dart';
import 'package:aifitness/viewModel/signin_twentyfour_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SigninScreenTwentyFour extends StatefulWidget {
  const SigninScreenTwentyFour({super.key});

  @override
  State<SigninScreenTwentyFour> createState() => _SigninScreenTwentyFourState();
}

class _SigninScreenTwentyFourState extends State<SigninScreenTwentyFour> {
  String _deviceId = 'Unknown';
  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();
  final uuid = Uuid();
  int status = 0;
  @override
  void initState() {
    super.initState();
    initDeviceId();
    // networking();
  }

  Future<void> initDeviceId() async {
    String deviceId;
    String id = uuid.v4();

    try {
      deviceId =
          await _mobileDeviceIdentifierPlugin.getDeviceId() ??
          'Unknown platform version';
    } on PlatformException {
      deviceId = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() async {
      _deviceId = deviceId;
      // print("_deviceId $_deviceId");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("device_id", _deviceId);
      print(prefs.getString("device_id"));
      print("UUID ${id}  ${prefs.getString("device_id")}");
    });
  }

  // networking() {
  //   NetworkService().startListener((isConnected) {
  //     setState(() {
  //       status = isConnected ? 1 : 0;
  //     });

  //     print(isConnected ? "Connected" : "No Internet");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider(
        create: (_) => RegisterViewModel(RegisterRepository1()),
        child: Consumer<RegisterViewModel>(
          builder: (context, viewModel, _) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: const SigninSecondAppBar(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 15,
                          ),
                          side: BorderSide(color: AppColors.backgroundColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: AppColors.primaryColor,
                          backgroundColor: AppColors.signInButtonColor,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "To create your profile and save your data, we'll need some basic personal information. "
                          "This way, you won’t have to enter it again each time you open the app.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    IntrinsicWidth(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 15,
                          ),
                          side: BorderSide(color: AppColors.backgroundColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: AppColors.primaryColor,
                          backgroundColor: AppColors.signInButtonColor,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Don’t worry — we won’t send you any unwanted emails or spam.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Please enter your personal \n .information to proceed",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Full Name
                    // Directionality(
                    //   textDirection: TextDirection.ltr,
                    //   child: TextField(
                    //     controller: viewModel.fullNameController,
                    //     decoration: InputDecoration(
                    //       labelText: "Full Name",
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //         borderSide: BorderSide(
                    //           color: AppColors.primaryColor,
                    //           width: 2,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: viewModel.fullNameController,
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            hintText: "Full Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    // Directionality(
                    //   textDirection: TextDirection.ltr,
                    //   child: TextField(
                    //     controller: viewModel.emailController,
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //       labelText: "Email",
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //         borderSide: BorderSide(
                    //           color: AppColors.primaryColor,
                    //           width: 2,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: viewModel.emailController,
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    // Directionality(
                    //   textDirection: TextDirection.ltr,
                    //   child: TextField(
                    //     controller: viewModel.passwordController,
                    //     obscureText: !viewModel.isPasswordVisible,
                    //     decoration: InputDecoration(
                    //       labelText: "Password",
                    //       suffixIcon: IconButton(
                    //         icon: Icon(
                    //           viewModel.isPasswordVisible
                    //               ? Icons.visibility
                    //               : Icons.visibility_off,
                    //         ),
                    //         onPressed: viewModel.togglePasswordVisibility,
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //         borderSide: BorderSide(
                    //           color: AppColors.primaryColor,
                    //           width: 2,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextField(
                          controller: viewModel.passwordController,
                          obscureText: !viewModel.isPasswordVisible,

                          decoration: InputDecoration(
                            labelText: "Password",

                            // ---- DESIGN MATCHING YOUR IMAGE ----
                            filled: true, // enables background color
                            fillColor: const Color(
                              0xFFF2F2F2,
                            ), // light grey background

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),

                            // No visible border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),

                            // Eye icon
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: viewModel.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Center(
                    //   child: SizedBox(
                    //     width: 200,
                    //     height: 50,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.white.withOpacity(0.8),
                    //         side: const BorderSide(
                    //           color: AppColors.bolderColor,
                    //           width: 2,
                    //         ),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         elevation: 0,
                    //       ),

                    //       // onPressed: () {
                    //       //   if (status == 0) {
                    //       //     ScaffoldMessenger.of(context).showSnackBar(
                    //       //       const SnackBar(
                    //       //         content: Text("No Internet Connection"),
                    //       //         duration: Duration(seconds: 2),
                    //       //       ),
                    //       //     );
                    //       //     return;
                    //       //   }

                    //       //   viewModel.onNextPressed(context);
                    //       // },
                    //       onPressed: () async {
                    //         bool isConnected = await NetworkService()
                    //             .hasInternet();

                    //         if (!isConnected) {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(
                    //               content: Text("No Internet Connection"),
                    //               duration: Duration(seconds: 2),
                    //             ),
                    //           );
                    //           return;
                    //         }

                    //         viewModel.onNextPressed(context);
                    //       },
                    //       child: Text(
                    //         "Next",
                    //         style: TextStyle(
                    //           color: AppColors.primaryColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           letterSpacing: 1,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.8),
                            side: const BorderSide(
                              color: AppColors.bolderColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          onPressed: viewModel.loading
                              ? null // Disable button when loading
                              : () async {
                                  bool isConnected = await NetworkService()
                                      .hasInternet();
                                  if (!isConnected) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("No Internet Connection"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  viewModel.onNextPressed(context);
                                },
                          child: viewModel.loading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Next",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: SizedBox(
                    //     width: 200,
                    //     height: 50,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.white.withOpacity(0.8),
                    //         side: const BorderSide(
                    //           color: AppColors
                    //               .bolderColor, // <-- added custom border color
                    //           width: 2,
                    //         ),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         elevation: 0,
                    //       ),
                    //       onPressed: () => viewModel.onNextPressed(context),
                    //       child: Text(
                    //         "Next",
                    //         style: TextStyle(
                    //           color: AppColors
                    //               .primaryColor, // <-- optional: match text color too
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           letterSpacing: 1,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Center(
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.primaryColor,
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 40,
                    //         vertical: 14,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     onPressed: () => viewModel.onNextPressed(context),
                    //     child: const Text(
                    //       "Next",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    // Text(
                    //   "Device ID: $_deviceId",
                    //   style: const TextStyle(fontSize: 12, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
