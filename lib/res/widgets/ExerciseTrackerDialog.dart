import 'package:aifitness/viewModel/AddExerciseTrackerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseTrackerDialog extends StatefulWidget {
  final String exerciseName;
  final int exerciseID;
  final int userId;

  const ExerciseTrackerDialog({
    super.key,
    required this.exerciseName,
    required this.exerciseID,
    required this.userId,
  });

  @override
  State<ExerciseTrackerDialog> createState() => _ExerciseTrackerDialogState();
}

class _ExerciseTrackerDialogState extends State<ExerciseTrackerDialog> {
  // Controllers
  final TextEditingController set1Weight = TextEditingController();
  final TextEditingController set1Reps = TextEditingController();

  final TextEditingController set2Weight = TextEditingController();
  final TextEditingController set2Reps = TextEditingController();

  final TextEditingController set3Weight = TextEditingController();
  final TextEditingController set3Reps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final formattedDate = "${_monthName(date.month)} ${date.day}, ${date.year}";

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- Header ----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "EXERCISE TRACKER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 4),

                Text(
                  widget.exerciseName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                _buildSetSection("Set 1 (Warm-Up Set)", set1Weight, set1Reps),
                const SizedBox(height: 12),

                _buildSetSection("Set 2 (Failure Set)", set2Weight, set2Reps),
                const SizedBox(height: 12),

                _buildSetSection("Set 3 (Pump Set)", set3Weight, set3Reps),

                const SizedBox(height: 22),

                // ---------- Save Button ----------
                SizedBox(
                  width: double.infinity,
                  child: Consumer<AddExerciseTrackerViewModel>(
                    builder: (context, vm, child) {
                      return ElevatedButton(
                        onPressed: vm.loading
                            ? null
                            : () async {
                                final body = {
                                  "set_1_weight": set1Weight.text,
                                  "set_1_reps": set1Reps.text,
                                  "set_2_weight": set2Weight.text,
                                  "set_2_reps": set2Reps.text,
                                  "set_3_weight": set3Weight.text,
                                  "set_3_reps": set3Reps.text,
                                  "user_id": widget.userId,
                                  "exercise_id": widget.exerciseID,
                                };

                                bool success = await vm.saveTracker(body);

                                if (!mounted) return;
                                Navigator.pop(context);
                                print("successView $success");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? "Workout entry saved successfully"
                                          : "Failed to save entry",
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.blue),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: vm.loading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                "Save",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSetSection(
    String title,
    TextEditingController weightCtrl,
    TextEditingController repsCtrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
        ),
        const SizedBox(height: 8),

        _inputBox("Weight (KG)", weightCtrl),
        const SizedBox(height: 6),
        _inputBox("Reps", repsCtrl),
      ],
    );
  }

  Widget _inputBox(String label, TextEditingController controller) {
    return Row(
      children: [
        // LEFT LABEL BOX
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFCCEEFF),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),

        const SizedBox(width: 2),

        // RIGHT VALUE BOX
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFCCEEFF),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
