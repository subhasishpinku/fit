import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/res/widgets/signin_topic_list.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/exercise_list_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
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
          'Unknown platform version';
    } on PlatformException {
      deviceId = 'Failed to get device ID.';
    }

    setState(() {
      _deviceId = deviceId;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("device_id", _deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExerciseListViewModel()..getPlan(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninSecondAppBar(),
        body: Consumer<ExerciseListViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.data == null) {
              return const Center(
                child: Text(
                  "Unable to load workout days",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE FROM API
                  Text(
                    viewModel.data!.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Tap on a day to view your workout plan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// DAYS LIST (API)
                  Expanded(
                    child: SigninTopicList(
                      topics: viewModel.data!.days.map((d) => d.label).toList(),
                      isVisible: viewModel.isVisible, // ← FIXED
                      onTopicSelected: (context, topic) {
                        final selectedDay = viewModel.data!.days.firstWhere(
                          (day) => day.label == topic,
                        );

                        print("Selected Day = ${selectedDay.day}");

                        // Navigation
                        viewModel.selectDay(context, selectedDay.day);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
