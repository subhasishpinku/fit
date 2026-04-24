import 'package:aifitness/utils/app_colors.dart';
import 'package:aifitness/viewModel/contact_us_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  int userId = 0;
  String? deviceId = "";
  String? name = "";
  String? savedEmail = "";
  String? imageFullUrl = "";

  String? selectedPurpose; // ✅ NEW

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  /// Load Shared Preferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt("user_id") ?? 0;
      deviceId = prefs.getString("device_id");
      name = prefs.getString("name");
      savedEmail = prefs.getString("email");
      imageFullUrl = prefs.getString("image_full_url");
    });

    if (savedEmail != null) {
      emailController.text = savedEmail!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactVM = Provider.of<ContactUsViewModel>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset("assets/images/cg55.jpg", fit: BoxFit.cover),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        const Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Email Field
                    TextField(
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.secondaryColor,
                        ),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// PURPOSE LABEL
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Purpose",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// PURPOSE DROPDOWN - FIXED FOR LEFT ALIGNMENT
                    DropdownButtonFormField<String>(
                      value: selectedPurpose,
                      hint: const Text("Select a purpose..."),
                      isExpanded: true, // ✅ Makes dropdown take full width
                      alignment:
                          Alignment.centerLeft, // ✅ Aligns content to left
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.help_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "General Inquiry",
                          child: Text("General Inquiry"),
                        ),
                        DropdownMenuItem(
                          value: "Feedback / Suggestions",
                          child: Text("Feedback / Suggestions"),
                        ),
                        DropdownMenuItem(
                          value: "Workout Plan Query",
                          child: Text("Workout Plan Query"),
                        ),
                        DropdownMenuItem(
                          value: "Meal Plan / Diet Query",
                          child: Text("Meal Plan / Diet Query"),
                        ),
                        DropdownMenuItem(
                          value: "Personal Trainer Inquiry",
                          child: Text("Personal Trainer Inquiry"),
                        ),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() => selectedPurpose = value);
                      },
                      // ✅ Add this to ensure dropdown menu items are left-aligned
                      menuMaxHeight: 300,
                      elevation: 8,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ), // ✅ Custom dropdown icon
                      iconSize: 24,
                      iconEnabledColor: Colors.blue,
                    ),

                    const SizedBox(height: 20),

                    /// MESSAGE LABEL
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Message",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// MESSAGE FIELD
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write your message...",
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        onPressed: () async {
                          /// VALIDATION
                          if (emailController.text.isEmpty) {
                            showSnack(context, "Email is required");
                            return;
                          }

                          if (selectedPurpose == null) {
                            showSnack(context, "Please select a purpose");
                            return;
                          }

                          if (messageController.text.isEmpty) {
                            showSnack(context, "Message is required");
                            return;
                          }

                          /// API CALL
                          final res = await contactVM.sendContactDetails(
                            userId: userId,
                            email: emailController.text.trim(),
                            message: messageController.text.trim(),
                            deviceId: deviceId ?? "",
                            purpose: selectedPurpose ?? "",
                          );

                          if (res["success"] == true) {
                            showSnack(context, res["message"]);
                            messageController.clear();
                            setState(() => selectedPurpose = null);
                          } else {
                            showSnack(context, res["message"]);
                          }
                        },
                        child: contactVM.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "SUBMIT",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
