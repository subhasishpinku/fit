// import 'package:aifitness/utils/app_colors.dart';
// import 'package:aifitness/utils/routes/routes_names.dart';
// import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class DashboardBody extends StatefulWidget {
//   const DashboardBody({super.key});

//   @override
//   State<DashboardBody> createState() => _DashboardBodyState();
// }

// class _DashboardBodyState extends State<DashboardBody> {
//   bool _isInitialized = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     if (!_isInitialized) {
//       _isInitialized = true;
//       _loadInitialData();
//     }
//   }

//   // Future<void> _loadInitialData() async {
//   //   final viewModel = context.read<DashboardBodyViewModel>();
//   //   await viewModel.loadDashboard();
//   //   await viewModel.loadWalkingSteps();
//   // }
//   Future<void> _loadInitialData() async {
//     await context.read<DashboardBodyViewModel>().loadDashboard();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: RefreshIndicator(
//           // onRefresh: () async {
//           //   final viewModel = context.read<DashboardBodyViewModel>();
//           //   await Future.wait([
//           //     viewModel.loadDashboard(),
//           //     viewModel.loadWalkingSteps(),
//           //   ]);
//           // },
//           onRefresh: () async {
//             await context.read<DashboardBodyViewModel>().loadDashboard();
//           },
//           child: Consumer<DashboardBodyViewModel>(
//             builder: (context, viewModel, child) {
//               if (viewModel.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               return ListView(
//                 padding: const EdgeInsets.all(16),
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 children: [
//                   // ---------------- WEEK HEADER ----------------
//                   Row(
//                     children: [
//                       const Icon(Icons.calendar_today, size: 20),
//                       const SizedBox(width: 8),
//                       Text(
//                         "Week ${viewModel.weekNumber}",
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 6),

//                   // PROGRESS BAR
//                   Container(
//                     height: 4,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: const Color(0x332596be),
//                     ),
//                     child: FractionallySizedBox(
//                       alignment: Alignment.centerLeft,
//                       widthFactor: viewModel.weekProgress.clamp(0.0, 1.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2),
//                           color: const Color(0xFF2596BE),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   // ---------------- CURRENT WEIGHT INFO ----------------
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Current Weight:"),
//                       _infoBox(
//                         "${viewModel.currentWeight.toStringAsFixed(1)} kg",
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Target Weight for This Week:"),
//                       _infoBox("${viewModel.targetWeight} kg"),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Daily Calories for This Week:"),
//                       _infoBox(
//                         "${viewModel.dailyCalories.toStringAsFixed(1)} kcal/day",
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 8),

//                   // -------- WALKING STEPS CARD --------
//                   _walkingStepsCard(context),

//                   const SizedBox(height: 12),

//                   // ---------------- DATA CARDS ----------------
//                   GridView.count(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     crossAxisCount: 2,
//                     childAspectRatio: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     children: [
//                       _DataCard(
//                         title: "Enter Weight Today",
//                         data: viewModel.weightData,
//                         index: 0,
//                       ),
//                       _DataCard(
//                         title: "Enter Body Fat %",
//                         data: viewModel.bfpData,
//                         index: 1,
//                       ),
//                       _DataCard(
//                         title: "Enter Skeletal Muscle Mass",
//                         data: viewModel.skeletalData,
//                         index: 2,
//                       ),
//                       _DataCard(
//                         title: "Enter Subcutaneous Fat",
//                         data: viewModel.subcutaneousData,
//                         index: 3,
//                       ),
//                       _DataCard(
//                         title: "Enter Visceral Fat",
//                         data: viewModel.visceralData,
//                         index: 4,
//                       ),
//                       _DataCard(
//                         title: "Enter Body Water",
//                         data: viewModel.waterData,
//                         index: 5,
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 8),

//                   // ---------------- LOG EXTRA FOOD BUTTON ----------------
//                   GestureDetector(
//                     onTap: () => Navigator.pushNamed(
//                       context,
//                       RouteNames.extraFoodIntakeScreen,
//                     ),
//                     child: _logButton(),
//                   ),

//                   const SizedBox(height: 5),

//                   // ---------------- BOTTOM BUTTONS ----------------
//                   Card(
//                     color: Colors.white,
//                     elevation: 5,
//                     shadowColor: Colors.black26,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     margin: const EdgeInsets.all(5),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 10,
//                       ),
//                       child: _bottomButtons(context),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _walkingStepsCard(BuildContext context) {
//     return Consumer<DashboardBodyViewModel>(
//       builder: (context, viewModel, child) {
//         return Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withOpacity(.08),
//                 blurRadius: 8,
//                 spreadRadius: 2,
//               ),
//             ],
//             border: Border.all(color: Colors.blue.shade100),
//           ),
//           child: Column(
//             children: [
//               /// TOP ROW
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.directions_walk,
//                       color: Colors.blue,
//                     ),
//                   ),

