import 'package:flutter/material.dart';

class MeasurementResult extends StatefulWidget {
  const MeasurementResult({super.key});

  @override
  State<MeasurementResult> createState() =>
      _MeasurementResultState();
}

class _MeasurementResultState
    extends State<MeasurementResult> {

  Map<String, dynamic>? args;

  List machineData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    args =
    ModalRoute.of(context)?.settings.arguments
    as Map<String, dynamic>?;

    machineData = args?['machineData'] ?? [];
  }

  String getValue(String name) {

    try {

      final item = machineData.firstWhere(
            (e) => e['name'] == name,
      );

      return double.tryParse(
        item['value'].toString(),
      )?.toStringAsFixed(2) ??
          "0.00";

    } catch (e) {

      return "0.00";
    }
  }

  String getImage(String name) {

    switch (name) {

      case "Weight":
        return "assets/images/DeviceMat/weight/weight.png";

      case "BMI":
        return "assets/images/DeviceMat/BMI/BMI.png";

      case "Fat Ratio":
        return "assets/images/DeviceMat/fatRatio/fatRatio.png";

      case "Fat Mass":
        return "assets/images/DeviceMat/fatMass/fatMass.png";

      case "Muscle Mass":
        return "assets/images/DeviceMat/muscleMass/muscleMass.png";

      case "Muscle Rate":
        return "assets/images/DeviceMat/muscleRate/muscleRate.png";

      case "Body Age":
        return "assets/images/DeviceMat/bodyAge/BodyAge.png";

      case "Bone Mass":
        return "assets/images/DeviceMat/boneMass/boneMass.png";

      case "Water Ratio":
        return "assets/images/DeviceMat/waterRatio/waterRatio.png";

      case "Protein Ratio":
        return "assets/images/DeviceMat/proteinRation/proteinRation.png";

      case "Visceral Fat":
        return "assets/images/DeviceMat/visceralFat.imageset/visceralFat.png";

      default:
        return "assets/images/deviceicons/appWeight/device1.png";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F1FA),

      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0,

        foregroundColor: Colors.black,

        title: const Text(
          "Measurement Result",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(12),

        child: Column(

          children: [

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
                    "assets/images/deviceicons/appOnly/appOnly.png",
                    height: 55,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "ada",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    args?['dateTime'] ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(

                    height: 180,

                    child: Stack(

                      alignment: Alignment.center,

                      children: [

                        SizedBox(
                          width: 180,
                          height: 180,

                          child: CircularProgressIndicator(
                            value: 0.7,
                            strokeWidth: 14,
                            backgroundColor: Colors.orange,
                            valueColor:
                            const AlwaysStoppedAnimation(
                              Colors.red,
                            ),
                          ),
                        ),

                        Column(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            const Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),

                            Text(
                              getValue("Weight"),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "kg",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Standard",
                              style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.receipt_long,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      "Our body fat scale and app are not intended for diagnostic purposes.",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(

              itemCount: machineData.length,

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,

                childAspectRatio: 1.25,
              ),

              itemBuilder: (context, index) {

                final item = machineData[index];

                final name =
                    item['name'].toString();

                final value =
                    item['value'].toString();

                final unit =
                    item['unit'].toString();

                return Container(

                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(14),
                  ),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Row(

                        children: [

                          Image.asset(
                            getImage(name),
                            width: 28,
                            height: 28,
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontWeight:
                                FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Text(
                        "${double.tryParse(value)?.toStringAsFixed(2) ?? value} $unit",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Standard",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}