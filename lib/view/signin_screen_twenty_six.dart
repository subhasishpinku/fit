// import 'package:aifitness/res/widgets/SupplementsAppBars.dart';
// import 'package:aifitness/utils/app_colors.dart';
// import 'package:aifitness/viewModel/supplement_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SigninScreenTwentySix extends StatefulWidget {
//   const SigninScreenTwentySix({super.key});

//   @override
//   State<SigninScreenTwentySix> createState() => _SigninScreenTwentySixState();
// }

// class _SigninScreenTwentySixState extends State<SigninScreenTwentySix> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//       () => Provider.of<SupplementProvider>(
//         context,
//         listen: false,
//       ).loadSupplements(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SupplementProvider>(context);

//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: SupplementsAppBars(),
//         body: provider.loading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16),
//                     child: const Text(
//                       "Select the supplements you would like to include in your meal plan.",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 100),
//                     child: const Text(
//                       "You can select a maximum of 5 items",
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   Expanded(
//                     child: GridView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: provider.supplements.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 14,
//                             mainAxisSpacing: 14,
//                           ),
//                       itemBuilder: (context, index) {
//                         final item = provider.supplements[index];
//                         final selected = provider.isSelected(item.id);

//                         return GestureDetector(
//                           onTap: () {
//                             provider.toggleSelection(item.id);
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColors.bolderColor,
//                                 width: 2,
//                               ),
//                             ),
//                             // child: Stack(
//                             //   alignment: Alignment.center,
//                             //   children: [
//                             //     Padding(
//                             //       padding: const EdgeInsets.all(10),
//                             //       child: Text(
//                             //         item.rawItem,
//                             //         textAlign: TextAlign.center,
//                             //         style: const TextStyle(fontSize: 12),
//                             //       ),
//                             //     ),

//                             //     if (selected)
//                             //       const Positioned(
//                             //         bottom: 8,
//                             //         right: 8,
//                             //         child: Icon(
//                             //           Icons.check_circle,
//                             //           color: Colors.black,
//                             //         ),
//                             //       ),
//                             //   ],
//                             // ),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: Text(
//                                     item.rawItem,
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(fontSize: 12),
//                                   ),
//                                 ),

//                                 /// INFO ICON
//                                 Positioned(
//                                   top: 13,
//                                   right: 13,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       _showSupplementDetails(context, item);
//                                     },
//                                     child: const Icon(
//                                       Icons.info_outline,
//                                       size: 22,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ),

//                                 if (selected)
//                                   const Positioned(
//                                     bottom: 8,
//                                     right: 8,
//                                     child: Icon(
//                                       Icons.check_circle,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   // Padding(
//                   //   padding: const EdgeInsets.all(16),
//                   //   child: ElevatedButton(
//                   //     onPressed: () {
//                   //       print(provider.selectedIds);
//                   //     },
//                   //     child: const Text("Next"),
//                   //   ),
//                   // ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: SizedBox(
//                       width: 120,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: AppColors.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             side: BorderSide(color: AppColors.bolderColor),
//                           ),
//                           elevation: 0,
//                         ),
//                         onPressed: provider.canProceed
//                             ? () => provider.onNextPressed(context)
//                             : null,
//                         child: const Text(
//                           "NEXT",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// void _showSupplementDetails(BuildContext context, item) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
//         ),
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// HEADER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           const Text("🏋️", style: TextStyle(fontSize: 20)),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             child: Text(
//                               item.rawItem,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     /// CLOSE BUTTON
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.grey),
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.close, size: 20),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 /// WHAT IT DOES
//                 const Text(
//                   "What it does",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.description ?? "No description available",
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     height: 1.4,
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 /// BEST TIME
//                 const Text(
//                   "Best time",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.bestTime ?? "-",
//                   style: const TextStyle(color: Colors.grey, fontSize: 14),
//                 ),

//                 const SizedBox(height: 14),

//                 /// HOW TO TAKE
//                 const Text(
//                   "How to take",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.howToTake ?? "-",
//                   style: const TextStyle(color: Colors.grey, fontSize: 14),
//                 ),

//                 const SizedBox(height: 14),

//                 /// NOTES
//                 const Text(
//                   "Notes",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.note ?? "-",
//                   style: const TextStyle(color: Colors.grey, fontSize: 14),
//                 ),

//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
import 'package:aifitness/res/widgets/HipMeasurementAppBars.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/supplement_provider.dart';

class SigninScreenTwentySix extends StatefulWidget {
  const SigninScreenTwentySix({super.key});

  @override
  State<SigninScreenTwentySix> createState() => _SigninScreenTwentySixState();
}

class _SigninScreenTwentySixState extends State<SigninScreenTwentySix> {
  final List<String> categories = [
    "All",
    "Amino Acids & Electrolytes",
    "Stress & Recovery",
    "Protein Supplements",
    "Vitamins & Minerals",
    "Miscellaneous",
    "Fat Burners & Metabolic Support",
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<SupplementProvider>(
        context,
        listen: false,
      ).loadSupplements(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SupplementProvider>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: const HipMeasurementAppBars(),
        body: SafeArea(
          child: provider.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 10),

                    /// TITLE
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Select the supplements you would like to include in your meal plan.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// SUBTITLE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "You can select a maximum of 5 items",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// ✅ CATEGORY SECTION (FIXED UI)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length - 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 3.5,
                                ),
                            itemBuilder: (context, index) {
                              final cat = categories[index];
                              final selected = provider.selectedCategory == cat;

                              return _buildChip(cat, selected, provider);
                            },
                          ),

                          const SizedBox(height: 10),

                          /// 🔥 FULL WIDTH LAST CHIP
                          _buildChip(
                            categories.last,
                            provider.selectedCategory == categories.last,
                            provider,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ✅ GRID (FIXED DESIGN)
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.supplements.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = provider.supplements[index];
                          final selected = provider.isSelected(item.id);

                          return GestureDetector(
                            onTap: () =>
                                provider.toggleSelection(item.id, context),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selected ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    /// TEXT
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: Text(
                                          item.rawItem,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// INFO ICON
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: InkWell(
                                        onTap: () => _showSupplementDetails(
                                          context,
                                          item,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.info_outline,
                                            size: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// CHECK
                                    if (selected)
                                      const Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// SKIP BUTTON
                    SizedBox(
                      width: 120,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 252, 113, 21),
                            ),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.addMealScreen,
                          );
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// NEXT BUTTON
                    SizedBox(
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
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
        ),
      ),
    );
  }

  /// ✅ CHIP BUILDER
  Widget _buildChip(String text, bool selected, SupplementProvider provider) {
    return GestureDetector(
      onTap: () => provider.setCategory(text),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade400,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// BOTTOM SHEET
  void _showSupplementDetails(BuildContext context, item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.rawItem,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "What it does",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.description ?? "-"),
                const SizedBox(height: 10),
                const Text(
                  "Best time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.bestTime ?? "-"),
                const SizedBox(height: 10),
                const Text(
                  "How to take",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.howToTake ?? "-"),
                const SizedBox(height: 10),
                const Text(
                  "Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.note ?? "-"),
              ],
            ),
          ),
        );
      },
    );
  }
}
