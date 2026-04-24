import 'package:aifitness/res/widgets/BeginTopBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BeginYourScreen extends StatefulWidget {
  const BeginYourScreen({super.key});

  @override
  State<BeginYourScreen> createState() => _BeginYourScreenState();
}

class _BeginYourScreenState extends State<BeginYourScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset("assets/videos/lose_weight.mp4")
    _controller =
        VideoPlayerController.asset(
            "assets/videos/fitamplify.mov",
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          )
          ..initialize().then((_) {
            if (mounted) setState(() {});
          })
          ..setLooping(true)
          ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeginTopBar(
        onSkip: () {
          _controller.pause(); //  stop video when Skip is tapped
        },
      ),
      //  Pause video before navigation
      body: Container(
        width: double.infinity,
        height: double.infinity,

        ///  Background Image Entire Screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg56.jpg",
            ), // <-- your background image
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 10),

            ///  Title section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Watch This to Begin Your Fitness Transformation with a Trusted Coach",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 🎥 Video Player
            Expanded(
              child: _controller.value.isInitialized
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),

                        /// Yellow subtitle overlay
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Text(
                            "So welcome.",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade600,
                              shadows: const [
                                Shadow(
                                  blurRadius: 10,
                                  offset: Offset(2, 2),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 25),

            /// 🔥 Button below the video
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0),
                  side: const BorderSide(
                    color: AppColors.bolderColor,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  _controller.pause(); //  Pause video before navigation
                  Navigator.pushNamed(context, RouteNames.signinScreen);
                },
                child: Text(
                  "BEGIN YOUR JOURNEY",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
