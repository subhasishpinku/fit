import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class MeasurementResult extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  
  const MeasurementResult({super.key, this.arguments});

  @override
  State<MeasurementResult> createState() => _MeasurementResultState();
}

class _MeasurementResultState extends State<MeasurementResult> {
  List machineData = [];
  String dateTime = '';
  String weight = '';
  String fat = '';
  String muscle = '';

  @override
  void initState() {
    super.initState();
    _parseArguments();
  }

  void _parseArguments() {
    final args = widget.arguments;
    
    if (args != null) {
      dateTime = args['dateTime'] ?? '';
      weight = args['weight'] ?? '';
      fat = args['fat'] ?? '';
      muscle = args['muscle'] ?? '';
      
      // Get machineDataJson and decode it
      final machineDataJson = args['machineDataJson'] as String?;
      
      if (machineDataJson != null && machineDataJson.isNotEmpty) {
        try {
          final decoded = jsonDecode(machineDataJson);
          if (decoded is List) {
            machineData = decoded;
            print("✅ Successfully decoded machineData: ${machineData.length} items");
            if (machineData.isNotEmpty) {
              print("First item: ${machineData[0]['name']}");
            }
          } else {
            machineData = [];
            print("❌ Decoded data is not a List");
          }
        } catch (e) {
          print("❌ Error decoding machineData: $e");
          machineData = [];
        }
      } else {
        // Fallback: try to get machineData directly
        machineData = args['machineData'] ?? [];
        print("⚠️ Using fallback machineData: ${machineData.length} items");
      }
    } else {
      print("❌ No arguments passed to MeasurementResult");
    }
  }

  String getValue(String name) {
    try {
      final item = machineData.firstWhere((e) => e['name'] == name);
      final value = item['value'];
      if (value is int || value is double) {
        return value.toStringAsFixed(1);
      }
      return double.tryParse(value.toString())?.toStringAsFixed(1) ?? "0.0";
    } catch (e) {
      return "0.0";
    }
  }

  String getUnit(String name) {
    try {
      final item = machineData.firstWhere((e) => e['name'] == name);
      return item['unit']?.toString() ?? '';
    } catch (e) {
      return '';
    }
  }

  String getEvaluation(String name) {
    try {
      final item = machineData.firstWhere((e) => e['name'] == name);
      final evaluation = item['standeValuation'];
      if (evaluation != null && evaluation is String) {
        if (evaluation.contains('leve2')) return 'Standard';
        if (evaluation.contains('leve1')) return 'Low';
        if (evaluation.contains('leve3')) return 'High';
        if (evaluation.contains('leve4')) return 'Very High';
      }
      return 'Standard';
    } catch (e) {
      return 'Standard';
    }
  }

  Color getStatusColor(String name) {
    try {
      final item = machineData.firstWhere((e) => e['name'] == name);
      final colorCode = item['colorCode'];
      if (colorCode != null && colorCode is String && colorCode != '--') {
        return _hexToColor(colorCode);
      }
    } catch (e) {}
    return Colors.cyan;
  }

  Color _hexToColor(String hexCode) {
    String colorStr = hexCode.replaceAll('#', '');
    if (colorStr.length == 6) {
      colorStr = 'FF$colorStr';
    }
    return Color(int.parse(colorStr, radix: 16));
  }

  double getProgressValue() {
    try {
      final bmiItem = machineData.firstWhere((e) => e['name'] == 'BMI');
      final bmi = bmiItem['value'] is double 
          ? bmiItem['value'] as double 
          : double.tryParse(bmiItem['value'].toString()) ?? 0;
      
      if (bmi <= 18.5) {
        return (bmi / 18.5) * 0.5;
      } else if (bmi <= 23) {
        return 0.5 + ((bmi - 18.5) / 4.5) * 0.25;
      } else if (bmi <= 50) {
        return 0.75 + ((bmi - 23) / 27) * 0.25;
      }
      return 0.7;
    } catch (e) {
      return 0.7;
    }
  }

  String getWeightStatus() {
    try {
      final weightItem = machineData.firstWhere((e) => e['name'] == 'Weight');
      final eval = weightItem['standeValuation'];
      if (eval != null && eval.toString().contains('leve2')) return 'Standard';
      if (eval != null && eval.toString().contains('leve1')) return 'Underweight';
      if (eval != null && eval.toString().contains('leve3')) return 'Overweight';
      return 'Standard';
    } catch (e) {
      return 'Standard';
    }
  }

