import 'package:aifitness/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SigninThirdAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // 👈 Dynamic title text
  final bool showBackButton; // Optional: allows hiding back button if needed

  const SigninThirdAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr, // Keep AppBar LTR
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          title: Row(
            children: [
              if (showBackButton)
                IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                  onPressed: () => Navigator.pop(context),
                ),
              Expanded(
                child: Text(
                  title, // 👈 Dynamic Title
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 48), // Keeps spacing balanced
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: SizedBox(height: 1),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
