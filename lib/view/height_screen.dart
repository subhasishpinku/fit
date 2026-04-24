import 'package:aifitness/res/widgets/SigninHeightAppBar.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/hight_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HightViewModel(),
      child: const _HeightScreenBody(),
    );
  }
}

class _HeightScreenBody extends StatelessWidget {
  const _HeightScreenBody();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HightViewModel>(context);
    final heights = provider.heights;
    final selectedHeight = provider.selectedHeight;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const SigninHeightAppBar(),
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
                  "Your height helps us accurately \n ,calculate your Body Mass Index (BMI) \n daily calorie needs, and customize your \n workout intensity and nutrition \n .recommendations ",
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
                        "?What’s your height",
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

              // --- Selected Height Display ---
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
                      "$selectedHeight cm",
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
                        "Please select your height\n.from the dropdown",
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

              // --- Height Picker ---
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
                      initialItem: heights.indexOf(selectedHeight),
                    ),
                    onSelectedItemChanged: (index) {
                      provider.setSelectedHeight(heights[index], context);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: heights.length,
                      builder: (context, index) {
                        final height = heights[index];
                        return Center(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "$height cm",
                              style: TextStyle(
                                fontSize: 22,
                                color: height == selectedHeight
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
                      debugPrint("Selected Height: $selectedHeight cm");
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
    );
  }
}
