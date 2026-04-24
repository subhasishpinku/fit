import 'package:flutter/material.dart';

class AllMeasurementResult extends StatelessWidget {
  const AllMeasurementResult({super.key});

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
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              MeasurementCard(
                dateTime: "14-02-2026 3:12 pm",
                weight: "63.50",
                fat: "16.0",
                muscle: "49.7",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/measurement-result',
                    arguments: {
                      'dateTime': "14-02-2026 3:12 pm",
                      'weight': "63.50",
                      'fat': "16.0",
                      'muscle': "49.7",
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              MeasurementCard(
                dateTime: "18-02-2026 6:20 pm",
                weight: "65.35",
                fat: "40.5",
                muscle: "36.1",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/measurement-result',
                    arguments: {
                      'dateTime': "18-02-2026 6:20 pm",
                      'weight': "65.35",
                      'fat': "40.5",
                      'muscle': "36.1",
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              MeasurementCard(
                dateTime: "22-02-2026 9:15 am",
                weight: "64.20",
                fat: "18.5",
                muscle: "48.3",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/measurement-result',
                    arguments: {
                      'dateTime': "22-02-2026 9:15 am",
                      'weight': "64.20",
                      'fat': "18.5",
                      'muscle': "48.3",
                    },
                  );
                },
              ),
            ],
          ),
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
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.monitor_weight, size: 28),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Body fat scale",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dateTime,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}