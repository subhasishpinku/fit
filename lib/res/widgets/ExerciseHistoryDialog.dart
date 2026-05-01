// import 'package:aifitness/viewModel/exercise_tracker_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ExerciseHistoryDialog extends StatelessWidget {
//   final String exerciseName;
//   final int exerciseID;
//   final int userId;

//   const ExerciseHistoryDialog({
//     super.key,
//     required this.exerciseName,
//     required this.exerciseID,
//     required this.userId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Fetch API on dialog load
//     Provider.of<ExerciseTrackerViewModel>(
//       context,
//       listen: false,
//     ).fetchExerciseTracker(userId, exerciseID);
//     print("exerciseID  $userId $exerciseID");
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Dialog(
//         insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Consumer<ExerciseTrackerViewModel>(
//           builder: (context, vm, child) {
//             if (vm.loading) {
//               return const Padding(
//                 padding: EdgeInsets.all(30),
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             }

//             if (vm.history.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.all(30),
//                 child: Center(child: Text("No history found")),
//               );
//             }

//             final item = vm.history[0]; // latest record
//             final formattedDate = item.createdAt;

//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Close Button
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: const Icon(Icons.close, size: 26),
//                       ),
//                     ),
//                     const SizedBox(height: 5),

//                     const Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         "History of your last 5\nworkout tracks",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     const Icon(Icons.playlist_add_check_rounded, size: 80),
//                     const SizedBox(height: 8),

//                     Text(
//                       item.exerciseName,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Track 1",
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           formattedDate,
//                           style: const TextStyle(
//                             fontSize: 11,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Container(height: 1, color: Colors.black),
//                     const SizedBox(height: 12),

//                     _buildSetCard(
//                       title: "Set 1 (Warm-Up Set)",
//                       weight: item.set1.weight.toString(),
//                       reps: item.set1.reps.toString(),
//                     ),
//                     _buildSetCard(
//                       title: "Set 2 (Failure Set)",
//                       weight: item.set2.weight.toString(),
//                       reps: item.set2.reps.toString(),
//                     ),
//                     _buildSetCard(
//                       title: "Set 3 (Pump Set)",
//                       weight: item.set3.weight.toString(),
//                       reps: item.set3.reps.toString(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // Set UI Card
//   Widget _buildSetCard({
//     required String title,
//     required String weight,
//     required String reps,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 6),
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//           color: const Color(0xfff3f3f3),
//           child: Row(
//             children: [
//               const Text("Weight:", style: TextStyle(fontSize: 14)),
//               const SizedBox(width: 10),
//               Text(weight, style: const TextStyle(fontSize: 14)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//           color: const Color(0xfff3f3f3),
//           child: Row(
//             children: [
//               const Text("REPS:", style: TextStyle(fontSize: 14)),
//               const SizedBox(width: 10),
//               Text(reps, style: const TextStyle(fontSize: 14)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 14),
//       ],
//     );
//   }
// }
import 'package:aifitness/viewModel/exercise_tracker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseHistoryDialog extends StatelessWidget {
  final String exerciseName;
  final int exerciseID;
  final int userId;

  const ExerciseHistoryDialog({
    super.key,
    required this.exerciseName,
    required this.exerciseID,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch API on dialog load
    Provider.of<ExerciseTrackerViewModel>(
      context,
      listen: false,
    ).fetchExerciseTracker(userId, exerciseID);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Consumer<ExerciseTrackerViewModel>(
          builder: (context, vm, child) {
            if (vm.loading) {
              return const Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (vm.history.isEmpty) {
              return Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: Text("No history found")),
                  ),

                  /// Close button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            final item = vm.history[0];
            final formattedDate = item.createdAt;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),

                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "History of your last 5\nworkout tracks",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        const Icon(Icons.playlist_add_check_rounded, size: 80),
                        const SizedBox(height: 8),

                        Text(
                          item.exerciseName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Track 1",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(height: 1, color: Colors.black),
                        const SizedBox(height: 12),

                        // _buildSetCard(
                        //   title: "Set 1 (Warm-Up Set)",
                        //   weight: item.set1?.weight?.toString() ?? "-",
                        //   reps: item.set1?.reps?.toString() ?? "-",
                        // ),
                        _buildSetCard(
                          title: "Set 1 (Warm-Up Set)",
                          weight: item.set1?.weight,
                          reps: item.set1?.reps,
                        ),
                        // _buildSetCard(
                        //   title: "Set 2 (Failure Set)",
                        //   weight: item.set2?.weight?.toString() ?? "-",
                        //   reps: item.set2?.reps?.toString() ?? "-",
                        // ),
                        _buildSetCard(
                          title: "Set 2 (Failure Set)",
                          weight: item.set2?.weight,
                          reps: item.set2?.reps,
                        ),
                        // _buildSetCard(
                        //   title: "Set 3 (Pump Set)",
                        //   weight: item.set3?.weight?.toString() ?? "-",
                        //   reps: item.set3?.reps?.toString() ?? "-",
                        // ),
                        _buildSetCard(
                          title: "Set 3 (Pump Set)",
                          weight: item.set3?.weight,
                          reps: item.set3?.reps,
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔥 Top-right close button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSetCard({required String title, int? weight, int? reps}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: const Color(0xfff3f3f3),
          child: Row(
            children: [
              const Text("Weight:", style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              Text(
                weight?.toString() ?? "-",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: const Color(0xfff3f3f3),
          child: Row(
            children: [
              const Text("REPS:", style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              Text(
                reps?.toString() ?? "-",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  /// Set UI Card
  Widget _buildSetCard1({
    required String title,
    required String weight,
    required String reps,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: const Color(0xfff3f3f3),
          child: Row(
            children: [
              const Text("Weight:", style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              Text(weight, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: const Color(0xfff3f3f3),
          child: Row(
            children: [
              const Text("REPS:", style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              Text(reps, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
