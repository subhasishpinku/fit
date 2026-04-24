import 'package:aifitness/res/widgets/signin_second_appbars.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_tenth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenTenth extends StatelessWidget {
  const SigninScreenTenth({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninTenthViewModel(),
      child: const _SigninScreenTenthBody(),
    );
  }
}

class _SigninScreenTenthBody extends StatelessWidget {
  const _SigninScreenTenthBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninTenthViewModel>(context);
    final waists = provider.waistMeasurements;
    final selectedWaist = provider.selectedWaist;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninSecondAppBars(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- Question ---
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
                          "?What is your waist measurement",
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

                // // --- Selected Value ---
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
                //         "$selectedWaist cm",
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

                // --- Instruction ---
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
                          "Please select your waist measurement\n.from the dropdown",
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

                // --- Scroll Picker ---
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
                        initialItem: waists.indexOf(selectedWaist),
                      ),
                      onSelectedItemChanged: (index) {
                        provider.setSelectedWaist(waists[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: waists.length,
                        builder: (context, index) {
                          final waist = waists[index];
                          return Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                "$waist cm",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: waist == selectedWaist
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
                          RouteNames.signinScreenEleventh,
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

                // --- NEXT Button ---
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
                        debugPrint("Selected Waist: $selectedWaist cm");
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreenEleventh,
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
