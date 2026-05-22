import 'package:aifitness/res/widgets/CustomDrawer.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/res/widgets/dashboardBody.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/dashboardBody_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;

  void _onPageSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,

        /// Custom AppBar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SafeArea(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu button
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu, color: AppColors.primaryColor),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),

                    // Dashboard title
                    Expanded(
                      child: Center(
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),

                    // Bluetooth button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.blutootnScreen,
                        );
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/press.png",
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.touch_app,
                                color: Colors.white,
                                size: 24,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Drawer
        drawer: const CustomDrawer(),

        /// Body - changes based on bottom nav selection
        body: pageIndex == 0
            ? ChangeNotifierProvider(
                create: (_) => DashboardBodyViewModel(),
                child: const DashboardBody(),
              )
            : Center(
                child: Text(
                  pageIndex == 1 ? "Workout Page" : "Profile Page",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

        /// Bottom Navigation Bar
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: pageIndex,
        //   onTap: _onPageSelected,
        //   selectedItemColor: AppColors.primaryColor,
        //   unselectedItemColor: Colors.grey,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.dashboard),
        //       label: "Dashboard",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.fitness_center),
        //       label: "Workout",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: "Profile",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}