import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/target_change_details_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetChangeDetails extends StatefulWidget {
  const TargetChangeDetails({super.key});

  @override
  State<TargetChangeDetails> createState() => _TargetChangeDetailsState();
}

class _TargetChangeDetailsState extends State<TargetChangeDetails> {
  int userId = 0;
  String? deviceId = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      load(context);
    });
  }

  Future<void> load(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt("user_id") ?? 0;
    deviceId = prefs.getString("device_id");

    print("===== Shared Preferences Loaded Data =====");
    print("User ID: $userId");
    print("Device ID: $deviceId");
    print("==========================================");

    if (deviceId == null) return;

    context.read<TargetChangeDetailsViewModel>().fetchAiDetails(
      deviceId!,
      userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TargetChangeDetailsViewModel>();

    // Wait for API Result — Prevent NULL Error
    if (vm.aiDetails == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final data = vm.aiDetails!.data!.userBodyMetrics!;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.dashboard),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Text(
                "Change Detail",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () => {vm.updateSave(context)},
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Tell us about yourself"),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.heightScreen),
                child: CustomDropTile(
                  title: "What's your height?",
                  value: "${data.heightValue ?? "-"} CM",
                ),
              ),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.weightScreen),
                child: CustomDropTile(
                  title: "What's your weight?",
                  value: "${data.currentWeightValue ?? "-"} KG",
                ),
              ),

              const SizedBox(height: 25),
              _sectionTitle("Workout Options"),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.fitnessGoalScreen),
                child: CustomDropTile(
                  title: "What is your fitness goal?",
                  value: data.fitnessGoal ?? "-",
                ),
              ),

              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteNames.activityLevelScreen,
                ),
                child: CustomDropTile(
                  title: "Current activity level",
                  value: data.activityLevel ?? "-",
                ),
              ),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.currentBfpScreen),
                child: CustomDropTile(
                  title: "Current body fat percentage",
                  value: "${data.currentBfp ?? "-"}%",
                ),
              ),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.targetBfpScreen),
                child: CustomDropTile(
                  title: "Target body fat percentage",
                  value: "${data.targetBfp ?? "-"}%",
                ),
              ),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.worksOutDaysScreen),
                child: CustomDropTile(
                  title: "What day's would you like to workout?",
                  value: "${data.noOfDaysPerWeek ?? 0} Day / Week",
                ),
              ),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.workoutModeScreen),
                child: CustomDropTile(
                  title: "Workout mode",
                  value: data.woMode ?? "-",
                ),
              ),

              const SizedBox(height: 25),
              _sectionTitle("Selects Food"),

              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.dietTypeScreen),
                child: CustomDropTile(
                  title: "Diet type",
                  value: data.mealType ?? "-",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 1, color: Colors.black26)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Divider(thickness: 1, color: Colors.black26)),
        ],
      ),
    );
  }
}

class CustomDropTile extends StatelessWidget {
  final String title;
  final String value;

  const CustomDropTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ],
    );
  }
}
