import 'package:aifitness/models/weight_summary_model.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/device_dashboard_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceDashboard extends StatefulWidget {
  const DeviceDashboard({super.key});

  @override
  State<DeviceDashboard> createState() => _DeviceDashboardState();
}

class _DeviceDashboardState extends State<DeviceDashboard> {
  final DeviceDashboardViewModel viewModel = DeviceDashboardViewModel();
  String _deviceId = 'Unknown';
  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();
@override
void initState() {
  super.initState();

  initDeviceId();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    viewModel.getAllProfiles(context);
  });

  viewModel.addListener(() {
    if (mounted) {
      setState(() {});
    }
  });
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F6FB),

        body: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      children: [
                        /// HEADER
                        Row(
                          children: [
                            Image.asset("assets/images/logo2.png", height: 40),

                            const SizedBox(width: 10),

                            const Text(
                              "Dashboard",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// PROFILE CARD
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            color: Colors.white,

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              /// PROFILE
                              Padding(
                                padding: const EdgeInsets.all(16),

                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 32,

                                          backgroundImage: AssetImage(
                                            viewModel.getProfileImage(),
                                          ),
                                        ),

                                        Positioned(
                                          bottom: 2,
                                          right: 2,

                                          child: Container(
                                            height: 14,
                                            width: 14,

                                            decoration: BoxDecoration(
                                              color: Colors.green,

                                              shape: BoxShape.circle,

                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            viewModel.getUserName(),

                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            viewModel.getMemberSince(),

                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// WEIGHT SUMMARY
                              Container(
                                width: double.infinity,

                                padding: const EdgeInsets.all(16),

                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20),
                                  ),

                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffD8ECFF),
                                      Color(0xffA9D0F5),
                                    ],
                                  ),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    const Text(
                                      "Weight Summary",

                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,

                                      child: Row(
                                        children: viewModel.weightList
                                            .map(
                                              (WeightSummaryModel e) => Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 20,
                                                ),

                                                child: WeightItem(
                                                  weight: e.weight,
                                                  date: e.date,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// MENU 1
                        buildMenu(
                          icon: Icons.calendar_month,

                          imagePath: "assets/images/allmeserment.png",

                          title: "All Measurement Result",

                          color: Colors.red.shade100,

                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.allMeasurementResult,
                            );
                          },
                        ),

                        /// MENU 2
                        buildMenu(
                          icon: Icons.group,

                          imagePath: "assets/images/member.png",

                          title: "Member Management",

                          color: Colors.blue.shade100,

                          onTap: () {
                              Navigator.pushNamed(
                              context,
                              RouteNames.memberProfile,
                            );
                          },
                        ),

                        /// MENU 3
                        buildMenu(
                          icon: Icons.emoji_events,

                          imagePath: "assets/images/startfitness.png",

                          title: "Start My Transformation",

                          color: Colors.green.shade100,

                          onTap: () {
                              Navigator.pushNamed(
                              context,
                              RouteNames.browserOpenLink,
                            );
                          },
                        ),

                        /// MENU 4
                        buildMenu(
                          icon: Icons.directions_run,

                          imagePath: null,

                          title: "Start My Fitness Plan",

                          color: Colors.purple.shade100,

                          onTap: () {
                              Navigator.pushNamed(
                              context,
                              RouteNames.signinScreen,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        /// CONNECT BUTTON
                        GestureDetector(
                          onTap: () {},

                          child: Container(
                            height: 100,
                            width: 100,

                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,

                              gradient: LinearGradient(
                                colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                              ),
                            ),

                            child: Stack(
                              alignment: Alignment.center,

                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.blutootnScreen,
                                    );
                                  },
                                  child: Positioned(
                                    top: 0,

                                    child: Image.asset(
                                      "assets/images/press.png",

                                      height: 100,
                                      width: 100,

                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.touch_app,
                                              color: Colors.white,
                                              size: 32,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildMenu({
    required IconData icon,
    String? imagePath,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),

              blurRadius: 8,

              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            imagePath != null
                ? Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: color,

                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Image.asset(
                      imagePath,

                      height: 24,
                      width: 24,

                      errorBuilder: (context, error, stackTrace) {
                        return Icon(icon, size: 24);
                      },
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: color,

                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Icon(icon, size: 24),
                  ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class WeightItem extends StatelessWidget {
  final String weight;
  final String date;

  const WeightItem({super.key, required this.weight, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            /// TOP WHITE BOX
            Container(
              height: 35,
              width: 25,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(8),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),

                    blurRadius: 4,

                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),

            /// BLUE STICK
            Container(
              height: 45,
              width: 4,

              decoration: BoxDecoration(
                color: Colors.blue,

                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          weight,

          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),

        Text(date, style: const TextStyle(fontSize: 8, color: Colors.black54)),
      ],
    );
  }
}
