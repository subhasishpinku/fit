import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/signin_twenty_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenTwenty extends StatelessWidget {
  const SigninScreenTwenty({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SigninTwentyViewModel>(context);

    /// ✅ Load API Only Once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.foods.isEmpty && provider.isLoading == false) {
        provider.fetchFoods(subCategory: "");
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

              /// 🔹 Title
              const Text(
                "Select the fiber sources you'd like to include in your meal plan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Please select a minimum of 2 items and a maximum of 5 items.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 FILTER BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton(context, "All", ""),
                  _buildFilterButton(
                    context,
                    " Leafy & Cruciferous",
                    " Leafy & Cruciferous",
                  ),
                  _buildFilterButton(context, "Vegetables", "Vegetables"),
                  _buildFilterButton(context, "Seeds", "Seeds"),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 GRID
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.errorMessage.isNotEmpty
                    ? Center(child: Text(provider.errorMessage))
                    : GridView.builder(
                        itemCount: provider.foods.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = provider.foods[index];
                          final rawItem = item.rawItem ?? "";

                          final bool isSelected = provider.selectedItems
                              .contains(item.name);

                          return GestureDetector(
                            onTap: () => provider.toggleSelection(item),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.bolderColor,
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

                                  /// ✅ Tick mark
                                  if (isSelected)
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
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

              /// 🔹 NEXT BUTTON
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

  /// 🔥 FILTER BUTTON WIDGET
  Widget _buildFilterButton(
    BuildContext context,
    String title,
    String subCategory,
  ) {
    final vm = Provider.of<SigninTwentyViewModel>(context);

    final isSelected = vm.selectedCategory == title;

    return GestureDetector(
      onTap: () {
        vm.selectedCategory = title;

        vm.fetchFoods(subCategory: subCategory);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.bolderColor),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
