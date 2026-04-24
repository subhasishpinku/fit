import 'package:aifitness/res/widgets/SigninFifthAppBar.dart';
import 'package:aifitness/res/widgets/signin_fourth_appBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/workout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class ExerciseListDetails extends StatefulWidget {
  const ExerciseListDetails({super.key});

  @override
  State<ExerciseListDetails> createState() => _ExerciseListDetailsState();
}

class _ExerciseListDetailsState extends State<ExerciseListDetails> {
  String _deviceId = 'Unknown';
  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();

  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceId;

    try {
      deviceId =
          await _mobileDeviceIdentifierPlugin.getDeviceId() ??
          'Unknown Device ID';
    } on PlatformException {
      deviceId = 'Failed to get device ID';
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("device_id", deviceId);

    if (mounted) {
      setState(() => _deviceId = deviceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutViewModel(),
      child: Builder(
        builder: (context) {
          /// Call LOAD after Provider exists
          Future.microtask(() => load(context));

          return Consumer<WorkoutViewModel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar: const SigninFifthAppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Day 1 - Fullbody Exercise List",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        height: 400,
                        child: viewModel.loading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: viewModel.exercises.length,
                                itemBuilder: (context, index) {
                                  final exercise = viewModel.exercises[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                    ),
                                    child: Text(
                                      exercise.name,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                },
                              ),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.videoScreen,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: BorderSide(
                              color: AppColors.bolderColor,
                              width: 1.4,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              "Start Workout",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Now provider exists when this runs
  Future<void> load(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("user_id") ?? 0;
    String? deviceId = prefs.getString("device_id");
    print("devId $deviceId");
    Provider.of<WorkoutViewModel>(
      context,
      listen: false,
    ).getWorkouts(userId, "1", deviceId!);
  }
}
