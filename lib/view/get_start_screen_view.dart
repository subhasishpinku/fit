import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GetStartScreenView extends StatefulWidget {
  const GetStartScreenView({super.key});

  @override
  State<GetStartScreenView> createState() => _GetStartScreenViewState();
}

class _GetStartScreenViewState extends State<GetStartScreenView> {
  late VideoPlayerController _controller;
  bool showVideo = true;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.asset(
      "assets/videos/fitamplifyy.mov",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    await _controller.initialize();

    if (mounted) {
      setState(() {});
      _controller.setLooping(true);
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg1.png",
              fit: BoxFit.cover,
            ),
          ),

          /// MAIN UI (UNCHANGED)
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                Image.asset("assets/images/logo2.png", height: 140),

                const SizedBox(height: 25),

                const Text(
                  "Diet and Exercise Planner",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreen,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 197, 137, 221),
                          ),
                        ),
                      ),
                      child: const Text(
                        "GET STARTED",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 VIDEO OVERLAY (ADDED ONLY THIS)
          if (showVideo && _controller.value.isInitialized)
            Container(
              color: Colors.black.withOpacity(0.95),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),

                  /// CLOSE BUTTON
                  Positioned(
                    top: 40,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        _controller.pause();
                        setState(() => showVideo = false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}