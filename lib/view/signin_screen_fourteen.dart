import 'package:aifitness/res/widgets/SigninWorksOutDaysAppBar.dart';
import 'package:aifitness/res/widgets/signin_topic_list.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/sigin_foutreen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:provider/provider.dart';

class SigninScreenFourteen extends StatelessWidget {
  const SigninScreenFourteen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninFourteenViewModel>(context);
    final options = provider.options;
    final isVisible = provider.isVisible;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninWorksOutDaysAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// Header Question
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
                    "Which days would you like to\n?workout each week",
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

              const Text(
                "Please select one of the options below",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              /// Animated Option Buttons (reusable list)
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
            ],
          ),
        ),
      ),
    );
  }
}
