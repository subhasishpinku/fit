import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/member_profile_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberProfile extends StatelessWidget {
  const MemberProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemberProfileViewModel()..getProfiles(),
      child: const _MemberProfileBody(),
    );
  }
}

class _MemberProfileBody extends StatefulWidget {
  const _MemberProfileBody();

  @override
  State<_MemberProfileBody> createState() => _MemberProfileBodyState();
}

class _MemberProfileBodyState extends State<_MemberProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProfileViewModel>(
      builder: (context, vm, child) {
        final profile = vm.selectedProfile;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xffF3F3F3),
            body: SafeArea(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : profile == null
                  ? const Center(child: Text("No Profiles Found"))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TOP BAR
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Member Profiles",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close, size: 38),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),

                            /// PROFILE LIST
                            SizedBox(
                              height: 130,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: vm.profiles.length,
                                itemBuilder: (context, index) {
                                  final item = vm.profiles[index];
                                  return GestureDetector(
                                    onTap: () {
                                      vm.changeProfile(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 18),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  2,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.network(
                                                    item.profileImage,
                                                    width: 82,
                                                    height: 82,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Container(
                                                            width: 82,
                                                            height: 82,
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                            child: const Icon(
                                                              Icons.person,
                                                              size: 40,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          );
                                                        },
                                                  ),
                                                ),
                                              ),
                                              if (vm.selectedIndex == index)
                                                Positioned(
                                                  right: -2,
                                                  bottom: -2,
                                                  child: Container(
                                                    width: 34,
                                                    height: 34,
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .greenAccent
                                                          .shade400,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                              item.name,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 18),

                            /// PROFILE CARD
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 22,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff667EEA),
                                    Color(0xff5A67D8),
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Hi,\n${profile.name}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      height: 1.1,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      profile.profileImage,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 120,
                                              height: 120,
                                              color: Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildInfoBox(
                                          title: profile.age,
                                          subTitle: "AGE",
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: buildInfoBox(
                                          title: profile.genderText,
                                          subTitle: "GENDER",
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: buildInfoBox(
                                          title: profile.height ?? "0",
                                          subTitle:
                                              "HEIGHT\n${profile.heightUnit ?? ""}",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            /// ADD MEMBER
                            buildButton(
                              text: "Add Member",
                              icon: Icons.group_add_rounded,
                              bgColor: const Color(0xffDDEEFF),
                              textColor: Colors.blue,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.addMember,
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            /// USE THIS PROFILE - WITH CONFIRMATION DIALOG
                            buildButton(
                              text: "Use This Profile",
                              bgColor: Colors.blue,
                              textColor: Colors.white,
                              onTap: () {
                                _showActivateDialog(
                                  context,
                                  profile.name,
                                  () async {
                                    final success = await vm.activateProfile(
                                      profile.id.toString(),
                                    );
                                    if (success && mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${profile.name}'s profile activated!",
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pushNamed(context, RouteNames.deviceDashboard);
                                    } else if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Failed to activate profile",
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            /// DELETE PROFILE
                            buildButton(
                              text: "Delete This Profile",
                              bgColor: const Color(0xffFFD7DD),
                              textColor: Colors.pinkAccent,
                              onTap: () {
                                _showDeleteDialog(
                                  context,
                                  profile.name,
                                  () async {
                                    final success = await vm.deleteProfile(
                                      profile.id as String,
                                    );
                                    if (success && mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Profile deleted successfully!",
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      if (vm.profiles.isEmpty && mounted) {
                                        Navigator.pop(context);
                                      }
                                    } else if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Failed to delete profile",
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showActivateDialog(
    BuildContext context,
    String profileName,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.person_add_alt_1,
                  color: Colors.blue.shade700,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  "Confirm Activation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              "Are you sure you want to activate $profileName’s profile?",
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Activate",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(16),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String profileName,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.red.shade700, size: 28),
              const SizedBox(width: 12),
              const Text(
                "Delete Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to delete $profileName’s profile? This action cannot be undone.",
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.end,
          actionsPadding: const EdgeInsets.all(16),
        );
      },
    );
  }

  Widget buildInfoBox({required String title, required String subTitle}) {
    return Container(
      height: 105,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required String text,
    IconData? icon,
    required Color bgColor,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 30),
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
