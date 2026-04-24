import 'package:aifitness/res/widgets/HipMeasurementAppBars.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/sigin_seventeen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenSeventeen extends StatelessWidget {
  const SigninScreenSeventeen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninSeventeenViewModel>(context);

    // LOAD API ONLY ONCE
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.foods.isEmpty && provider.isLoading == false) {
        provider.fetchFoods();
      }
    });

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // appBar: const SigninSecondAppBar(),
        appBar: const HipMeasurementAppBars(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// TITLE
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
                    "Select the items from Carbohydrate (Whole Grain) that you'd like to include in your meal plan.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                "Please select a minimum of 2 items and a maximum of 5 items.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 25),

              /// LOADER
              if (provider.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),

              /// ERROR
              if (!provider.isLoading && provider.errorMessage.isNotEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      provider.errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),

              /// FOOD LIST GRID
              if (!provider.isLoading &&
                  provider.errorMessage.isEmpty &&
                  provider.foods.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    itemCount: provider.foods.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final item = provider.foods[index]; // FoodModel
                      final String rawItem = item.rawItem;

                      // final bool isSelected = provider.selectedItems.contains(
                      //   rawItem,
                      // );
                      final bool isSelected = provider.selectedItems.contains(
                        item.name,
                      );

                      return GestureDetector(
                        onTap: () => provider.toggleSelection(item),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.bolderColor
                                  : AppColors.bolderColor,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                rawItem,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              if (isSelected)
                                const Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
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

              const SizedBox(height: 10),

              /// NEXT BUTTON
              // Center(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.primaryColor,
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 40,
              //         vertical: 12,
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     onPressed: provider.canProceed
              //         ? () => provider.onNextPressed(context)
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
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: SizedBox(
              //     width: 120,
              //     height: 45,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         foregroundColor: AppColors.primaryColor,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8),
              //           side: BorderSide(color: AppColors.bolderColor),
              //         ),
              //         elevation: 0,
              //       ),
              //       onPressed: provider.canProceed
              //           ? () => provider.onNextPressed(context)
              //           : null,
              //       child: const Text(
              //         "NEXT",
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           letterSpacing: 1.2,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
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
                        onPressed: provider.canProceed
                            ? () => provider.onNextPressed(context)
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
