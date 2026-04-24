import 'dart:io';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:aifitness/viewModel/account_delete_ViewModel.dart';
import 'package:aifitness/viewModel/account_setting_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  int userId = 0;
  String? deviceId = "";
  String? name = "";
  String? email = "";
  String? imageFullUrl = "";
  int dayAgo = 0;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt("user_id") ?? 0;
      deviceId = prefs.getString("device_id");
      name = prefs.getString("name");
      email = prefs.getString("email");
      imageFullUrl = prefs.getString("image_full_url");
      dayAgo = prefs.getInt("day_ago")!;
    });

    print(
      "UserDetails => $userId | $deviceId | $name | $email  | $imageFullUrl",
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AccountSettingViewModel>(context);
    final vm1 = Provider.of<AccountDeleteViewModel>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Close Button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Profile Section Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // CircleAvatar(
                        //   radius: 70,
                        //   backgroundColor: Colors.grey.shade200,
                        //   backgroundImage: vm.profileImage != null
                        //       ? FileImage(vm.profileImage!)
                        //       : (imageFullUrl != null &&
                        //                 imageFullUrl!.isNotEmpty
                        //             ? NetworkImage(imageFullUrl!)
                        //             : null),
                        //   child:
                        //       vm.profileImage == null &&
                        //           (imageFullUrl == null ||
                        //               imageFullUrl!.isEmpty)
                        //       ? const Icon(
                        //           Icons.person,
                        //           size: 50,
                        //           color: Colors.grey,
                        //         )
                        //       : null,
                        // ),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage:
                              const AssetImage(
                                    "assets/images/profile_image.png",
                                  )
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => vm.pickProfileImage(),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              // child: const Icon(Icons.camera_alt, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),

                    // Joined Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Joined",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${dayAgo} days ago",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // User Info (Name + Email)
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        "${name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${email}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(thickness: 1),
                const SizedBox(height: 8),

                // Menu Options
                _buildMenuItem(
                  context,
                  title: "Delete Profile",
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: AlertDialog(
                            title: Text("Delete Account?"),
                            content: Text(
                              "Are you sure you want to delete your account permanently?",
                            ),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  vm1.deleteAccount(context, userId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.privacyPolicy);
                  },
                ),
                _buildMenuItem(
                  context,
                  title: "Terms of Service",
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.termsCondition);
                  },
                ),
                _buildMenuItem(
                  context,
                  title: "About Us",
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.aboutsUs);
                  },
                ),
                _buildMenuItem(
                  context,
                  title: "Contact US",
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.contactUs);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.black54,
          ),
          onTap: onTap,
        ),
        const Divider(height: 0.5, color: Colors.grey),
      ],
    );
  }
}
