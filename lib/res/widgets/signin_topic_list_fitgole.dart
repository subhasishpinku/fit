import 'package:aifitness/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SigninTopicListFitgole extends StatelessWidget {
  final List<String> topics;
  final List<bool> isVisible;
  final ValueChanged<String> onTopicSelected;

  const SigninTopicListFitgole({
    super.key,
    required this.topics,
    required this.isVisible,
    required this.onTopicSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView.separated(
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            opacity: isVisible[index] ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Transform.translate(
              offset: isVisible[index] ? Offset.zero : const Offset(0, 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      side: BorderSide(
                        color: AppColors.bolderColor,
                        width: 1.4,
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => onTopicSelected(topics[index]),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        topics[index],
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
