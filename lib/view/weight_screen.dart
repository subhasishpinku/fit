import 'package:aifitness/res/widgets/SigninWeightAppBar.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/weight_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeightViewModel(),
      child: const _WeightScreenBody(),
    );
  }
}

class _WeightScreenBody extends StatelessWidget {
  const _WeightScreenBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightViewModel>(context);
    final weights = provider.weights;
    final selectedWeight = provider.selectedWeight;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninWeightAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- Description ---
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Knowing your weight helps us calculate \n your Body Mass Index (BMI), daily \n calorie requirements, and track your fat\n-loss or muscle-gain progress accurately.",
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
                      ),
                      onPressed: () {},
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "?What’s your weight",
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

                // --- Selected Weight Display ---
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.signInButtonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "${selectedWeight.toStringAsFixed(1)} Kg",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),

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
                          "Please select your weight\nfrom the dropdown.",
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

                // --- Weight Picker ---
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
                        initialItem: weights.indexOf(selectedWeight),
                      ),
                      onSelectedItemChanged: (index) {
                        provider.setSelectedWeight(weights[index],context);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: weights.length,
                        builder: (context, index) {
                          final weight = weights[index];
                          return Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                "${weight.toStringAsFixed(1)} Kg",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: weight == selectedWeight
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
                        debugPrint("Selected Weight: $selectedWeight Kg");
                        Navigator.pushNamed(
                          context,
                          RouteNames.targetChangeDetails,
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
