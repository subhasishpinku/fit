import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? deviceId = "";
  String? email = "";
  String? imageFullUrl = "";
  String? name = "";
  int userId = 0;

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
    });

    print(
      "UserDetails => $userId | $deviceId | $name | $email  | $imageFullUrl",
    );
  }

  /// Logout logic
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.getStartScreenView,
      (route) => false,
    );
  }

  /// Drawer Item Widget
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black45),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            /// Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    icon: Icons.flag,
                    title: "Target & Change Details",
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.targetChangeDetails,
                    ),
                  ),
                  // _drawerItem(
                  //   icon: Icons.image_outlined,
                  //   title: "Body Image Progress",
                  //   onTap: () => Navigator.pushNamed(
                  //     context,
                  //     RouteNames.bodyImageProgress,
                  //   ),
                  // ),
                  _drawerItem(
                    icon: Icons.settings_outlined,
                    title: "Account Setting",
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.accountSettingScreen,
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.logout_outlined,
                    title: "Sign Out",
                    onTap: () => logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
