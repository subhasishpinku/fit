import 'package:aifitness/res/widgets/CustomDrawer.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/res/widgets/dashboardBody.dart';
import 'package:flutter/material.dart';

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
                    //  FIXED — use Builder to get Scaffold context
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu, color: AppColors.primaryColor),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 190),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // balance spacing
                  ],
                ),
              ),
            ),
          ),
        ),

        ///  Drawer
        drawer: const CustomDrawer(),

        ///  Body
        // body: Center(
        //   child: Text(
        //     "Dashboard Page $pageIndex",
        //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: const DashboardBody(),

        /// Bottom Navigation Bar
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: pageIndex,
        //   onTap: _onPageSelected,
        //   selectedItemColor: Colors.green,
        //   unselectedItemColor: Colors.grey,
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.fitness_center),
        //       label: "Workout",
        //     ),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        //   ],
        // ),
      ),
    );
  }
}