  Color getWeightStatusColor() {
    String status = getWeightStatus();
    if (status == 'Standard') return Colors.cyan;
    if (status == 'Underweight') return Colors.orange;
    if (status == 'Overweight') return Colors.red;
    return Colors.cyan;
  }

String getImage(String name) {
  switch (name.toLowerCase()) {
    // Weight & BMI
    case "weight":
      return "assets/images/DeviceMat/weight/weight.png";
    case "bmi":
      return "assets/images/DeviceMat/BMI/BMI.png";
    
    // Body Composition
    case "fat ratio":
      return "assets/images/DeviceMat/fatRatio/fatRatio.png";
    case "fat mass":
      return "assets/images/DeviceMat/fatMass/fatMass.png";
    case "muscle mass":
      return "assets/images/DeviceMat/muscleMass/muscleMass.png";
    case "muscle rate":
      return "assets/images/DeviceMat/muscleRate/muscleRate.png";
    case "body age":
      return "assets/images/DeviceMat/bodyAge/BodyAge.png";
    case "bone mass":
      return "assets/images/DeviceMat/boneMass/boneMass.png";
    case "body type":
      return "assets/images/DeviceMat/bodyType/bodyType.png";
    
    // Water
    case "water ratio":
      return "assets/images/DeviceMat/waterRatio/waterRatio.png";
    case "total body water":
      return "assets/images/DeviceMat/totalBodyWater/totalBodyWater.png";
    case "intracellular water":
      return "assets/images/DeviceMat/waterInt/waterIntracellulal.png";
    case "extracellular water":
      return "assets/images/DeviceMat/extracellularWater/extracellularWater.png";
    
    // Protein
    case "protein ratio":
      return "assets/images/DeviceMat/proteinRation/proteinRation.png";
    case "protein mass":
      return "assets/images/DeviceMat/proteinMass/proteinMass.png";
    
    // Fat & Control
    case "visceral fat":
      return "assets/images/DeviceMat/visceralFat.imageset/visceralFat.png";
    case "subcutaneous fat ratio":
      return "assets/images/DeviceMat/subcutaneousFatRatio/subcutaneousFatRatio.png";
    case "subcutaneous fat mass":
      return "assets/images/DeviceMat/subcutaneousFatMass/subcutaneousFatMass.png";
    case "fat control":
      return "assets/images/DeviceMat/fatControl/fatControl.png";
    case "muscle control":
      return "assets/images/DeviceMat/muscleControl/muscleControl.png";
    case "weight control":
      return "assets/images/DeviceMat/weightControl/weightControl.png";
    
    // Skeletal
    case "skeletal muscle ratio":
      return "assets/images/DeviceMat/skeletalMuscleRatio/skeletalMuscleRatio.png";
    case "skeletal muscle mass":
      return "assets/images/DeviceMat/skeletalMuscleMass/skeletalMuscleMass.png";
    case "skeletal muscle quality index":
      return "assets/images/DeviceMat/skeletalMuscleQualityIndex/skeletalMuscleQualityIndex.png";
    
    // Weight & Health
    case "standard weight":
      return "assets/images/DeviceMat/standardWeight/standardWeight.png";
    case "ideal weight":
      return "assets/images/DeviceMat/idealWeight/idealWeight.png";
    case "fat free mass":
      return "assets/images/DeviceMat/fatfreeMass/fatfreeMass.png";
    case "health evaluation":
      return "assets/images/DeviceMat/healthEvaluation/healthEvaluation.png";
    case "health score":
      return "assets/images/DeviceMat/healthScore/healthScore.png";
    
    // Body Metrics
    case "heart rate":
      return "assets/images/DeviceMat/heartRate/heartRate.png";
    case "bmr":
      return "assets/images/DeviceMat/recommendedCalorieIntake/recommendedCalorieIntake.png";
    case "obesity degree":
      return "assets/images/DeviceMat/obesityDegree/obesityDegree.png";
    case "obesity level":
      return "assets/images/DeviceMat/obesityLevel/obesityLevel.png";
    case "waist hip ratio":
      return "assets/images/DeviceMat/waisthipRatio/waisthipRatio.png";
    case "minerals":
      return "assets/images/DeviceMat/minerals/minerals.png";
    case "body cell mass":
      return "assets/images/DeviceMat/healthScore/healthScore.png";
    
    // Left Arm
    case "left arm fat ratio":
      return "assets/images/DeviceMat/leftArmFatRatio/leftArmFatRatio.png";
    case "left arm fat mass":
      return "assets/images/DeviceMat/leftArmFatMass/leftArmFatMass.png";
    case "left arm muscle rate":
      return "assets/images/DeviceMat/leftArmMuscleRate/leftArmMuscleRate.png";
    case "left arm muscle mass":
      return "assets/images/DeviceMat/leftArmMuscleMass/leftArmMuscleMass.png";
    
    // Right Arm
    case "right arm fat ratio":
      return "assets/images/DeviceMat/rightArmFatRatio/rightArmFatRatio.png";
    case "right arm fat mass":
      return "assets/images/DeviceMat/rightArmFatMass/rightArmFatMass.png";
    case "right arm muscle rate":
      return "assets/images/DeviceMat/rightArmMuscleRate/rightArmMuscleRate.png";
    case "right arm muscle mass":
      return "assets/images/DeviceMat/rightArmMuscleMass/rightArmMuscleMass.png";
    
    // Left Leg
    case "left leg fat ratio":
      return "assets/images/DeviceMat/leftLegFatRatio/leftLegFatRatio.png";
    case "left leg fat mass":
      return "assets/images/DeviceMat/leftLegFatMass/leftLegFatMass.png";
    case "left leg muscle mass":
      return "assets/images/DeviceMat/leftlegMuscleMas/leftlegMuscleMass.png";
    
    // Right Leg
    case "right leg fat ratio":
      return "assets/images/DeviceMat/rightLegFatRatio/rightLegFatRatio.png";
    case "right leg fat mass":
      return "assets/images/DeviceMat/rightLegFatMass/rightLegFatMass.png";
    case "right leg muscle mass":
      return "assets/images/DeviceMat/rightlegMuscleMass/rightlegMuscleMass.png";
    
    // Feet
    case "left foot muscle rate":
      return "assets/images/DeviceMat/leftFootMuscleRate/leftFootMuscleRate.png";
    case "right foot muscle rate":
      return "assets/images/DeviceMat/rightFootMuscleRate/rightFootMuscleRate.png";
    
    // Trunk
    case "trunk fat percentage":
      return "assets/images/DeviceMat/trunkFatPercentage/trunkFatPercentage.png";
    case "trunk fat mass":
      return "assets/images/DeviceMat/trunkFatMass/trunkFatMass.png";
    case "trunk muscle rate":
      return "assets/images/DeviceMat/trunkMuscleRate/trunkMuscleRate.png";
    case "trunk muscle mass":
      return "assets/images/DeviceMat/trunkMuscleMass/trunkMuscleMass.png";
    
    default:
      return "assets/images/deviceicons/appWeight/device1.png";
  }
}

