import 'dart:ui';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showManualEntryDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.white.withOpacity(0), width: 0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BFP (%)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Enter your body fat percentage.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "%",
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.20),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        // Expanded(
                        //   child: OutlinedButton(
                        //     onPressed: () => Navigator.pop(context),
                        //     style: OutlinedButton.styleFrom(
                        //       foregroundColor: Colors.black,
                        //       side: BorderSide(
                        //         color: Colors.black.withOpacity(0.2),
                        //       ),
                        //     ),
                        //     child: const Text("Cancel"),
                        //   ),
                        // ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 120,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: AppColors.bolderColor,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 120,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: AppColors.bolderColor,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.setString(
                                    'current_bfp',
                                    controller.toString(),
                                  );

                                  final savedBfp = prefs.getString(
                                    'current_bfp',
                                  );
                                  print('Saved current_bfp: $savedBfp');
                                  debugPrint("Body Fat: ${controller.text}");
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.signinScreenTwelve,
                                  );
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       final prefs =
                        //           await SharedPreferences.getInstance();

                        //       await prefs.setString(
                        //         'current_bfp',
                        //         controller.toString(),
                        //       );

                        //       final savedBfp = prefs.getString('current_bfp');
                        //       print('Saved current_bfp: $savedBfp');
                        //       debugPrint("Body Fat: ${controller.text}");
                        //       Navigator.pushNamed(
                        //         context,
                        //         RouteNames.signinScreenTwelve,
                        //       );
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.black,
                        //       foregroundColor: Colors.white,
                        //     ),
                        //     child: const Text("Save"),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
