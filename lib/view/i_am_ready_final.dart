import 'package:aifitness/models/workout_exercise_model.dart';
import 'package:aifitness/repository/IamReadyFinalRepository.dart';
import 'package:aifitness/res/widgets/SigninExerciseAppBar.dart';
import 'package:aifitness/res/widgets/UniversalMediaWidget.dart';
import 'package:aifitness/res/widgets/VimeoPlayerScreen.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/i_am_ready_final_viewModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IamReadyFinal extends StatefulWidget {
  const IamReadyFinal({super.key});

  @override
  State<IamReadyFinal> createState() => _IamReadyFinalState();
}

class _IamReadyFinalState extends State<IamReadyFinal> {
  late IamReadyFinalViewModel viewModel;
  int userId = 0;
  @override
  void initState() {
    super.initState();
    viewModel = IamReadyFinalViewModel();
    load();
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("user_id") ?? 0;
    String? deviceId = prefs.getString("device_id");
    if (deviceId == null) return;
    await viewModel.getExercises(deviceId: deviceId, userId: userId, day: "1");
    Provider.of<IamReadyFinalViewModel>(
      context,
      listen: false,
    ).fetchExerciseTracker(userId, 2365);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<IamReadyFinalViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: const SigninExerciseAppBar(),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(IamReadyFinalViewModel vm) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Workout",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          if (vm.loading) const Center(child: CircularProgressIndicator()),

          if (!vm.loading && vm.errorMessage.isNotEmpty)
            Text(vm.errorMessage, style: const TextStyle(color: Colors.red)),

          if (!vm.loading && vm.exercises.isEmpty)
            const Text("No exercise found"),

          if (!vm.loading && vm.exercises.isNotEmpty)
            ...vm.exercises.map((exercise) {
              return _buildExerciseCard(context, vm, exercise);
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildExerciseCard2(
    BuildContext context,
    IamReadyFinalViewModel vm,
    WorkoutExerciseModel exercise,
  ) {
    // pick EMBEDDED first
    final selectedMedia = exercise.mediaDecoded.isNotEmpty
        ? exercise.mediaDecoded.firstWhere(
            (m) => m.type.toLowerCase() == "embedded",
            orElse: () => exercise.mediaDecoded.first,
          )
        : null;

    final mediaUri = selectedMedia?.uri ?? "";

    final mediaUrl = mediaUri.startsWith("http")
        ? mediaUri
        : "${IamReadyFinalRepository.BASE_URL}/$mediaUri";
    print("mediaUrl ${mediaUrl}");
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          //  UNIVERSAL MEDIA
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54),
            ),
            // child: UniversalMediaWidget(
            //   mediaUri: mediaUri,
            //   mediaUrl: mediaUrl,
            //   height: 240,
            // ),
            child: VimeoPlayerScreen(videoUrl: mediaUri),
          ),

          const SizedBox(height: 16),
          Text(
            "Target Muscle: ${exercise.subcategory}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),

          const Text(
            "Set 1 = Warm-Up Set\nSet 2 = Failure Set\nSet 3 = Working Set (Pump Set)",
            style: TextStyle(fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () =>
                      vm.onHistoryPressed(context, exercise, userId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dashboardColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("History"),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () => vm.onTrackPressed(context, exercise, userId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dashboardColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Track"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
Widget _buildExerciseCard(
  BuildContext context,
  IamReadyFinalViewModel vm,
  WorkoutExerciseModel exercise,
) {
  // Get media URL
  final selectedMedia = exercise.mediaDecoded.isNotEmpty
      ? exercise.mediaDecoded.firstWhere(
          (m) => m.type.toLowerCase() == "embedded",
          orElse: () => exercise.mediaDecoded.first,
        )
      : null;

  String videoUrl = selectedMedia?.uri ?? "";
  
  // Handle relative paths
  if (videoUrl.isNotEmpty && !videoUrl.startsWith('http') && !videoUrl.contains('vimeo.com')) {
    videoUrl = "https://aipoweredfitness.com/$videoUrl";
  }
  
  print("🎬 Final Video URL: $videoUrl");

  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Video Player
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: videoUrl.isNotEmpty
              ? VimeoPlayerScreen(
                  videoUrl: videoUrl,
                  height: 200,
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_library, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('No video available'),
                      ],
                    ),
                  ),
                ),
        ),

        const SizedBox(height: 16),
        Text(
          "Target Muscle: ${exercise.subcategory}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),

        const Text(
          "Set 1 = Warm-Up Set\nSet 2 = Failure Set\nSet 3 = Working Set (Pump Set)",
          style: TextStyle(fontSize: 13.5, height: 1.4),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => vm.onHistoryPressed(context, exercise, userId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dashboardColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("History"),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => vm.onTrackPressed(context, exercise, userId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dashboardColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Track"),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildExerciseCard1(
    BuildContext context,
    IamReadyFinalViewModel vm,
    WorkoutExerciseModel exercise,
  ) {
    // extract image from list — userer API te multiple image thake
    // final String imageUrl = exercise.imageUrlsDecoded.isNotEmpty
    //     ? exercise.imageUrlsDecoded[0].uri
    //     : "";

    final imageUri = exercise.imageUrlsDecoded.isNotEmpty
        ? exercise.imageUrlsDecoded.first.uri
        : "";
    final imageUrl = imageUri.startsWith("http")
        ? imageUri
        : "${IamReadyFinalRepository.BASE_URL}/$imageUri";
    // MEDIA (video / image)
    final mediaUri = exercise.mediaDecoded.isNotEmpty
        ? exercise.mediaDecoded.first.uri
        : "";
    final mediaUrl = mediaUri.startsWith("http")
        ? mediaUri
        : "${IamReadyFinalRepository.BASE_URL}/$mediaUri";
    print("mediaURL $mediaUri");
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Title
          Text(
            exercise.name, //  correct
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Image
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(8),
          //   child: imageUrl.isNotEmpty
          //       ? Image.network(
          //           imageUrl,
          //           width: 70,
          //           height: 70,
          //           fit: BoxFit.cover,
          //           errorBuilder: (_, __, ___) => Image.asset(
          //             "assets/images/placeholder.png",
          //             width: 70,
          //             height: 70,
          //             fit: BoxFit.cover,
          //           ),
          //         )
          //       : Image.asset(
          //           "assets/images/placeholder.png",
          //           width: 70,
          //           height: 70,
          //           fit: BoxFit.cover,
          //         ),
          // ),
          // const SizedBox(height: 10),
          Container(
            height: 250,
            width: 370,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54),
            ),
            // child: const Center(
            //   child: Icon(
            //     Icons.play_circle_fill,
            //     color: Colors.black54,
            //     size: 50,
            //   ),
            child: UniversalMediaWidget(
              mediaUri: mediaUri,
              mediaUrl: mediaUrl,
              height: 220,
            ),

            // child: VimeoPlayerScreen(videoUrl: mediaUri),
          ),

          const SizedBox(height: 16),
          // Target Muscle
          Text(
            "Target Muscle: ${exercise.subcategory}", // 🔥 correct
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),

          const Text(
            "Set 1 = Warm-Up Set\nSet 2 = Failure Set\nSet 3 = Working Set (Pump Set)",
            style: TextStyle(fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        vm.onHistoryPressed(context, exercise, userId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dashboardColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // <-- radius here
                      ),
                    ),
                    child: const Text("History"),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        vm.onTrackPressed(context, exercise, userId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dashboardColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // <-- radius here
                      ),
                    ),
                    child: const Text("Track"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
