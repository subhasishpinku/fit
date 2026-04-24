import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/sigin_eighteen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenEighteen extends StatelessWidget {
  const SigninScreenEighteen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninEighteenViewModel>(context);

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
        appBar: const SigninSecondAppBar(),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// TITLE
              const Text(
                "1Select the items from Carbohydrate (Other) that you'd like to include in your meal plan.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
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

              /// LOADING
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

              /// FOOD GRID
              if (!provider.isLoading &&
                  provider.errorMessage.isEmpty &&
                  provider.foods.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    itemCount: provider.foods.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final item = provider.foods[index]; // FoodModel
                      final String rawItem = item.rawItem; // display name

                      // final bool isSelected =
                      //     provider.selectedItems.contains(name);
                      final bool isSelected = provider.selectedItems.contains(
                        item.name,
                      );

                      return GestureDetector(
                        onTap: () => provider.toggleSelection(item),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  rawItem,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
