import 'package:aifitness/res/widgets/signin_header.dart';
import 'package:aifitness/res/widgets/signin_topbar.dart';
import 'package:aifitness/res/widgets/signin_topic_list.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/signin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninViewModel>(context);
    final topics = provider.topics;
    final isVisible = provider.isVisible;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SigninTopBar(),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const SigninHeader(),
                const SizedBox(height: 20),
                Text(
                  "Select a topic below",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SigninTopicList(
                    topics: topics,
                    isVisible: isVisible,
                    onTopicSelected: provider.onTopicSelected,
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
