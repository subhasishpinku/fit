import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';

class DeviceDashboard extends StatefulWidget {
  const DeviceDashboard({super.key});

  @override
  State<DeviceDashboard> createState() => _DeviceDashboardState();
}

class _DeviceDashboardState extends State<DeviceDashboard> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F6FB),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // HEADER
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/logo2.png", height: 40),
                      ],
                    ),
                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // PROFILE + CARD
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // PROFILE
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                    "assets/images/avtarMale/male_avtar1.jpg",
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
                                      border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "John Doe",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Member since 2024",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // WEIGHT SUMMARY
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            colors: [Color(0xffD8ECFF), Color(0xffA9D0F5)],
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
                              ),
                            ),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                WeightItem("66.5", "20-01-2026"),
                                WeightItem("67.0", "21-01-2026"),
                                WeightItem(
                                  "65.0",
                                  "23-01-206",
                                ), // loading center
                                WeightItem("62.5", "28-01-2026"),
                                WeightItem("64.5", "30-01-2026"),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // const Center(
                            //   child: SizedBox(
                            //     height: 30,
                            //     width: 30,
                            //     child: CircularProgressIndicator(
                            //       strokeWidth: 2,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // MENU ITEMS WITH IMAGES
                buildMenu(
                  icon: Icons.calendar_month,
                  imagePath: "assets/images/allmeserment.png",
                  title: "All Measurement Result",
                  color: Colors.red.shade100,
                  onTap: () {
                    // Navigate to measurement results
                    print("Navigate to All Measurement Result");
                    Navigator.pushNamed(
                      context,
                      RouteNames.allMeasurementResult,
                    );
                  },
                ),
                buildMenu(
                  icon: Icons.group,
                  imagePath: "assets/images/member.png",
                  title: "Member Management",
                  color: Colors.blue.shade100,
                  onTap: () {
                    // Navigate to member management
                    print("Navigate to Member Management");
                  },
                ),
                buildMenu(
                  icon: Icons.emoji_events,
                  imagePath: "assets/images/startfitness.png",
                  title: "Start My Transformation",
                  color: Colors.green.shade100,
                  onTap: () {
                    // Navigate to transformation
                    print("Navigate to Start My Transformation");
                  },
                ),
                buildMenu(
                  icon: Icons.directions_run,
                  imagePath: null, // No image for this one
                  title: "Start My Fitness Plan",
                  color: Colors.purple.shade100,
                  onTap: () {
                    // Navigate to fitness plan
                    print("Navigate to Start My Fitness Plan");
                  },
                ),

                const Spacer(),

                // CONNECT BUTTON WITH IMAGE
                GestureDetector(
                  onTap: () {
                    print("Connect to Fit Amplify Scale");
                    // Add your connection logic here
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background gradient circle
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                            ),
                          ),
                        ),
                        // Image overlay
                        Positioned(
                          top: 0,
                          child: Image.asset(
                            "assets/images/press.png",
                            height: 100,
                            width: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.touch_app,
                                color: Colors.white,
                                size: 30,
                              );
                            },
                          ),
                        ),

                        // Text at bottom
                      ],
                    ),
                  ),
                ),
              ],
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Show image if available, otherwise show icon
            imagePath != null
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 24),
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

// WEIGHT ITEM WIDGET
class WeightItem extends StatelessWidget {
  final String weight;
  final String date;

  const WeightItem(this.weight, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            // 🔵 WHITE TOP BOX
            Container(
              height: 35,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),

            // 🔵 BLUE STICK
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

        Text(date, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
