import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/signin_twentythree_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreenTwentyThree extends StatefulWidget {
  const SigninScreenTwentyThree({super.key});

  @override
  State<SigninScreenTwentyThree> createState() =>
      _SigninScreenTwentyThreeState();
}

class _SigninScreenTwentyThreeState extends State<SigninScreenTwentyThree> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninTwentyThreeViewModel()..fetchFoods(subCategory: ""),
      child: Consumer<SigninTwentyThreeViewModel>(
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
                    /// 🔹 Title
                    const Text(
                      "Select the fat sources you’d like to include in your meal plan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Please select a minimum of 2 items and a maximum of 5 items.",
                      style: TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    /// 🔥 FILTER BUTTONS
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterButton(context, "All", ""),
                          _buildFilterButton(
                            context,
                            "Nuts & Seeds",
                            "Nuts & Seeds",
                          ),
                          _buildFilterButton(context, "Oils", "Oils"),
                          _buildFilterButton(
                            context,
                            "Fermented / Probiotic",
                            "Fermented / Probiotic",
                          ),
                          _buildFilterButton(
                            context,
                            "Whole Food Fats",
                            "Whole Food Fats",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 CONTENT
                    Expanded(
                      child: viewModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : viewModel.errorMessage.isNotEmpty
                          ? Center(child: Text(viewModel.errorMessage))
                          : GridView.builder(
                              itemCount: viewModel.foods.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                  ),
                              itemBuilder: (context, index) {
                                final item = viewModel.foods[index];
                                final rawItem = item.rawItem ?? "";

                                final bool isSelected = viewModel.selectedItems
                                    .contains(item.name);

                                return GestureDetector(
                                  onTap: () => viewModel.toggleSelection(item),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: AppColors.bolderColor,
                                            width: 2,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          rawItem,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      if (isSelected)
                                        const Positioned(
                                          bottom: 8,
                                          right: 6,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                    ],
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
                          onPressed: viewModel.canProceed
                              ? () => viewModel.onNextPressed(context)
                              : null,
                          child: const Text(
                            "NEXT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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

  /// 🔥 FILTER BUTTON
  Widget _buildFilterButton(
    BuildContext context,
    String title,
    String subCategory,
  ) {
    final vm = Provider.of<SigninTwentyThreeViewModel>(context);

    final isSelected = vm.selectedCategory == title;

    return GestureDetector(
      onTap: () {
        vm.selectedCategory = title;
        vm.fetchFoods(subCategory: subCategory);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.bolderColor),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
