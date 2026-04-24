import 'package:aifitness/res/widgets/info_card.dart';
import 'package:aifitness/res/widgets/show_change_details_alert.dart';
import 'package:aifitness/res/widgets/signin_second_appbar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/targetChangeScreen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TargetChangeScreen extends StatefulWidget {
  const TargetChangeScreen({super.key});

  @override
  State<TargetChangeScreen> createState() => _TargetChangeScreenState();
}

class _TargetChangeScreenState extends State<TargetChangeScreen>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _offsetAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];

  @override
  void initState() {
    super.initState();
    // Prepare 5 animation controllers (for each card)
    for (int i = 0; i < 5; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );

      _controllers.add(controller);
      _offsetAnimations.add(
        Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
      );
      _opacityAnimations.add(
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
      );

      // Start animation one by one
      Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TargetChangeScreenViewModel>(context);

    final allCards = [
      InfoCard(
        title: "Your Current Status",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(onTap: () {}, child: Text("Weight1: ${vm.weight}")),
            InkWell(onTap: () {}, child: Text("Goal: ${vm.goal}")),
            InkWell(
              onTap: () {},
              child: Text("Weight to lose: ${vm.weightToLose}"),
            ),
          ],
        ),
      ),
      InfoCard(
        title: "Timeline",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pace: ${vm.pace}"),
            Text("Time to final goal: ${vm.timeToGoal}"),
          ],
        ),
      ),
      ...vm.milestones.map(
        (milestone) => InfoCard(
          title: milestone["title"] ?? "",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Target weight: ${milestone["targetWeight"]}"),
              Text("Calories/day: ${milestone["calories"]}"),
              Text("Expected time: ${milestone["time"]}"),
            ],
          ),
        ),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SigninSecondAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Animated Cards
              for (int i = 0; i < allCards.length; i++) ...[
                AnimatedBuilder(
                  animation: _controllers[i],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimations[i].value,
                      child: SlideTransition(
                        position: _offsetAnimations[i],
                        child: child,
                      ),
                    );
                  },
                  child: allCards[i],
                ),
                const SizedBox(height: 12),
              ],

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 180,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      showChangeDetailsAlert(context, vm.changeDetails);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Change Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
