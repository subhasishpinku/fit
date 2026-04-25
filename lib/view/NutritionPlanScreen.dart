import 'package:aifitness/models/FoodItem.dart';
import 'package:aifitness/res/widgets/NutritionAppBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/nutrition_plan_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionPlanScreen extends StatefulWidget {
  final int day;
  final String dayType;

  const NutritionPlanScreen({
    super.key,
    required this.day,
    required this.dayType,
  });

  @override
  State<NutritionPlanScreen> createState() => _NutritionPlanScreenState();
}

class _NutritionPlanScreenState extends State<NutritionPlanScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("user_id") ?? 0;

    Future.microtask(() {
      Provider.of<NutritionPlanViewModel>(context, listen: false).getDiet(
        week: 2,
        userId: userId,
        dayType: widget.dayType,
        day: widget.day.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const NutritionAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<NutritionPlanViewModel>(
            builder: (context, vm, child) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.errorMessage != null) {
                return Center(
                  child: Text(
                    vm.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nutrition Plan - Day ${widget.day}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // const Text(
                    //   "Follow pre- and post-workout meals\nbased on your workout start time.",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.black,
                    //     height: 1.4,
                    //     fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                    if (widget.dayType.toLowerCase() == "workout") ...[
                      const Text(
                        "Follow pre- and post-workout meals\nbased on your workout start time.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          height: 1.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    const SizedBox(height: 20),

                    /// Supplements Section - ONLY THIS WILL SHOW INFO ICONS
                    if (vm.supplements.isNotEmpty) ...[
                      MealSectionWidget(
                        title: "Supplements",
                        items: vm.supplements,
                        isSupplementsSection:
                            true, // Mark as supplements section
                      ),
                      const SizedBox(height: 10),
                    ],

                    /// PreWorkout
                    MealSectionWidget(
                      title: "Pre-Workout Meal (Eat 60–90 mins before workout)",
                      items: vm.preWorkout,
                      isSupplementsSection: false,
                    ),

                    /// PostWorkout
                    MealSectionWidget(
                      title: "Post-Workout Meal",
                      items: vm.postWorkout,
                      isSupplementsSection: false,
                    ),

                    /// Breakfast
                    MealSectionWidget(
                      title: "Breakfast",
                      items: vm.breakfast,
                      isSupplementsSection: false,
                    ),

                    /// Lunch
                    MealSectionWidget(
                      title: "Lunch",
                      items: vm.lunch,
                      isSupplementsSection: false,
                    ),

                    /// Dinner
                    MealSectionWidget(
                      title: "Dinner",
                      items: vm.dinner,
                      isSupplementsSection: false,
                    ),

                    /// Snacks
                    // if (vm.snacks.isNotEmpty)
                    //   MealSectionWidget(
                    //     title: "Snacks",
                    //     items: vm.snacks,
                    //     isSupplementsSection: false,
                    //   ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// -------- SECTION WIDGET --------
/// -------- SECTION WIDGET --------
class MealSectionWidget extends StatelessWidget {
  final String title;
  final List<FoodItem> items;
  final bool isSupplementsSection; // New parameter

  const MealSectionWidget({
    super.key,
    required this.title,
    required this.items,
    this.isSupplementsSection = false, // Default to false
  });

  // Helper method to get the appropriate image based on meal type
  String _getMealImage() {
    if (isSupplementsSection) {
      return "assets/images/supplyment.png";
    }

    if (title.contains("Pre-Workout")) {
      return "assets/images/preWorkoutDiet.png";
    } else if (title.contains("Post-Workout")) {
      return "assets/images/preWorkoutDiet.png"; // Using same as pre-workout
    } else if (title.contains("Breakfast")) {
      return "assets/images/breakfast.png";
    } else if (title.contains("Lunch")) {
      return "assets/images/lunchicon.png";
    } else if (title.contains("Dinner")) {
      return "assets/images/dinner.png";
    } else if (title.contains("Snacks")) {
      return "assets/images/breakfast.png"; // Default fallback for snacks
    }

    return "assets/images/preworkout.png"; // Default fallback
  }

  // Helper method to check if alternatives exist for this meal type
  bool _hasAlternatives(BuildContext context) {
    final vm = Provider.of<NutritionPlanViewModel>(context, listen: false);

    if (title.contains("Breakfast")) {
      return vm.breakfastAlternative.isNotEmpty;
    } else if (title.contains("Lunch")) {
      return vm.lunchAlternative.isNotEmpty;
    } else if (title.contains("Dinner")) {
      return vm.dinnerAlternative.isNotEmpty;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    double totalCarb = 0,
        totalProtein = 0,
        totalFat = 0,
        totalFiber = 0,
        totalLeucine = 0;

    for (var item in items) {
      totalCarb += double.tryParse(item.carbs ?? "0") ?? 0;
      totalProtein += double.tryParse(item.protein ?? "0") ?? 0;
      totalFat += double.tryParse(item.fat ?? "0") ?? 0;
      totalFiber += double.tryParse(item.fiber ?? "0") ?? 0;
      totalLeucine += double.tryParse(item.lysine ?? "0") ?? 0;
    }

    double totalKcal = (totalCarb * 4) + (totalProtein * 4) + (totalFat * 9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),

    /// HEADER ROW - Centered with text wrapping
Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset(
      _getMealImage(),
      height: 50,
      width: 50,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Container(
        height: 50,
        width: 50,
        color: Colors.grey.shade200,
        child: Icon(
          isSupplementsSection ? Icons.medication : Icons.fastfood,
          color: Colors.grey,
        ),
      ),
    ),
    const SizedBox(width: 12),
    Flexible(  // Allows text to wrap but not take excess space
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center, // Centers text if it wraps
      ),
    ),
  ],
),

        const SizedBox(height: 14),

        /// FOOD ITEMS - Pass the supplements flag
        ...items.map(
          (item) => FoodCard(
            item: item,
            showInfoIcon:
                isSupplementsSection, // Only true for supplements section
          ),
        ),

        const SizedBox(height: 10),

        /// NUTRITION SUMMARY
        Row(
          children: [
            const Icon(Icons.bar_chart, size: 16, color: Colors.blue),
            const SizedBox(width: 6),
            Text(
              "≈ ${totalKcal.toStringAsFixed(0)} Kcal",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.science, size: 16, color: Colors.purple),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                "Protein: ${totalProtein.toStringAsFixed(1)}g | "
                "Carbs: ${totalCarb.toStringAsFixed(1)}g | "
                "Fats: ${totalFat.toStringAsFixed(1)}g | "
                "Fiber: ${totalFiber.toStringAsFixed(1)}g | "
                "Leucine: ${totalLeucine.toStringAsFixed(1)}g",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Divider(color: Colors.black12, height: 1),

        /// Alternative Foods Button - ONLY SHOW WHEN:
        /// 1. Not a supplements section
        /// 2. Is Breakfast, Lunch, or Dinner
        /// 3. AND there are actually alternatives available
        if (!isSupplementsSection &&
            (title.contains("Breakfast") ||
                title.contains("Lunch") ||
                title.contains("Dinner")) &&
            _hasAlternatives(context)) // Only show if alternatives exist
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlternativeFoodDialog(title: title),
                );
              },
              child: const Text(
                "Your Alternative Habitat Foods",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}
// /// -------- SECTION WIDGET --------
// /// -------- SECTION WIDGET --------
// class MealSectionWidget extends StatelessWidget {
//   final String title;
//   final List<FoodItem> items;
//   final bool isSupplementsSection; // New parameter

//   const MealSectionWidget({
//     super.key,
//     required this.title,
//     required this.items,
//     this.isSupplementsSection = false, // Default to false
//   });

//   // Helper method to check if alternatives exist for this meal type
//   bool _hasAlternatives(BuildContext context) {
//     final vm = Provider.of<NutritionPlanViewModel>(context, listen: false);

//     if (title.contains("Breakfast")) {
//       return vm.breakfastAlternative.isNotEmpty;
//     } else if (title.contains("Lunch")) {
//       return vm.lunchAlternative.isNotEmpty;
//     } else if (title.contains("Dinner")) {
//       return vm.dinnerAlternative.isNotEmpty;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) return const SizedBox.shrink();

//     double totalCarb = 0,
//         totalProtein = 0,
//         totalFat = 0,
//         totalFiber = 0,
//         totalLeucine = 0;

//     for (var item in items) {
//       totalCarb += double.tryParse(item.carbs ?? "0") ?? 0;
//       totalProtein += double.tryParse(item.protein ?? "0") ?? 0;
//       totalFat += double.tryParse(item.fat ?? "0") ?? 0;
//       totalFiber += double.tryParse(item.fiber ?? "0") ?? 0;
//       totalLeucine += double.tryParse(item.lysine ?? "0") ?? 0;
//     }

//     double totalKcal = (totalCarb * 4) + (totalProtein * 4) + (totalFat * 9);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 22),

//         /// HEADER ROW
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               "assets/images/preworkout.png",
//               height: 50,
//               width: 50,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 14),

//         /// FOOD ITEMS - Pass the supplements flag
//         ...items.map(
//           (item) => FoodCard(
//             item: item,
//             showInfoIcon:
//                 isSupplementsSection, // Only true for supplements section
//           ),
//         ),

//         const SizedBox(height: 10),

//         /// NUTRITION SUMMARY
//         // Row(
//         //   children: [
//         //     const Icon(Icons.bar_chart, size: 16, color: Colors.blue),
//         //     const SizedBox(width: 6),
//         //     Text(
//         //       "≈ ${totalKcal.toStringAsFixed(0)} Kcal",
//         //       style: const TextStyle(
//         //         fontSize: 14,
//         //         fontWeight: FontWeight.w600,
//         //         color: Colors.black87,
//         //       ),
//         //     ),
//         //   ],
//         // ),

//         // const SizedBox(height: 4),

//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     const Icon(Icons.science, size: 16, color: Colors.purple),
//         //     const SizedBox(width: 6),
//         //     Expanded(
//         //       child: Text(
//         //         "Protein: ${totalProtein.toStringAsFixed(1)}g | "
//         //         "Carbs: ${totalCarb.toStringAsFixed(1)}g | "
//         //         "Fats: ${totalFat.toStringAsFixed(1)}g | "
//         //         "Fiber: ${totalFiber.toStringAsFixed(1)}g | "
//         //         "Leucine: ${totalLeucine.toStringAsFixed(1)}g",
//         //         style: const TextStyle(
//         //           fontSize: 13,
//         //           color: Colors.black87,
//         //           height: 1.3,
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         const SizedBox(height: 28),
//         const Divider(color: Colors.black12, height: 1),

//         /// Alternative Foods Button - ONLY SHOW WHEN:
//         /// 1. Not a supplements section
//         /// 2. Is Breakfast, Lunch, or Dinner
//         /// 3. AND there are actually alternatives available
//         if (!isSupplementsSection &&
//             (title.contains("Breakfast") ||
//                 title.contains("Lunch") ||
//                 title.contains("Dinner")) &&
//             _hasAlternatives(context)) // Only show if alternatives exist
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 minimumSize: const Size(double.infinity, 45),
//               ),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlternativeFoodDialog(title: title),
//                 );
//               },
//               child: const Text(
//                 "Your Alternative Habitat Foods",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

/// -------- FOOD CARD - INFO ICON ONLY FOR SUPPLEMENTS --------
class FoodCard extends StatelessWidget {
  final FoodItem item;
  final bool showInfoIcon; // Control whether to show info icon

  const FoodCard({
    super.key,
    required this.item,
    required this.showInfoIcon, // Make it required
  });

  void _showFoodInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => FoodInfoDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.mediaDecoded != null && item.mediaDecoded!.isNotEmpty
                ? Image.network(
                    item.mediaDecoded!.first.url ?? "",
                    height: 78,
                    width: 78,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 78,
                      width: 78,
                      color: Colors.grey.shade200,
                      child: Icon(
                        showInfoIcon ? Icons.medication : Icons.fastfood,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Container(
                    height: 78,
                    width: 78,
                    color: Colors.grey.shade200,
                    child: Icon(
                      showInfoIcon ? Icons.medication : Icons.fastfood,
                      color: Colors.grey,
                    ),
                  ),
          ),

          const SizedBox(width: 10),

          /// NAME & DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name ?? "",
                        style: const TextStyle(
                          fontSize: 14.8,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    /// INFO ICON - SHOW ONLY WHEN showInfoIcon IS TRUE (SUPPLEMENTS)
                    if (showInfoIcon)
                      GestureDetector(
                        onTap: () => _showFoodInfoDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),

                /// Show different information based on item type
                if (showInfoIcon) ...[
                  /// For supplements - show supplement-specific info
                  if (item.bestTime != null && item.bestTime!.isNotEmpty)
                    Text(
                      "Best time: ${item.bestTime}",
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                    ),
                  if (item.howToTake != null && item.howToTake!.isNotEmpty)
                    Text(
                      "How to take: ${item.howToTake}",
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  // if (item.note != null && item.note!.isNotEmpty)
                  //   Text(
                  //     "Note: ${item.note}",
                  //     style: const TextStyle(
                  //       fontSize: 12.5,
                  //       color: Colors.black54,
                  //     ),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),

                  /// Show macros for supplements too
                  // Text(
                  //   "Carbs: ${item.carbs ?? "0"}g | Protein: ${item.protein ?? "0"}g | Fat: ${item.fat ?? "0"}g",
                  //   style: const TextStyle(
                  //     fontSize: 12.5,
                  //     color: Colors.black54,
                  //   ),
                  // ),
                ] else ...[
                  /// For regular food - show macros only (NO INFO ICON)
                  Text(
                    "Carbs: ${item.carbs ?? "0"}g",
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Protein: ${item.protein ?? "0"}g",
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Fat: ${item.fat ?? "0"}g",
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black54,
                    ),
                  ),
                  if (item.fiber != null && item.fiber != "0")
                    Text(
                      "Fiber: ${item.fiber}g",
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                    ),
                ],

                /// Show quantity if available
                // if (item.quantityUi != null && item.quantityUi!.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 4),
                //     child: Text(
                //       "Quantity: ${item.quantityUi}",
                //       style: const TextStyle(
                //         fontSize: 11,
                //         color: Colors.orange,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// -------- FOOD INFO DIALOG (Enhanced for supplements) --------
class FoodInfoDialog extends StatelessWidget {
  final FoodItem item;

  const FoodInfoDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            /// MAIN CARD
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE with supplement icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("💊", style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.name ?? "Supplement",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// WHAT IT DOES / DESCRIPTION
                  const Text(
                    "What it does",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description ??
                        "Supplement that supports your fitness goals.",
                    style: const TextStyle(fontSize: 13),
                  ),

                  const SizedBox(height: 14),

                  /// BEST TIME
                  const Text(
                    "Best time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.bestTime ?? item.time ?? "As directed",
                    style: const TextStyle(fontSize: 13),
                  ),

                  /// HOW TO TAKE (for supplements)
                  if (item.howToTake != null) ...[
                    const SizedBox(height: 14),
                    const Text(
                      "How to take",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.howToTake!, style: const TextStyle(fontSize: 13)),
                  ],

                  /// NUTRITION INFO
                  const SizedBox(height: 14),
                  const Text(
                    "Nutrition Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Carbs: ${item.carbs ?? "0"}g | Protein: ${item.protein ?? "0"}g | Fat: ${item.fat ?? "0"}g",
                    style: const TextStyle(fontSize: 13),
                  ),

                  /// NOTES / ADDITIONAL INFO
                  if (item.note != null || item.calories != null) ...[
                    const SizedBox(height: 14),
                    const Text(
                      "Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (item.note != null)
                      Text(item.note!, style: const TextStyle(fontSize: 13)),
                    if (item.calories != null)
                      Text(
                        "Calories: ${item.calories} kcal",
                        style: const TextStyle(fontSize: 13),
                      ),
                  ],

                  /// Quantity info
                  if (item.quantityUi != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Serving: ${item.quantityUi}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            /// CLOSE BUTTON (TOP RIGHT)
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------- ALTERNATIVE FOOD DIALOG --------
class AlternativeFoodDialog extends StatelessWidget {
  final String title;

  const AlternativeFoodDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NutritionPlanViewModel>(context, listen: false);

    List<FoodItem> alternatives = [];

    if (title.contains("Breakfast")) {
      alternatives = vm.breakfastAlternative;
    } else if (title.contains("Lunch")) {
      alternatives = vm.lunchAlternative;
    } else if (title.contains("Dinner")) {
      alternatives = vm.dinnerAlternative;
    }

    if (alternatives.isEmpty) {
      return const SizedBox();
    }

    final food = alternatives.first;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 340,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// CLOSE BUTTON
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.close, size: 16),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              /// HEADER ROW
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "ALTERNATIVE",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Same-Calorie Habitat Foods",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// INFO BOX
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.restaurant, size: 18, color: Colors.grey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "These alternatives match the healthy meal's calories exactly - just smaller portions of your favorites!",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// FOOD ROW
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: const Icon(Icons.egg, color: Colors.green),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Carbs: ${food.carbs ?? "0"}g",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Protein: ${food.protein ?? "0"}g",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Fat: ${food.fat ?? "0"}g",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// BLUE DESCRIPTION
              const Text(
                "This is a healthy food that you can include in your meal plan as an alternative.",
                style: TextStyle(fontSize: 12, color: Colors.blue),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 18),

              /// CALORIE SUMMARY
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Total ~${food.calories ?? "0"} cal",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "💡 Same energy, comfort foods in controlled portions!",
                      style: TextStyle(fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
