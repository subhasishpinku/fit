import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/change_details_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeDetails extends StatelessWidget {
  const ChangeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChangeDetailsViewModel>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          title: const Text(
            "Change Detail",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => vm.saveDetails(context),
              child: const Text("Save", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSection(
                context,
                index: 0,
                title: "Tell us about yourself",
                isExpanded: vm.isExpanded[0],
                onToggle: () => vm.toggleExpand(0),
                content: Column(
                  children: [
                    _DetailItem(
                      title: "What's your height?",
                      value: vm.details.height,
                    ),
                    _DetailItem(
                      title: "What's your weight?",
                      value: vm.details.weight,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildSection(
                context,
                index: 1,
                title: "Workout Options",
                isExpanded: vm.isExpanded[1],
                onToggle: () => vm.toggleExpand(1),
                content: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.signinScreenSecond,
                        );
                      },
                      child: _DetailItem(
                        title: "What is your fitness goal?",
                        value: vm.details.fitnessGoal,
                      ),
                    ),
                    _DetailItem(
                      title: "Current activity level",
                      value: vm.details.activityLevel,
                    ),
                    _DetailItem(
                      title: "Current body fat percentage",
                      value: vm.details.currentBodyFat,
                    ),
                    _DetailItem(
                      title: "Target body fat percentage",
                      value: vm.details.targetBodyFat,
                    ),
                    _DetailItem(
                      title: "What days would you like to workout?",
                      value: vm.details.workoutDays,
                    ),
                    _DetailItem(
                      title: "Workout mode",
                      value: vm.details.workoutMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildSection(
                context,
                index: 2,
                title: "Selects Food",
                isExpanded: vm.isExpanded[2],
                onToggle: () => vm.toggleExpand(2),
                content: Column(
                  children: [
                    _DetailItem(title: "Diet type", value: vm.details.dietType),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required int index,
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (i, expanded) => onToggle(),
        children: [
          ExpansionPanel(
            backgroundColor: Colors.white,
            isExpanded: isExpanded,
            headerBuilder: (_, __) => ListTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(padding: const EdgeInsets.all(8.0), child: content),
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;
  const _DetailItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
