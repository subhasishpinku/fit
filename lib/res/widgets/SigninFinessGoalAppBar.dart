import 'package:aifitness/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SigninFinessGoalAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SigninFinessGoalAppBar({super.key});

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
        textDirection:
            TextDirection.ltr, // Keep AppBar LTR even if screen is RTL
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                "Fitness Goal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              // color: AppColors.primaryColor.withOpacity(0.3),
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