  List getValidMachineData() {
    return machineData.where((item) {
      final name = item['name']?.toString() ?? '';
      final colorCode = item['colorCode']?.toString() ?? '';
      final value = item['value'];
      
      if (colorCode == '--') return false;
      if (name == 'Obesity Degree') return false;
      if (value == 0 && name.contains('Fat Mass') && name != 'Fat Mass') return false;
      
      final skipPatterns = [
        'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg', 
        'Left Foot', 'Right Foot', 'Trunk'
      ];
      
      for (var pattern in skipPatterns) {
        if (name.contains(pattern) && !name.contains('Mass') && !name.contains('Ratio')) {
          return false;
        }
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final validMachineData = getValidMachineData();
    final weightStatus = getWeightStatus();
    final weightStatusColor = getWeightStatusColor();
    final progressValue = getProgressValue();
    final currentWeight = getValue("Weight");

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xffF6F1FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Text(
            "Measurement Result",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Main Measurement Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/avtarMale/male_avtar1.jpg",
                      height: 55,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.fitness_center, size: 55),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "ada",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTime,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    
                    // Custom Gauge Painter
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: CustomPaint(
                        painter: WeightGaugePainter(
                          progress: progressValue,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentWeight,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "kg",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                weightStatus,
                                style: TextStyle(
                                  color: weightStatusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Disclaimer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.receipt_long, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Our body fat scale and app are not intended for diagnostic purposes. Please be sure to consult a healthcare professional before making any medical decisions.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Metrics Grid
              if (validMachineData.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text("No measurement data available"),
                  ),
                )
              else
                GridView.builder(
                  itemCount: validMachineData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    final item = validMachineData[index];
                    final name = item['name'].toString();
                    final value = item['value'];
                    final unit = item['unit']?.toString() ?? '';
                    final status = getEvaluation(name);
                    final statusColor = getStatusColor(name);
                    
                    String displayValue;
                    if (value is int || value is double) {
                      if (name == 'Heart Rate' || name == 'BMR' || name == 'Health Score') {
                        displayValue = value.toInt().toString();
                      } else {
                        displayValue = value.toStringAsFixed(1);
                      }
                    } else {
                      displayValue = double.tryParse(value.toString())?.toStringAsFixed(1) ?? value.toString();
                    }
                    
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                getImage(name),
                                width: 28,
                                height: 28,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.monitor_weight, size: 28),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "$displayValue $unit",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Gauge Painter Class
class WeightGaugePainter extends CustomPainter {
  final double progress;

  WeightGaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 25;
    final strokeWidth = 14.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // UNDERWEIGHT (Orange)
    final orangePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // STANDARD (Cyan)
    final cyanPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // OVERWEIGHT (Red)
    final redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Draw segmented arcs
    // Underweight section (0 - 0.5 range)
    canvas.drawArc(
      rect,
      pi * 0.8,
      pi * 0.45,
      false,
      orangePaint,
    );

    // Standard section (0.5 - 0.75 range)
    canvas.drawArc(
      rect,
      pi * 1.28,
      pi * 0.55,
      false,
      cyanPaint,
    );

    // Overweight section (0.75 - 1.0 range)
    canvas.drawArc(
      rect,
      pi * 1.86,
      pi * 0.45,
      false,
      redPaint,
    );

    // NEEDLE
    final needleAngle = pi * (0.8 + (1.5 * progress));
    final needleLength = radius - 18;
    final needleEnd = Offset(
      center.dx + needleLength * cos(needleAngle),
      center.dy + needleLength * sin(needleAngle),
    );

    final needlePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    canvas.drawLine(center, needleEnd, needlePaint);

    // Center circle
    canvas.drawCircle(
      center,
      6,
      Paint()..color = Colors.white,
    );

    canvas.drawCircle(
      center,
      4,
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}