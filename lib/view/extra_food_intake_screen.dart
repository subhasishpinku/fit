import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/extra_food_intake_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraFoodIntakeScreen extends StatefulWidget {
  const ExtraFoodIntakeScreen({super.key});

  @override
  State<ExtraFoodIntakeScreen> createState() => _ExtraFoodIntakeScreenState();
}

class _ExtraFoodIntakeScreenState extends State<ExtraFoodIntakeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("user_id") ?? 0;
    int week = prefs.getInt("week") ?? 0;

    Provider.of<ExtraFoodIntakeViewModel>(
      context,
      listen: false,
    ).fetchWrongDietHistory(week.toString(), userId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExtraFoodIntakeViewModel>();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Log Today's Extra Food Intake",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "(If you consumed any extra food today, enter it here to keep your nutrition on track)",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              /// ---------------- INPUT FIELD WITH VALIDATION ----------------
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: viewModel.intakeController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Describe extra food or calories consumed...",
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter what extra food you consumed.";
                    }
                    if (value.length < 3) {
                      return "Description must be at least 5 characters.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// ---------------- SUBMIT BUTTON ----------------
              Center(
                child: SizedBox(
                  width: 250,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final prefs = await SharedPreferences.getInstance();
                        int userId = prefs.getInt("user_id") ?? 0;
                        int week = prefs.getInt("week") ?? 0;

                        await viewModel.submitWrongDiet(
                          userId: userId,
                          week: week.toString(),
                          day: "8",
                        );

                        viewModel.intakeController.clear();
                        _loadData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Entry added successfully!"),
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// ---------------- HISTORY TITLE BUTTON ----------------
              Center(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    backgroundColor: AppColors.signInButtonColor,
                    side: BorderSide(color: AppColors.backgroundColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    "Week 3 Extra Food Intake History",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// ---------------- HISTORY LIST ----------------
              Expanded(
                child: Consumer<ExtraFoodIntakeViewModel>(
                  builder: (context, vm, _) {
                    if (vm.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (vm.intakeHistory.isEmpty) {
                      return const Center(
                        child: Text(
                          "No track record found.\nYou’ll see your track record here after adding one.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: vm.intakeHistory.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 20,
                        thickness: 1,
                        color: Colors.black26,
                      ),
                      itemBuilder: (context, index) {
                        final item = vm.intakeHistory[index];

                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Day: ${item.day}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    item.createdAtHuman,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Divider(
                                height: 20,
                                thickness: 2,
                                color: Colors.black12,
                              ),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
