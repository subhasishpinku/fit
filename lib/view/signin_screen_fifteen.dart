import 'package:aifitness/res/widgets/SigninWorkoutModeAppBar.dart';
import 'package:aifitness/res/widgets/signin_topic_list.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/sigin_fifteen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:provider/provider.dart';

class SigninScreenFifteen extends StatelessWidget {
  const SigninScreenFifteen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninFifteenViewModel>(context);
    final options = provider.options;
    final isVisible = provider.isVisible;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninWorkoutModeAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                    "Select your preferred workout\nenvironment",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Reusable animated list
              Expanded(
                child: SigninTopicList(
                  topics: options,
                  isVisible: isVisible,
                  onTopicSelected: (context, topic) {
                    final index = options.indexOf(topic);
                    provider.selectOption(context, index);
                    provider.onNextPressed(context);
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
