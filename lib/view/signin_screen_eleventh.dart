import 'package:aifitness/res/widgets/ManualEntryScreen.dart';
import 'package:aifitness/res/widgets/SigninCurrentBFPAppBar.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_eleventh_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenEleventh extends StatelessWidget {
  const SigninScreenEleventh({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninEleventhViewModel(),
      child: const _SigninScreenEleventhBody(),
    );
  }
}

class _SigninScreenEleventhBody extends StatelessWidget {
  const _SigninScreenEleventhBody();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninCurrentBFPAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- Description ---
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
                      "If you have done a body composition \n analysis, you can manually enter your \n body fat percentage.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- Manual Entry Button ---
                Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton(
                    onPressed: () {
                      showManualEntryDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: AppColors.bolderColor,
                        width: 1.4, // (optional) you can change thickness
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Tap to Enter Manually",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // --- OR text ---
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    "OR",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // --- Instruction ---
                const Text(
                  "Select your body fat percentage from the \n reference images to support your fitness goals.",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                // --- Grid of images with border selection ---
                Expanded(
                  child: Consumer<SigninEleventhViewModel>(
                    builder: (context, viewModel, _) {
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: viewModel.bodyFatImages.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.bodyFatImages[index];
                            final isSelected = viewModel.selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                viewModel.selectIndex(index);
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.signinScreenTwelve,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.bolderColor
                                        : Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          item['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${item['percentage']}%", // Fixed here
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
