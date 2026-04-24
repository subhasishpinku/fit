import 'package:aifitness/res/widgets/HipMeasurementAppBars.dart';
import 'package:aifitness/res/widgets/signin_second_appbars.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_ninth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenNinth extends StatelessWidget {
  const SigninScreenNinth({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninNinthViewModel(),
      child: const _SigninScreenNinthBody(),
    );
  }
}

class _SigninScreenNinthBody extends StatelessWidget {
  const _SigninScreenNinthBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninNinthViewModel>(context);
    final hips = provider.hipMeasurements;
    final selectedHip = provider.selectedHip;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const HipMeasurementAppBars(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Question
                Align(
                  alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
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
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "?What is your hip measurement",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 30),

                // // Selected Value
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 12,
                //       vertical: 10,
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.signInButtonColor,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Directionality(
                //       textDirection: TextDirection.ltr,
                //       child: Text(
                //         "$selectedHip cm",
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: AppColors.primaryColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),

                // Instruction
                Align(
                  alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
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
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Please select your hip measurement\n.from the dropdown",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Scroll Picker
                SizedBox(
                  height: 200,
                  child: Center(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      diameterRatio: 1.2,
                      squeeze: 1.2,
                      magnification: 1.1,
                      useMagnifier: true,
                      physics: const FixedExtentScrollPhysics(),
                      controller: FixedExtentScrollController(
                        initialItem: hips.indexOf(selectedHip),
                      ),
                      onSelectedItemChanged: (index) {
                        provider.setSelectedHip(hips[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: hips.length,
                        builder: (context, index) {
                          final hip = hips[index];
                          return Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                "$hip cm",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: hip == selectedHip
                                      ? AppColors.primaryColor
                                      : AppColors.primaryColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Align(
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
                            color: const Color.fromARGB(255, 252, 113, 21),
                          ),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreenTenth,
                        );
                      },
                      child: const Text(
                        "SKIP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // NEXT Button
                Align(
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
                          side: BorderSide(color: AppColors.bolderColor),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        debugPrint("Selected Hip: $selectedHip cm");
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreenTenth,
                        );
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
