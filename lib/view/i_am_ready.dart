import 'package:aifitness/res/widgets/SigninSeventhAppBar.dart';
import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/i_am_ready_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IamReady extends StatefulWidget {
  const IamReady({super.key});

  @override
  State<IamReady> createState() => _IamReadyState();
}

class _IamReadyState extends State<IamReady> {
  String deload_week = "0";
  String progressive_week = "0";

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      deload_week = prefs.getString("deload_week") ?? "0";
      progressive_week = prefs.getString("progressive_week") ?? "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IamReadyViewModel(),
      child: Consumer<IamReadyViewModel>(
        builder: (context, viewModel, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: const SigninSeventhAppBar(),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Read These Instructions Before Starting\nYour Workout",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ---------- WEEK BLOCKS ----------
                            if (progressive_week == "1")
                              _buildWeekCard(
                                title: "Your Progressive Overload starts now!",
                                description:
                                    "For the next 3 weeks, focus on gradually increasing your equipment weights or reps to challenge your muscles and build strength",
                              ),

                            if (deload_week == "1")
                              _buildWeekCard(
                                title: "This week is your Deload Week",
                                description:
                                    "Reduce your working set weights, focus on proper form, and allow your muscles to recover. Use this week to recharge and prepare for the next progression cycle",
                              ),

                            const SizedBox(height: 20),

                            // ---------- Set Structure ----------
                            _sectionHeader("Set Structure"),
                            const SizedBox(height: 20),

                            // ---------- SET 1 ----------
                            _buildSetCard(
                              title: "Set 1 – Warm-Up Set",
                              description:
                                  "For the warm-up set, choose a weight that you can lift easily without much effort, roughly around your 1 Rep Max level for preparation. You should be able to complete 10 reps comfortably while focusing on proper form.",
                            ),
                            const SizedBox(height: 16),

                            // ---------- SET 2 ----------
                            _buildSetCard(
                              title: "Set 2 – Failure Set",
                              description:
                                  "Choose a weight that challenges you to the point where completing 10 reps becomes impossible. On your first attempt, you may only manage around 5–6 reps before reaching failure, where you can no longer perform a rep with proper form.\n\n"
                                  "Over the course of 4 weeks, the goal is to progressively increase the number of reps until you can complete all 10 reps at the chosen weight. This process promotes progressive overload, which is essential for building strength and muscle endurance.",
                            ),
                            const SizedBox(height: 16),

                            // ---------- SET 3 ----------
                            _buildSetCard(
                              title: "Set 3 – Pump Set",
                              description:
                                  "Choose a weight that allows you to complete 10 reps with moderate difficulty. The 10 reps should feel challenging towards the last few reps, but still manageable without compromising form.\n\n"
                                  "Focus on maintaining proper form throughout the set, ensuring that each rep is controlled and effective.",
                            ),
                            const SizedBox(height: 24),

                            // ---------- Track Progress ----------
                            _sectionHeader("Track Progress"),
                            const SizedBox(height: 14),

                            _buildSetCards(
                              description:
                                  "Use the Track button to log reps, sets, and weights.\n\n"
                                  "Use the History button to review past performance.",
                            ),

                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ),
                    // ---------- I'm Ready ----------
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: OutlinedButton(
                          onPressed: () {
                            viewModel.onTrackProgress(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: AppColors.bolderColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            "I'm Ready",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= HELPER WIDGETS =================

  Widget _sectionHeader(String title) {
    return IntrinsicWidth(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
          side: BorderSide(color: AppColors.backgroundColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: AppColors.primaryColor,
          backgroundColor: AppColors.signInButtonColor,
        ),
        onPressed: () {},
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildWeekCard({required String title, required String description}) {
    return Column(
      children: [
        _sectionHeader(title),
        const SizedBox(height: 20),
        _buildSetCards(description: description),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSetCard({required String title, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.bolderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetCards({required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.bolderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 14.5,
          height: 1.5,
          color: Colors.black87,
        ),
      ),
    );
  }
}
