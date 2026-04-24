import 'package:aifitness/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SigninHeader extends StatelessWidget {
  const SigninHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntrinsicWidth(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
            side: BorderSide(color: AppColors.backgroundColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.signInButtonColor,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              textAlign: TextAlign.right,
              "What are you looking for in your \n fitness journey?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