//                   const SizedBox(width: 10),

//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Walking Steps Today",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                       Text(
//                         "Track your daily activity",
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               /// DATA BOX
//               Row(
//                 children: [
//                   /// TOTAL STEPS
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         children: [
//                           const Text(
//                             "Total Steps",
//                             style: TextStyle(fontSize: 12),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             viewModel.walkingSteps,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 8),

//                   /// CALORIES
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         children: [
//                           const Text(
//                             "Calories Burned",
//                             style: TextStyle(fontSize: 12),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "${viewModel.caloriesBurn} Kcal",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               /// BUTTON
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: InkWell(
//                   onTap: () async {
//                     final result = await Navigator.pushNamed(
//                       context,
//                       RouteNames.walkingStepsTodays,
//                     );

//                     // Refresh walking steps when returning
//                     if (result == true) {
//                       context.read<DashboardBodyViewModel>().loadWalkingSteps();
//                     }
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Padding(
//                         padding: EdgeInsets.only(left: 10),
//                         child: Text(
//                           "Enter Today’s Step",
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(right: 10),
//                         child: Icon(Icons.arrow_forward_ios, size: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ---------------- SMALL INFO BOX ----------------
//   Widget _infoBox(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: AppColors.dashboardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.dashboardColor),
//       ),
//       child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   // ---------------- EXTRA FOOD LOG BUTTON ----------------
//   Widget _logButton() => Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(vertical: 14),
//     decoration: BoxDecoration(
//       color: AppColors.dashboardColor,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: const [
//         Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Text(
//             "Log Today’s Extra Food Intake",
//             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(right: 10),
//           child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black87),
//         ),
//       ],
//     ),
//   );

//   // ---------------- BOTTOM BUTTONS ----------------
//   Widget _bottomButtons(BuildContext context) => Column(
//     children: [
//       const SizedBox(height: 10),
//       Center(child: _button(context, "See Exercise List")),
//       const SizedBox(height: 10),
//       Center(child: _button(context, "See Your Nutrition")),
//       const SizedBox(height: 10),
//       Center(child: _button(context, "View Fitness Network")),
//     ],
//   );

//   Widget _button(BuildContext context, String text) => Container(
//     width: double.infinity,
//     margin: const EdgeInsets.symmetric(horizontal: 20),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.blue.shade300, width: 1.2),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.blue.shade100.withOpacity(0.3),
//           blurRadius: 10,
//           spreadRadius: 2,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           if (text == "See Exercise List") {
//             Navigator.pushNamed(context, RouteNames.exerciseListScreen);
//           } else if (text == "See Your Nutrition") {
//             Navigator.pushNamed(context, RouteNames.viewPlanScreen);
//           } else if (text == "View Fitness Network") {
//             Navigator.pushNamed(context, RouteNames.fitNetwork);
//           }
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontSize: 16,
//               letterSpacing: 0.5,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// // ---------------- DATA CARD WITH CHART ----------------
// class _DataCard extends StatelessWidget {
//   final String title;
//   final List<double> data;
//   final int index;

//   const _DataCard({
//     required this.title,
//     required this.data,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         bool? result;
//         if (index == 0) {
//           result =
//               await Navigator.pushNamed(context, RouteNames.weightTodayScreen)
//                   as bool?;
//         } else if (index == 1) {
//           result =
//               await Navigator.pushNamed(context, RouteNames.bodyFatScreen)
//                   as bool?;
//         } else if (index == 2) {
//           result =
//               await Navigator.pushNamed(
//                     context,
//                     RouteNames.skeletalMuscleScreen,
//                   )
//                   as bool?;
//         } else if (index == 3) {
//           result =
//               await Navigator.pushNamed(
//                     context,
//                     RouteNames.subcutaneousFatScreen,
//                   )
//                   as bool?;
//         } else if (index == 4) {
//           result =
//               await Navigator.pushNamed(context, RouteNames.visceralFatScreen)
//                   as bool?;
//         } else if (index == 5) {
//           result =
//               await Navigator.pushNamed(context, RouteNames.bodyWaterScreen)
//                   as bool?;
//         }

//         // Refresh dashboard if data was saved
//         if (result == true) {
//           context.read<DashboardBodyViewModel>().loadDashboard();
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.bolderColor),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 4,
//               offset: const Offset(1, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               decoration: BoxDecoration(
//                 color: AppColors.dashboardColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 14,
//                     color: Colors.black87,
//                   ),
//                 ],
//               ),
//             ),

//             // Chart
//             Column(
//               children: [
//                 if (data.isEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "${_defaultDemoValue(index).toInt()}",
//                           style: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           "${_defaultDemoValue(index).toInt()}",
//                           style: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 SizedBox(
//                   height: 30,
//                   child: Padding(
//                     padding: const EdgeInsets.all(6),
//                     child: SfCartesianChart(
//                       plotAreaBorderWidth: 0,
//                       margin: EdgeInsets.zero,
//                       primaryXAxis: NumericAxis(isVisible: false),
//                       primaryYAxis: NumericAxis(isVisible: false),
//                       series: <CartesianSeries<_ChartData, int>>[
//                         SplineSeries<_ChartData, int>(
//                           dataSource: data.isNotEmpty
//                               ? List.generate(
//                                   data.length,
//                                   (i) => _ChartData(i, data[i]),
//                                 )
//                               : [
//                                   _ChartData(0, _defaultDemoValue(index)),
//                                   _ChartData(1, _defaultDemoValue(index)),
//                                 ],
//                           xValueMapper: (d, _) => d.x,
//                           yValueMapper: (d, _) => d.y,
//                           dashArray: const [6, 4],
//                           color: AppColors.dashboardColor,
//                           width: 2,
//                           markerSettings: MarkerSettings(
//                             isVisible: data.isNotEmpty,
//                             width: 5,
//                             height: 5,
//                             color: Colors.black,
//                             borderColor: Colors.black,
//                           ),
//                           dataLabelSettings: DataLabelSettings(
//                             isVisible: data.isNotEmpty,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   double _defaultDemoValue(int index) {
//     switch (index) {
//       case 0:
//         return 60;
//       case 1:
//         return 20;
//       case 2:
//         return 35;
//       case 3:
//         return 16;
//       case 4:
//         return 10;
//       case 5:
//         return 60;
//       default:
//         return 0;
//     }
//   }
// }

// class _ChartData {
//   final int x;
//   final double y;
//   _ChartData(this.x, this.y);
// }
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      _loadInitialData();
    }
  }

  // Future<void> _loadInitialData() async {
  //   final viewModel = context.read<DashboardBodyViewModel>();
  //   await viewModel.loadDashboard();
  //   await viewModel.loadWalkingSteps();
  // }
  Future<void> _loadInitialData() async {
    await context.read<DashboardBodyViewModel>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: RefreshIndicator(
          // onRefresh: () async {
          //   final viewModel = context.read<DashboardBodyViewModel>();
          //   await Future.wait([
          //     viewModel.loadDashboard(),
          //     viewModel.loadWalkingSteps(),
          //   ]);
          // },
          onRefresh: () async {
            await context.read<DashboardBodyViewModel>().loadDashboard();
          },
          child: Consumer<DashboardBodyViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // ---------------- WEEK HEADER ----------------
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "Week ${viewModel.weekNumber}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // PROGRESS BAR
                  Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color(0x332596be),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: viewModel.weekProgress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xFF2596BE),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ---------------- CURRENT WEIGHT INFO ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Current Weight:"),
                      _infoBox(
                        "${viewModel.currentWeight.toStringAsFixed(1)} kg",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Target Weight for This Week:"),
                      _infoBox("${viewModel.targetWeight} kg"),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Daily Calories for This Week:"),
                      _infoBox(
                        "${viewModel.dailyCalories.toStringAsFixed(1)} kcal/day",
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // -------- WALKING STEPS CARD --------
                  _walkingStepsCard(context),

                  const SizedBox(height: 12),

                  // ---------------- DATA CARDS ----------------
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _DataCard(
                        title: "Enter Weight Today",
                        data: viewModel.weightData,
                        index: 0,
                      ),
                      _DataCard(
                        title: "Enter Body Fat %",
                        data: viewModel.bfpData,
                        index: 1,
                      ),
                      _DataCard(
                        title: "Enter Skeletal Muscle Mass",
                        data: viewModel.skeletalData,
                        index: 2,
                      ),
                      _DataCard(
                        title: "Enter Subcutaneous Fat",
                        data: viewModel.subcutaneousData,
                        index: 3,
                      ),
                      _DataCard(
                        title: "Enter Visceral Fat",
                        data: viewModel.visceralData,
                        index: 4,
                      ),
                      _DataCard(
                        title: "Enter Body Water",
                        data: viewModel.waterData,
                        index: 5,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ---------------- LOG EXTRA FOOD BUTTON ----------------
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.extraFoodIntakeScreen,
                    ),
                    child: _logButton(),
                  ),

                  const SizedBox(height: 5),

                  // ---------------- BOTTOM BUTTONS ----------------
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: _bottomButtons(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _walkingStepsCard(BuildContext context) {
    return Consumer<DashboardBodyViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.08),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            children: [
              /// TOP ROW
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.directions_walk,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Walking Steps Today",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Track your daily activity",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// DATA BOX
              Row(
                children: [
                  /// TOTAL STEPS
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Total Steps",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            viewModel.walkingSteps,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// CALORIES
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Calories Burned",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${viewModel.caloriesBurn} Kcal",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// BUTTON
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      RouteNames.walkingStepsTodays,
                    );

                    // Refresh walking steps when returning
                    if (result == true) {
                      context.read<DashboardBodyViewModel>().loadWalkingSteps();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Enter Today’s Step",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- SMALL INFO BOX ----------------
  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.dashboardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dashboardColor),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // ---------------- EXTRA FOOD LOG BUTTON ----------------
  Widget _logButton() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: AppColors.dashboardColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Log Today’s Extra Food Intake",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black87),
        ),
      ],
    ),
  );

  // ---------------- BOTTOM BUTTONS ----------------
  Widget _bottomButtons(BuildContext context) => Column(
    children: [
      const SizedBox(height: 10),
      Center(child: _button(context, "See Exercise List")),
      const SizedBox(height: 10),
      Center(child: _button(context, "See Your Nutrition")),
      const SizedBox(height: 10),
      Center(child: _button(context, "View Fitness Network")),
    ],
  );

  Widget _button(BuildContext context, String text) => Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade100.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (text == "See Exercise List") {
            Navigator.pushNamed(context, RouteNames.exerciseListScreen);
          } else if (text == "See Your Nutrition") {
            Navigator.pushNamed(context, RouteNames.viewPlanScreen);
          } else if (text == "View Fitness Network") {
            Navigator.pushNamed(context, RouteNames.fitNetwork);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------- DATA CARD WITH CHART ----------------
class _DataCard extends StatelessWidget {
  final String title;
  final List<double> data;
  final int index;

  const _DataCard({
    required this.title,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool? result;
        if (index == 0) {
          result =
              await Navigator.pushNamed(context, RouteNames.weightTodayScreen)
                  as bool?;
        } else if (index == 1) {
          result =
              await Navigator.pushNamed(context, RouteNames.bodyFatScreen)
                  as bool?;
        } else if (index == 2) {
          result =
              await Navigator.pushNamed(
                    context,
                    RouteNames.skeletalMuscleScreen,
                  )
                  as bool?;
        } else if (index == 3) {
          result =
              await Navigator.pushNamed(
                    context,
                    RouteNames.subcutaneousFatScreen,
                  )
                  as bool?;
        } else if (index == 4) {
          result =
              await Navigator.pushNamed(context, RouteNames.visceralFatScreen)
                  as bool?;
        } else if (index == 5) {
          result =
              await Navigator.pushNamed(context, RouteNames.bodyWaterScreen)
                  as bool?;
        }

        // Refresh dashboard if data was saved
        if (result == true) {
          context.read<DashboardBodyViewModel>().loadDashboard();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.bolderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.dashboardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),

            // Chart
            Column(
              children: [
                if (data.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_defaultDemoValue(index).toInt()}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "${_defaultDemoValue(index).toInt()}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      margin: EdgeInsets.zero,
                      primaryXAxis: NumericAxis(isVisible: false),
                      primaryYAxis: NumericAxis(isVisible: false),
                      series: <CartesianSeries<_ChartData, int>>[
                        SplineSeries<_ChartData, int>(
                          dataSource: data.isNotEmpty
                              ? List.generate(
                                  data.length,
                                  (i) => _ChartData(i, data[i]),
                                )
                              : [
                                  _ChartData(0, _defaultDemoValue(index)),
                                  _ChartData(1, _defaultDemoValue(index)),
                                ],
                          xValueMapper: (d, _) => d.x,
                          yValueMapper: (d, _) => d.y,
                          dashArray: const [6, 4],
                          color: AppColors.dashboardColor,
                          width: 2,
                          markerSettings: MarkerSettings(
                            isVisible: data.isNotEmpty,
                            width: 5,
                            height: 5,
                            color: Colors.black,
                            borderColor: Colors.black,
                          ),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: data.isNotEmpty,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _defaultDemoValue(int index) {
    switch (index) {
      case 0:
        return 60;
      case 1:
        return 20;
      case 2:
        return 35;
      case 3:
        return 16;
      case 4:
        return 10;
      case 5:
        return 60;
      default:
        return 0;
    }
  }
}

class _ChartData {
  final int x;
  final double y;
  _ChartData(this.x, this.y);
}
