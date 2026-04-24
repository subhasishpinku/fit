import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';

class SigninSixthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SigninSixthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left side: Back + AI FITNESS
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Warm-up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              /// Right side: Home Icon
              IconButton(
                icon: Icon(Icons.home_outlined, color: AppColors.primaryColor),
                onPressed: () {
                  // TODO: Navigate to home screen
                  // Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, RouteNames.dashboard);
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
