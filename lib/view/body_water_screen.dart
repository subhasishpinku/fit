import 'package:aifitness/viewModel/body_water_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class BodyWaterScreen extends StatefulWidget {
  const BodyWaterScreen({super.key});

  @override
  State<BodyWaterScreen> createState() => _BodyWaterScreenState();
}

class _BodyWaterScreenState extends State<BodyWaterScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("user_id") ?? 0;
      int week = prefs.getInt("week") ?? 0;
      String day = prefs.getString("day") ?? "8";

      Provider.of<BodyWaterViewModel>(context, listen: false).fetchWeightLogs(
        userId: userId,
        week: week.toString(),
        day: "8",
        logType: "total_body_water",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BodyWaterViewModel>();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------ INPUT SECTION ------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Enter your body water for today",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // TextField
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: viewModel.weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Enter your weight (kg)",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Submit Button
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.black),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            final weightText = viewModel.weightController.text
                                .trim();

                            // --- VALIDATION CHECK ---
                            if (weightText.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter your weight"),
                                  backgroundColor: Colors.black,
                                ),
                              );
                              return;
                            }

                            if (double.tryParse(weightText) == null ||
                                double.parse(weightText) <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter a valid number"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            if (!RegExp(
                              r'^\d{1,2}(\.\d{1,2})?$',
                            ).hasMatch(weightText)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Enter weight in valid format (e.g., 50, 50.5, 50.25)",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            // Proceed if valid
                            final prefs = await SharedPreferences.getInstance();
                            int userId = prefs.getInt("user_id") ?? 0;
                            int week = prefs.getInt("week") ?? 0;
                            String day = prefs.getString("day") ?? "1";

                            viewModel.submitWeight(
                              context,
                              userId: userId,
                              logValue: weightText,
                              week: week.toString(),
                              day: "8",
                              logType: "total_body_water",
                            );

                            // Optional: Clear input field after successfully submitting
                            viewModel.weightController.clear();
                          },

                          // onPressed: () async {
                          //   final prefs = await SharedPreferences.getInstance();
                          //   int userId = prefs.getInt("user_id") ?? 0;
                          //   int week = prefs.getInt("week") ?? 0;
                          //   String day = prefs.getString("day") ?? "1";

                          //   viewModel.submitWeight(
                          //     context,
                          //     userId: userId,
                          //     logValue: viewModel.weightController.text.trim(),
                          //     week: week.toString(),
                          //     day: "8",
                          //     logType: "total_body_water",
                          //   );
                          // },
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
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ------------------ HISTORY TITLE ------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ------------------ HISTORY LIST ------------------
              Expanded(
                child: viewModel.loading
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.history.isEmpty
                    ? const Center(
                        child: Text(
                          "No track record found.\nAdd your first weight entry.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.history.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final entry = viewModel.history[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// HEADER ROW
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Track ${viewModel.history.length - index}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      timeago.format(entry.time),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                /// WEIGHT DETAILS
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Weight: ${entry.weight} Kg",
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          viewModel.deleteWeight(index),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              // Expanded(
              //   child: viewModel.history.isEmpty
              //       ? const Center(
              //           child: Text(
              //             "No track record found.\nAdd your first weight entry.",
              //             style: TextStyle(color: Colors.grey, fontSize: 13),
              //             textAlign: TextAlign.center,
              //           ),
              //         )
              //       : ListView.builder(
              //           itemCount: viewModel.history.length,
              //           padding: const EdgeInsets.only(bottom: 16),
              //           itemBuilder: (context, index) {
              //             final entry = viewModel.history[index];

              //             return Container(
              //               margin: const EdgeInsets.only(bottom: 12),
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 14,
              //                 vertical: 12,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: Colors.grey.shade200,
              //                 borderRadius: BorderRadius.circular(8),
              //                 border: Border.all(color: Colors.grey.shade300),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   /// HEADER ROW
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         "Track ${viewModel.history.length - index}",
              //                         style: const TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 15,
              //                         ),
              //                       ),
              //                       Text(
              //                         timeago.format(entry.time),
              //                         style: const TextStyle(
              //                           color: Colors.grey,
              //                           fontSize: 12,
              //                         ),
              //                       ),
              //                     ],
              //                   ),

              //                   const SizedBox(height: 6),

              //                   /// WEIGHT DETAILS
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         "Weight: ${entry.weight} Kg",
              //                         style: const TextStyle(
              //                           fontSize: 13.5,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),

              //                       IconButton(
              //                         onPressed: () =>
              //                             viewModel.deleteWeight(index),
              //                         icon: const Icon(
              //                           Icons.delete_outline,
              //                           color: Colors.redAccent,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
