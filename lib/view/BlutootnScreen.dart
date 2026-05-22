import 'package:flutter/material.dart';

class BlutootnScreen extends StatefulWidget {
  const BlutootnScreen({super.key});

  @override
  State<BlutootnScreen> createState() => _BlutootnScreenState();
}

class _BlutootnScreenState extends State<BlutootnScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCircle(double size, Color color) {
    return ScaleTransition(
      scale: _controller,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
      
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: const Text(
            "Connect to Fit Amplify Scale",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
        ),
      
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
      
              const SizedBox(height: 10),
      
              const Text(
                "Stand on the scale to automatically pair\nwith your device",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
      
              const Spacer(),
      
              /// Bluetooth Animation
              Stack(
                alignment: Alignment.center,
                children: [
      
                  buildCircle(
                    200,
                    Colors.blue.withOpacity(0.08),
                  ),
      
                  buildCircle(
                    120,
                    Colors.blue.withOpacity(0.12),
                  ),
      
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bluetooth,
                      color: Colors.indigo,
                      size: 40,
                    ),
                  ),
                ],
              ),
      
              const Spacer(),
      
              /// Bottom Instruction Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F8FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    const Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "How to Connect",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 12),
      
                    buildStep(
                      "Make sure Bluetooth is enabled on your phone",
                    ),
      
                    buildStep(
                      "Step onto the scale with bare feet",
                    ),
      
                    buildStep(
                      "Wait for automatic pairing to complete",
                    ),
      
                    const SizedBox(height: 14),
      
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          Icon(
                            Icons.lightbulb,
                            color: Colors.amber,
                            size: 18,
                          ),
      
                          SizedBox(width: 8),
      
                          Expanded(
                            child: Text(
                              "Place the scale on a flat, hard surface for the most accurate measurements. Avoid carpeted areas.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 12,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}