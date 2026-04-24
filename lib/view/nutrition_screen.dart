import 'package:aifitness/res/widgets/signin_third_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/nutration_screen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NutritionScreenViewModel>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninThirdAppBar(title: "Nutrition"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                /// Nutrition Plan Overview box
                _buildSectionBox(
                  title: "Nutrition Plan Overview",
                  children: [
                    _buildRow("Current Weight:", "60 kg"),
                    _buildRow("Milestone 1 Target:", "49.8 kg"),
                    _buildRow("Daily Calories:", "1351.4 Kcal/Day"),
                  ],
                ),
                const SizedBox(height: 20),

                /// Macronutrient Split box
                _buildSectionBox(
                  title: "Macronutrient Split:",
                  children: [
                    _buildRow("Protein & Carbs:", "40% (540.56 kcal)"),
                    _buildRow("Fats:", "20% (270.28 kcal)"),
                  ],
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Tap the View Week's Plan button to\nsee your plan for this week",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),

                /// View Week's Plan button
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 220,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        vm.openWeeksPlan(context);
                        Navigator.pushNamed(context, RouteNames.viewPlanScreen);
                      },
                      child: const Text(
                        "View Week's Plan",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildSectionBox({
    required String title,
    required List<Widget> children,
  }) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: OutlinedButton(
          onPressed: () => {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
            side: BorderSide(color: AppColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.backgroundColor,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildRow(String label, String value) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label $value",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            // Text(
            //   value,
            //   style: const TextStyle(fontSize: 14, color: Colors.black87),
            // ),
          ],
        ),
      ),
    );
  }
}
