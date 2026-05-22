import 'dart:convert';

import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/all_measurement_result_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMeasurementResult extends StatelessWidget {
  const AllMeasurementResult({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllMeasurementResultViewmodel()..getMachineLogs("3353"),

      child: const AllMeasurementResultBody(),
    );
  }
}

class AllMeasurementResultBody extends StatelessWidget {
  const AllMeasurementResultBody({super.key});

  String getValue(List machineData, String name) {
    try {
      final item = machineData.firstWhere((e) => e['name'] == name);

      return item['value'].toString();
    } catch (e) {
      return "0.00";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          title: const Text(
            "All Measurement Result",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),

        body: Consumer<AllMeasurementResultViewmodel>(
          builder: (context, vm, child) {
            if (vm.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error.isNotEmpty) {
              return Center(child: Text(vm.error));
            }

            if (vm.measurementList.isEmpty) {
              return const Center(child: Text("No Measurement Found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),

              itemCount: vm.measurementList.length,

              itemBuilder: (context, index) {
                final item = vm.measurementList[index];

                final machineData = item['machine_data'] ?? [];

                final weight =
                    double.tryParse(
                      getValue(machineData, "Weight"),
                    )?.toStringAsFixed(2) ??
                    "0.00";

                final fat =
                    double.tryParse(
                      getValue(machineData, "Fat Ratio"),
                    )?.toStringAsFixed(2) ??
                    "0.00";

                final muscle =
                    double.tryParse(
                      getValue(machineData, "Muscle Mass"),
                    )?.toStringAsFixed(2) ??
                    "0.00";

                final createdAt = item['created_at'] ?? '';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),

                  child: MeasurementCard(
                    dateTime: createdAt,

                    weight: weight,

                    fat: fat,

                    muscle: muscle,

                    onTap: () {
                      // Convert to JSON string - this is the key fix
                      final machineDataJson = jsonEncode(machineData);

                      Navigator.pushNamed(
                        context,
                        RouteNames.measurementResult,
                        arguments: {
                          "dateTime": createdAt,
                          "machineDataJson":
                              machineDataJson, // Pass JSON string instead of List
                          "weight": weight,
                          "fat": fat,
                          "muscle": muscle,
                        },
                      );

                      print(
                        "machineData length: ${machineData.length}",
                      ); // This should print > 0
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MeasurementCard extends StatelessWidget {
  final String dateTime;
  final String weight;
  final String fat;
  final String muscle;
  final VoidCallback? onTap;

  const MeasurementCard({
    super.key,
    required this.dateTime,
    required this.weight,
    required this.fat,
    required this.muscle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            Image.asset('assets/images/device.png', width: 28, height: 28),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Body fat scale",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Text(
                        dateTime,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      _buildData("Weight", "$weight kg"),

                      _buildData("Fat Ratio", "$fat %"),

                      _buildData("Muscle Mass", "$muscle kg"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildData(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),

        const SizedBox(height: 4),

        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
