import 'package:aifitness/res/widgets/SigninSixthAppBar.dart';
import 'package:aifitness/res/widgets/UniversalMediaWidget.dart';
import 'package:aifitness/res/widgets/signin_fourth_appBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/video_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoViewModel(),
      child: Consumer<VideoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: const SigninSixthAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 15,
                              ),
                              side: BorderSide(
                                color: AppColors.backgroundColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: AppColors.primaryColor,
                              backgroundColor: AppColors.signInButtonColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              "First, you need to do a warm-up to loosen your muscles. "
                              "Please tap the link below and follow the video.",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Video Placeholder ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Full-Body Warm-Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 160,
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
                          mediaUri: "https://player.vimeo.com/video/897714560",
                          mediaUrl: "https://player.vimeo.com/video/897714560",
                          height: 220,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // --- Bottom Instruction ---
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 15,
                              ),
                              side: BorderSide(
                                color: AppColors.backgroundColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: AppColors.primaryColor,
                              backgroundColor: AppColors.signInButtonColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              "Click the 'Complete' button when you're done with the warm-up. "
                              "I'll then give you your main .exercise",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),

                  // --- Complete Button ---
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.onComplete(context);
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
                        elevation: 0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 15,
                        ),
                        child: Text(
                          "Complete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
