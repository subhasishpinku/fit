import 'package:aifitness/res/widgets/SigninDietTypeAppBar.dart';
import 'package:aifitness/res/widgets/signin_topic_list.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/diet_type_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:provider/provider.dart';

class DietTypeScreen extends StatelessWidget {
  const DietTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DietTypeViewModel>(context);
    final options = provider.options;
    final isVisible = provider.isVisible;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninDietTypeAppBar(),
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
                    "?What are your food preferences\nChoose the ones that best describe your diet!",
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
              Text(
                "To create a nutrition plan that works best for\nyou, it's important to understand your food\n preferences and any dietary restrictions. Let\n us know what works for you!",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 15),

              // Animated option list
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
