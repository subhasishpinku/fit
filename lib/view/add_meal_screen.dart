import 'package:aifitness/res/widgets/AddMealAppBars.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/add_meal_viewmodel.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<AddMealViewModel>(context, listen: false).loadMeals(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddMealViewModel>(context);

    return Scaffold(
      appBar: AddMealAppBars(),

      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What are you eating right now?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Add your meal by tapping the Add Meal button.",
                style: TextStyle(fontSize: 13),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade200,
                  minimumSize: const Size(double.infinity, 45),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // square corner
                  ),
                ),
                onPressed: () => _openAddMealSheet(context),
                child: const Text("Add Meal"),
              ),

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (vm.meals["breakfast"]!.isNotEmpty)
                    buildMealField(
                      "Breakfast",
                      vm.meals["breakfast"]!,
                      (i) => vm.removeMeal("breakfast", i),
                    ),

                  if (vm.meals["lunch"]!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    buildMealField(
                      "Lunch",
                      vm.meals["lunch"]!,
                      (i) => vm.removeMeal("lunch", i),
                    ),
                  ],

                  if (vm.meals["snack"]!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    buildMealField(
                      "Snack",
                      vm.meals["snack"]!,
                      (i) => vm.removeMeal("snack", i),
                    ),
                  ],

                  if (vm.meals["dinner"]!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    buildMealField(
                      "Dinner",
                      vm.meals["dinner"]!,
                      (i) => vm.removeMeal("dinner", i),
                    ),
                  ],
                ],
              ),
              const Spacer(),
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
                        side: BorderSide(
                          color: const Color.fromARGB(255, 252, 113, 21),
                        ),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.signinScreenTwentyFour,
                      );
                    },
                    child: const Text(
                      "SKIP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                    onPressed: () => vm.onNextPressed(context),

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

  /// Meal UI
  Widget buildMealField(
    String title,
    List<String> items,
    Function(int) onRemove,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),

        Container(
          width: 300,
          padding: const EdgeInsets.all(6),

          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.blue),
          //   borderRadius: BorderRadius.circular(6),
          // ),
          child: Wrap(
            spacing: 6,
            children: items.asMap().entries.map((e) {
              return Chip(
                label: SizedBox(width: double.infinity, child: Text(e.value)),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => onRemove(e.key),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _openAddMealSheet(BuildContext context) {
    TextEditingController mealController = TextEditingController();
    String? selectedType;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Add Meal",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        /// MEAL TYPE LABEL
                        const Text(
                          "Meal Type",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),

                        /// DROPDOWN
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          hint: const Text("-- Please Select Meal Type --"),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Breakfast",
                              child: Text("Breakfast"),
                            ),
                            DropdownMenuItem(
                              value: "Lunch",
                              child: Text("Lunch"),
                            ),
                            DropdownMenuItem(
                              value: "Snack",
                              child: Text("Snack"),
                            ),
                            DropdownMenuItem(
                              value: "Dinner",
                              child: Text("Dinner"),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              selectedType = v;
                            });
                          },
                        ),
                        const SizedBox(height: 12),

                        /// ENTER MEAL LABEL
                        const Text(
                          "Enter Meal",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Select meal type and add foods one by one.",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        const SizedBox(height: 6),

                        /// TEXT FIELD
                        TextField(
                          controller: mealController,
                          decoration: const InputDecoration(
                            hintText: "Enter food (e.g., Apple)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Tap 'Add' after entering each item.",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        const SizedBox(height: 16),

                        /// ADD BUTTON
                        Center(
                          child: SizedBox(
                            width: 120,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: AppColors.bolderColor,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (selectedType == null ||
                                    mealController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Select type & enter meal"),
                                    ),
                                  );
                                  return;
                                }

                                // Add the meal
                                Provider.of<AddMealViewModel>(
                                  context,
                                  listen: false,
                                ).addMeal(
                                  selectedType!.toLowerCase(),
                                  mealController.text,
                                );

                                // Close the dialog FIRST
                                Navigator.pop(context);

                                // Show success message AFTER dialog is closed
                                // Use the original context (from parameter) instead of the dialog's context
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Item has been added successfully",
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
            },
          ),
        );
      },
    );
  }

  void _openAddMealSheet1(BuildContext context) {
    TextEditingController mealController = TextEditingController();
    String? selectedType;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Add Meal",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// MEAL TYPE LABEL
                        const Text(
                          "Meal Type",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 6),

                        /// DROPDOWN
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          hint: const Text("-- Please Select Meal Type --"),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Breakfast",
                              child: Text("Breakfast"),
                            ),
                            DropdownMenuItem(
                              value: "Lunch",
                              child: Text("Lunch"),
                            ),
                            DropdownMenuItem(
                              value: "Snack",
                              child: Text("Snack"),
                            ),
                            DropdownMenuItem(
                              value: "Dinner",
                              child: Text("Dinner"),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              selectedType = v;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        /// ENTER MEAL LABEL
                        const Text(
                          "Enter Meal",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "Select meal type and add foods one by one.",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),

                        const SizedBox(height: 6),

                        /// TEXT FIELD
                        TextField(
                          controller: mealController,
                          decoration: const InputDecoration(
                            hintText: "Enter food (e.g., Apple)",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          "Tap 'Add' after entering each item.",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),

                        const SizedBox(height: 16),

                        /// ADD BUTTON
                        Center(
                          child: SizedBox(
                            width: 120,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: AppColors.bolderColor,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (selectedType == null ||
                                    mealController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Select type & enter meal"),
                                    ),
                                  );
                                  return;
                                }

                                Provider.of<AddMealViewModel>(
                                  context,
                                  listen: false,
                                ).addMeal(
                                  selectedType!.toLowerCase(),
                                  mealController.text,
                                );

                                mealController
                                    .clear(); // 🔥 stay open for multiple add
                                /// ✅ SUCCESS MESSAGE
                                Navigator.pop(context);

                                /// ✅ SHOW SUCCESS MESSAGE (use ROOT context)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Item has been added successfully.",
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
            },
          ),
        );
      },
    );
  }

  /// BottomSheet
  void _openAddMealSheet11(BuildContext context) {
    TextEditingController mealController = TextEditingController();
    String selectedType = "Breakfast";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (_) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),

                child: Container(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Add Meal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: selectedType,
                        items: const [
                          DropdownMenuItem(
                            value: "Breakfast",
                            child: Text("Breakfast"),
                          ),

                          DropdownMenuItem(
                            value: "Lunch",
                            child: Text("Lunch"),
                          ),

                          DropdownMenuItem(
                            value: "Snack",
                            child: Text("Snack"),
                          ),

                          DropdownMenuItem(
                            value: "Dinner",
                            child: Text("Dinner"),
                          ),
                        ],

                        onChanged: (v) {
                          setState(() {
                            selectedType = v!;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: mealController,
                        decoration: const InputDecoration(
                          hintText: "Enter Meal",
                          border: OutlineInputBorder(),
                        ),
                      ),
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
                                side: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    252,
                                    113,
                                    21,
                                  ),
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.signinScreenTwentyFour,
                              );
                            },
                            child: const Text(
                              "SKIP",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                            onPressed: () {
                              if (mealController.text.isNotEmpty) {
                                Provider.of<AddMealViewModel>(
                                  context,
                                  listen: false,
                                ).addMeal(
                                  selectedType.toLowerCase(),
                                  mealController.text,
                                );

                                Navigator.pop(context);
                              }
                            },

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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (mealController.text.isNotEmpty) {
                      //       Provider.of<AddMealViewModel>(
                      //         context,
                      //         listen: false,
                      //       ).addMeal(
                      //         selectedType.toLowerCase(),
                      //         mealController.text,
                      //       );

                      //       Navigator.pop(context);
                      //     }
                      //   },

                      //   child: const Text("Add"),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
