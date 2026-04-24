import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_thirteen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MuscleGainScreen extends StatelessWidget {
  const MuscleGainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final payload = {
    //   "plan_type": "weight_fat_loss",
    //   "weight_value": "60.0",
    //   "gender": "M",
    //   "dob_age_year": "1980",
    //   "height_value": "150",
    //   "wo_time": 45,
    //   "target_bfp": "9",
    //   "current_bfp": "40",
    //   "activity_level": "Sedentary Exercise",
    //   "how_fast_to_reach_goal": "Easy",
    // };
    return ChangeNotifierProvider(
      create: (_) => SigninThirteenViewModel()..fetchFatLossDataFromPrefs(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: const SigninSecondAppBar(),
          body: SafeArea(
            child: Consumer<SigninThirteenViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.errorMessage != null) {
                  return Center(
                    child: Text('Error: ${viewModel.errorMessage}'),
                  );
                }

                if (viewModel.fatLossData == null) {
                  return const Center(child: Text('No data available'));
                }

                return const FatLossContent();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FatLossContent extends StatelessWidget {
  const FatLossContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SigninThirteenViewModel>(context);

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = vm.fatLossData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
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
                  "Based on Your Information, Here\nIs Your Fat Loss Target",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        // "BMI: ${data['BMI']}",
                        "BMI: ${data?['current_bmi']} (${data?['current_bmi_cat']})",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        // "Current Weight: ${data['CurrentWeight']}",
                        "Current Weight: ${data?['current_weight_value']}",

                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        // "Goal: ${data['Goal']  }",
                        "Goal: Target: ${data?['target_weight']} kg",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        // "Total Loss: ${data['TotalLoss']}",
                        "Total Gain: ${data?['weeks_to_target_dynamic']} kg in ~${data?['loss_gain_target_value']} weeks (${data?['loss_gain_target_value']} kg/week)",

                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Step 1: First Milestone",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  backgroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///  Target Weight + Duration
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "Target Weight: ${data?['phase_summary_dynamic'][0]['end_weight']} kg (~${data?['phase_summary_dynamic'][0]['duration_weeks']} weeks)",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),

                    ///  Current Intake
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "Current Intake: ${data?['current_calories_intake']} kcal/day",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),

                    ///  New Intake (dailyCalories - deficientCalories)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "New Intake: ${data?['phase_summary_dynamic'][0]['daily_calories']} kcal/day (${data?['phase_summary_dynamic'][0]['deficient_calories']} kcal)",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Step 2: Final Goal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  backgroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "Adjust calories again after reaching ${data?['phase_summary_dynamic'][0]['end_weight']} kg",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tap the button to create your plan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.signinScreenFourteen);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  backgroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: AppColors.bolderColor),
                  ),
                ),
                child: Text(
                  "Create My Nutrition & Exercise Plan",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
