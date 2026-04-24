import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/signin_twentytwo_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenTwentyTwo extends StatefulWidget {
  const SigninScreenTwentyTwo({super.key});

  @override
  State<SigninScreenTwentyTwo> createState() => _SigninScreenTwentyTwoState();
}

class _SigninScreenTwentyTwoState extends State<SigninScreenTwentyTwo> {
  @override
  void initState() {
    super.initState();
    // We will call fetchFoods AFTER provider is created in build()
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninTwentyTwoViewModel()..fetchFoods(), // IMPORTANT
      child: Consumer<SigninTwentyTwoViewModel>(
        builder: (context, viewModel, _) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: const SigninSecondAppBar(),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Nuts for Your Meal Plan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please select a minimum of 2 items and a maximum of 5 items.",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 20),

                    if (viewModel.isLoading)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    if (!viewModel.isLoading &&
                        viewModel.errorMessage.isNotEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            viewModel.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),

                    if (!viewModel.isLoading && viewModel.errorMessage.isEmpty)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: viewModel.foods.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.foods[index]; // FoodModel
                            final rawItem = item.rawItem ?? "";
                            final bool isSelected = viewModel.selectedItems
                                .contains(item.name);

                            return GestureDetector(
                              onTap: () => viewModel.toggleSelection(item),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.bolderColor
                                        : AppColors.bolderColor,
                                    width: 2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      rawItem,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (isSelected)
                                      const Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Center(
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.primaryColor,
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 40,
                    //         vertical: 12,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     onPressed: viewModel.canProceed
                    //         ? () => viewModel.onNextPressed(context)
                    //         : null,
                    //     child: const Text(
                    //       "Next",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                          onPressed: viewModel.canProceed
                              ? () => viewModel.onNextPressed(context)
                              : null,
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
