import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  late VideoPlayerController _controller;
  bool showVideo = true;
  int selectedIndex = 1;

  String? deviceId = "";
  String? email = "";
  String? password = "";
  String? imageFullUrl = "";
  String? name = "";
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _initVideo();
    _loadUserData();
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

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        userId = prefs.getInt("user_id") ?? 0;
        deviceId = prefs.getString("device_id");
        name = prefs.getString("name");
        email = prefs.getString("email");
        imageFullUrl = prefs.getString("image_full_url");
        password = prefs.getString("password");
      });
    }
  }

  void _handleGetStarted() {
    print(
      "Selected: ${selectedIndex == 0 ? 'Smart Scale Only' : 'Complete Experience'}",
    );

    // Check if Complete Experience is selected (index 1)
    if (selectedIndex == 1) {
      // Navigate to begin your screen for Complete Experience
      Navigator.pushNamed(context, RouteNames.signinScreen);
    } else {
      Navigator.pushNamed(context, RouteNames.deviceDashboard);

      // Or show a message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Smart Scale Only feature coming soon!'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/images/bg1.png", fit: BoxFit.cover),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 20),
                    _buildOptionsSection(),
                    const SizedBox(height: 30),
                    _buildGetStartedButton(),
                  ],
                ),
              ),
            ),
            if (showVideo && _controller.value.isInitialized)
              _buildVideoOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Image.asset("assets/images/logo2.png", height: 140),
        const SizedBox(height: 10),
        const Text(
          "Empowering Your Health Journey",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      children: [
        const Text(
          "Choose Your Path",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          "Select how you'd like to use FitAmplify",
          style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 17, 8, 8)),
        ),
        const SizedBox(height: 20),

        _buildOptionCard(
          index: 0,
          title: "Smart Scale Only",
          subtitle: "For weight & health tracking",
          features: const [
            "Auto weight sync with smart scale",
            "Complete weight history & trends",
            "BMI tracking & insights",
            "Basic analytics dashboard",
            "Support multiple users",
          ],
        ),

        const SizedBox(height: 16),

        _buildOptionCard(
          index: 1,
          title: "Complete Experience",
          subtitle: "Diet & Exercise Planner",
          features: const [
            "Auto weight sync with smart scale",
            "Personalized diet & exercise plans",
            "Advanced AI-powered analytics",
            "Body composition analysis",
            "⚠ Single user supported",
          ],
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required List<String> features,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  index == 0
                      ? "assets/images/device.png"
                      : "assets/images/device1.png",
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      index == 0 ? Icons.speed : Icons.fitness_center,
                      size: 60,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ Custom Radio Button
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ✅ Feature List
            Column(
              children: features.map((feature) {
                final isWarning = feature.contains("⚠");

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isWarning ? Colors.orange : Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isWarning ? Icons.warning : Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature.replaceAll("⚠ ", ""),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _handleGetStarted,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: InkWell(
          onTap: _handleGetStarted,
          child: const Text(
            "GET STARTED",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoOverlay() {
    return Container(
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
    );
  }
}
