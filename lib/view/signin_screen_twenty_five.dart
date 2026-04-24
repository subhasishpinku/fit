import 'dart:async';
import 'package:aifitness/res/widgets/dashboard.dart';
import 'package:aifitness/viewModel/signin_twentyfive_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class SigninScreenTwentyFive extends StatefulWidget {
  const SigninScreenTwentyFive({super.key});

  @override
  State<SigninScreenTwentyFive> createState() => _SigninScreenTwentyFiveState();
}

class _SigninScreenTwentyFiveState extends State<SigninScreenTwentyFive> {
  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    final viewModel = context.read<SigninTwentyFiveViewModel>();

    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (viewModel.progress >= 100) {
        timer.cancel();

        Future.delayed(const Duration(milliseconds: 400), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        });
      } else {
        viewModel.setProgress(viewModel.progress + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<SigninTwentyFiveViewModel>().progress;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            const Text(
              "Generating your personal plan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 40),

            CustomCircularProgress(progress: progress),

            const SizedBox(height: 30),

            const Text(
              "Analyzing your profile...",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ---------------------------------------------------------------
// CUSTOM CIRCULAR PROGRESS BAR (MATCHES YOUR SCREENSHOT PERFECTLY)
// ---------------------------------------------------------------
//

class CustomCircularProgress extends StatelessWidget {
  final double progress; // 0–100

  const CustomCircularProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 170,
      child: CustomPaint(
        painter: _ProgressPainter(progress),
        child: Center(
          child: Text(
            "${progress.toInt()}%",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 12;
    double radius = (size.width - strokeWidth) / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Grey background arc
    final background = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, background);

    // Blue active arc
    final foreground = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double sweepAngle = 2 * pi * (progress / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // starts top
      sweepAngle,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
