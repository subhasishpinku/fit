import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_sixth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SigninScreenSixth extends StatelessWidget {
  const SigninScreenSixth({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninSixthViewModel(),
      child: const _SigninScreenSixthBody(),
    );
  }
}

class _SigninScreenSixthBody extends StatelessWidget {
  const _SigninScreenSixthBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninSixthViewModel>(context);
    final years = provider.years;
    final selectedYear = provider.selectedYear;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninSecondAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Tell us your age so we can tailor your \nworkouts and nutrition plan to match \nyour metabolism, recovery rate, and \n.fitness needs",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

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
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "?What’s your birth year",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // --- Selected Year ---
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
                //     child: Text(
                //       "$selectedYear",
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.primaryColor,
                //       ),
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 30),

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
                          "Please select your birth year\nfrom the dropdown below",
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

                const SizedBox(height: 20),

                // --- Year Picker ---
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
                        initialItem: years.indexOf(selectedYear),
                      ),
                      onSelectedItemChanged: (index) {
                        provider.setSelectedYear(years[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: years.length,
                        builder: (context, index) {
                          final year = years[index];
                          return Center(
                            child: Text(
                              "$year",
                              style: TextStyle(
                                fontSize: 22,
                                color: year == selectedYear
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // --- NEXT BUTTON ---
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
                        debugPrint("Selected Year: $selectedYear");
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreenSeventh,
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
