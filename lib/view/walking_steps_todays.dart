// import 'package:aifitness/viewModel/walking_steps_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class WalkingStepsTodays extends StatefulWidget {
//   const WalkingStepsTodays({super.key});

//   @override
//   State<WalkingStepsTodays> createState() => _WalkingStepsTodaysState();
// }

// class _WalkingStepsTodaysState extends State<WalkingStepsTodays> {
//   late double _steps;
//   bool _isLoading = true;
//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadInitialData();
//   }

//   Future<void> _loadInitialData() async {
//     setState(() => _isLoading = true);

//     // Get the ViewModel
//     final viewModel = context.read<WalkingStepsViewModel>();

//     // Load walking steps
//     await viewModel.loadWalkingSteps();

//     // Initialize slider with actual steps from API
//     setState(() {
//       _steps = double.tryParse(viewModel.walkingSteps) ?? 0;
//       _isLoading = false;
//     });
//   }

//   double get calories => _steps * 0.04;

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: const Text(
//             "Walking Steps",
//             style: TextStyle(color: Colors.black),
//           ),
//           centerTitle: true,
//           iconTheme: const IconThemeData(color: Colors.black),
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     /// TITLE CARD
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: const [
//                           CircleAvatar(
//                             radius: 22,
//                             backgroundColor: Color(0xFF9ED0FF),
//                             child: Icon(
//                               Icons.directions_walk,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Enter Walking Steps",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Track your daily activity",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// CALORIES CARD
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(.05),
//                             blurRadius: 6,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Calories Burned",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Consumer<WalkingStepsViewModel>(
//                             builder: (context, viewModel, child) {
//                               return RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: (_steps * 0.04).toStringAsFixed(2),
//                                       style: const TextStyle(
//                                         color: Colors.orange,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     const TextSpan(
//                                       text: " Kcal",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// STEPS SLIDER CARD
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(.05),
//                             blurRadius: 6,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Total Steps Today",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               Text(
//                                 _steps.toInt().toString(),
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Slider(
//                             value: _steps,
//                             min: 0,
//                             max: 10000,
//                             divisions: 100,
//                             activeColor: Colors.blue,
//                             onChanged: (value) {
//                               setState(() {
//                                 _steps = value;
//                               });
//                             },
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [Text("0"), Text("10000")],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// SHOW PREVIOUS RECORDS SECTION
//                     Consumer<WalkingStepsViewModel>(
//                       builder: (context, viewModel, child) {
//                         // Check if we have data
//                         if (viewModel.walkingSteps.isEmpty ||
//                             viewModel.walkingSteps == "0" ||
//                             viewModel.walkingSteps == "null") {
//                           return Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   Icons.history,
//                                   size: 40,
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 const Text(
//                                   "No track record found",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   "You'll see your track record here after adding one.",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         } else {
//                           return Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.blue.shade100),
//                             ),
//                             child: Column(
//                               children: [
//                                 const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.history,
//                                       color: Colors.blue,
//                                       size: 20,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Last Record",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     _buildRecordItem(
//                                       icon: Icons.directions_walk_outlined,
//                                       label: "Steps",
//                                       value: "${viewModel.walkingSteps}",
//                                       color: Colors.green,
//                                     ),
//                                     Container(
//                                       height: 30,
//                                       width: 1,
//                                       color: Colors.blue.shade200,
//                                     ),
//                                     _buildRecordItem(
//                                       icon: Icons.local_fire_department,
//                                       label: "Calories",
//                                       value: "${viewModel.caloriesBurn} kcal",
//                                       color: Colors.orange,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                       },
//                     ),

//                     const Spacer(),

//                     /// SAVE BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: _isSaving
//                             ? null
//                             : () async {
//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 int userId = prefs.getInt("user_id") ?? 0;

//                                 // Show loading indicator on button
//                                 setState(() => _isSaving = true);

//                                 // Save steps
//                                 await context
//                                     .read<WalkingStepsViewModel>()
//                                     .saveSteps(
//                                       userId,
//                                       _steps,
//                                       calories,
//                                       context,
//                                     );

//                                 // Reload data after saving
//                                 await _loadInitialData();

//                                 setState(() => _isSaving = false);
//                               },
//                         child: _isSaving
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.white,
//                                   ),
//                                 ),
//                               )
//                             : const Text(
//                                 "Save Steps",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildRecordItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, color: color, size: 24),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
import 'package:aifitness/viewModel/walking_steps_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkingStepsTodays extends StatefulWidget {
  const WalkingStepsTodays({super.key});

  @override
  State<WalkingStepsTodays> createState() => _WalkingStepsTodaysState();
}

class _WalkingStepsTodaysState extends State<WalkingStepsTodays> {
  late double _steps;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);

    // Get the ViewModel
    final viewModel = context.read<WalkingStepsViewModel>();
    //  load dashboard to get latest walking steps data
    // Load walking steps
    await viewModel.loadWalkingSteps();

    // Initialize slider with actual steps from API
    setState(() {
      _steps = double.tryParse(viewModel.walkingSteps) ?? 0;
      _isLoading = false;
    });
  }

  double get calories => _steps * 0.04;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Walking Steps",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// TITLE CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xFF9ED0FF),
                            child: Icon(
                              Icons.directions_walk,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter Walking Steps",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Track your daily activity",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CALORIES CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Calories Burned",
                            style: TextStyle(fontSize: 16),
                          ),
                          Consumer<WalkingStepsViewModel>(
                            builder: (context, viewModel, child) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: (_steps * 0.04).toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " Kcal",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// STEPS SLIDER CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Steps Today",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                _steps.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: _steps,
                            min: 0,
                            max: 10000,
                            divisions: 100,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _steps = value;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [Text("0"), Text("10000")],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ALL RECORDS SECTION
                    Expanded(
                      child: Consumer<WalkingStepsViewModel>(
                        builder: (context, viewModel, child) {
                          // Check if we have data
                          if (viewModel.allRecords.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 40,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "No track record found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "You'll see your track records here after adding them.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "All Records",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: viewModel.allRecords.length,
                                    itemBuilder: (context, index) {
                                      final record =
                                          viewModel.allRecords[index];
                                      final steps =
                                          record["walking_step"]?.toString() ??
                                          "0";
                                      final calories =
                                          record["calories_burn"]?.toString() ??
                                          "0";
                                      final date =
                                          record["created_at"] ??
                                          "Unknown date";

                                      // Format date if needed
                                      String formattedDate = date;
                                      if (date is String && date.length > 10) {
                                        formattedDate = date.substring(0, 10);
                                      }

                                      return Card(
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: index == 0
                                                ? Colors.green
                                                : Colors.blue.shade100,
                                            child: Icon(
                                              Icons.directions_walk,
                                              color: index == 0
                                                  ? Colors.white
                                                  : Colors.blue,
                                            ),
                                          ),
                                          title: Text(
                                            "$steps steps",
                                            style: TextStyle(
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: index == 0
                                                  ? Colors.green
                                                  : Colors.black,
                                            ),
                                          ),
                                          subtitle: Text("$calories kcal"),
                                          trailing: Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),

                    /// SAVE BUTTON
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _isSaving
                              ? null
                              : () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  int userId = prefs.getInt("user_id") ?? 0;

                                  // Show loading indicator on button
                                  setState(() => _isSaving = true);

                                  // Save steps
                                  await context
                                      .read<WalkingStepsViewModel>()
                                      .saveSteps(
                                        userId,
                                        _steps,
                                        calories,
                                        context,
                                      );

                                  // Reload data after saving
                                  await _loadInitialData();
                                  // final viewModeldash = context
                                  //     .watch<DashboardBodyViewModel>();
                                  // viewModeldash.loadDashboard();
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.dashboard,
                                  );

                                  setState(() => _isSaving = false);
                                },
                          child: _isSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "Save Steps",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
