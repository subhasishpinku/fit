import 'package:aifitness/res/widgets/SigninTargetAppBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/signin_twelve_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreenTwelve extends StatefulWidget {
  const SigninScreenTwelve({super.key});

  @override
  State<SigninScreenTwelve> createState() => _SigninScreenTwelveState();
}

class _SigninScreenTwelveState extends State<SigninScreenTwelve> {
  String? savedBfp;

  @override
  void initState() {
    super.initState();
    _loadCurrentBfp();
  }

  Future<void> _loadCurrentBfp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedBfp = prefs.getString('current_bfp');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninTwelveViewModel(),
      child: Consumer<SigninTwelveViewModel>(
        builder: (context, viewModel, _) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: const SigninTargetAppBar(),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),

                      Text(
                        "You're currently at ${savedBfp ?? '--'}% body fat \n percentage.What's your goal body fat percentage?",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Tap the image that matches your desired \nbody fat percentage",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      /// Grid
                      Expanded(
                        child: viewModel.bodyFatImages.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                itemCount: viewModel.bodyFatImages.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.bodyFatImages[index];
                                  final isSelected =
                                      viewModel.selectedIndex == index;

                                  return GestureDetector(
                                    onTap: () async {
                                      await viewModel.selectIndex(index);

                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      final planType = prefs.getString(
                                        "plan_type",
                                      );

                                      if (!context.mounted) return;

                                      Navigator.pushNamed(
                                        context,
                                        planType == "muscle_gain"
                                            ? RouteNames.muscleGain
                                            : RouteNames.signinScreenThirteen,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.bolderColor
                                              : Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                item['image']!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            item['percent']!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
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
        },
      ),
    );
  }
}
