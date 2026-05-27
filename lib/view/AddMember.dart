import 'package:aifitness/viewModel/addMember_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  String selectedAvatar = "male_avtar1";

  List<String> maleAvatars = [
    "assets/images/avtarMale/male_avtar1.jpg",
    "assets/images/avtarMale/male_avtar2.jpg",
    "assets/images/avtarMale/male_avtar3.jpg",
    "assets/images/avtarMale/male_avtar4.jpg",
    "assets/images/avtarMale/male_avtar5.jpg",
    "assets/images/avtarMale/male_avtar6.jpg",
    "assets/images/avtarMale/male_avtar7.jpg",
    "assets/images/avtarMale/male_avtar9.jpg",
    "assets/images/avtarMale/male_avtar10.png",
  ];

  List<String> femaleAvatars = [
    "assets/images/avtarFemale/female_avtar1.jpg",
    "assets/images/avtarFemale/female_avtar2.jpg",
    "assets/images/avtarFemale/female_avtar3.png",
    "assets/images/avtarFemale/female_avtar4.jpg",
    "assets/images/avtarFemale/female_avtar5.jpg",
    "assets/images/avtarFemale/female_avtar6.jpg",
    "assets/images/avtarFemale/female_avtar7.jpg",
    "assets/images/avtarFemale/female_avtar8.jpg",
    "assets/images/avtarFemale/female_avtar9.jpg",
    "assets/images/avtarFemale/female_avtar10.jpg",
  ];
  String selectedGender = "Male";

  String _deviceId = 'Unknown';

  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();

  ///  Birth Year 1950 -> Current Year
  final List<String> years = List.generate(
    DateTime.now().year - 1950 + 1,
    (index) => (1950 + index).toString(),
  );

  ///Height 140 -> 240 with 1 cm gap
  final List<String> heights = List.generate(
    101,
    (index) => "${140 + index} cm",
  );

  /// Default Selected
  String selectedYear = "1950";

  String selectedHeight = "140 cm";

  final TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceId;

    try {
      deviceId = await _mobileDeviceIdentifierPlugin.getDeviceId() ?? 'Unknown';
    } on PlatformException {
      deviceId = 'Failed to get device ID.';
    }

    setState(() {
      _deviceId = deviceId;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("device_id", _deviceId);

    print("DEVICE ID => $_deviceId");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddmemberViewmodel(),

      child: Consumer<AddmemberViewmodel>(
        builder: (context, vm, child) {
          return Directionality(
            textDirection: TextDirection.ltr,

            child: Scaffold(
              resizeToAvoidBottomInset: true,

              backgroundColor: const Color(0xffF5F5F5),

              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
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
                              "Add Profile",

                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },

                              child: const Icon(Icons.close, size: 34),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// PROFILE IMAGE
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: showAvatarPicker,

                                child: Stack(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),

                                        image: DecorationImage(
                                          image: AssetImage(
                                            selectedGender == "Male"
                                                ? "assets/images/avtarMale/$selectedAvatar.jpg"
                                                : "assets/images/avtarFemale/$selectedAvatar.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                        ),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.3),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 0,
                                      right: 0,

                                      child: Container(
                                        padding: const EdgeInsets.all(4),

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),

                                        child: const Icon(Icons.edit, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Tap to add profile photo",

                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// NICKNAME
                        buildTitle(icon: Icons.person, title: "NICKNAME"),

                        const SizedBox(height: 8),

                        buildTextField(),

                        const SizedBox(height: 18),

                        /// GENDER
                        buildTitle(icon: Icons.wc, title: "GENDER"),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            genderBox(emoji: "🧑", text: "Male"),

                            const SizedBox(width: 14),

                            genderBox(emoji: "👩", text: "Female"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// BIRTH YEAR
                        buildTitle(icon: Icons.cake, title: "BIRTH YEAR"),

                        const SizedBox(height: 8),

                        buildDropdown(
                          value: selectedYear,
                          items: years,

                          onChanged: (v) {
                            setState(() {
                              selectedYear = v!;
                            });
                          },
                        ),

                        const SizedBox(height: 18),

                        /// HEIGHT
                        buildTitle(icon: Icons.straighten, title: "HEIGHT"),

                        const SizedBox(height: 8),

                        buildDropdown(
                          value: selectedHeight,
                          items: heights,

                          onChanged: (v) {
                            setState(() {
                              selectedHeight = v!;
                            });
                          },
                        ),

                        const SizedBox(height: 40),

                        /// CREATE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 56,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0F7AE5),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            onPressed: vm.isLoading
                                ? null
                                : () async {
                                    if (nicknameController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please enter nickname",
                                          ),
                                        ),
                                      );

                                      return;
                                    }

                                    print("DEVICE ID => $_deviceId");

                                    await vm.createProfile(
                                      name: nicknameController.text.trim(),

                                      gender: selectedGender == "Male"
                                          ? "M"
                                          : "F",

                                      birthYear: selectedYear,

                                      height: selectedHeight,

                                      deviceId: _deviceId,
                                    );

                                    if (vm.errorMessage.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Profile Created Successfully",
                                          ),
                                        ),
                                      );

                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(vm.errorMessage),
                                        ),
                                      );
                                    }
                                  },

                            child: vm.isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,

                                    child: CircularProgressIndicator(
                                      color: Colors.white,

                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Create Profile",

                                    style: TextStyle(
                                      fontSize: 20,

                                      fontWeight: FontWeight.w700,

                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showAvatarPicker() {
    final avatars = selectedGender == "Male" ? maleAvatars : femaleAvatars;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final image = avatars[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = image.split("/").last.split(".").first;
                  });

                  Navigator.pop(context);
                },

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),

        const SizedBox(width: 6),

        Text(
          title,

          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget buildTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.08), blurRadius: 8),
        ],
      ),

      child: TextField(
        controller: nicknameController,

        decoration: InputDecoration(
          hintText: "Enter your nickname",

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

            borderSide: const BorderSide(color: Color(0xffD9D9FF)),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

            borderSide: const BorderSide(color: Color(0xffD9D9FF)),
          ),
        ),
      ),
    );
  }

  Widget genderBox({required String emoji, required String text}) {
    final bool isSelected = selectedGender == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = text;
        });
      },

      child: Container(
        width: 74,

        padding: const EdgeInsets.symmetric(vertical: 12),

        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.shade100,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,

            width: 1.5,
          ),

          boxShadow: [
            BoxShadow(color: Colors.blue.withOpacity(0.08), blurRadius: 8),
          ],
        ),

        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),

            const SizedBox(height: 4),

            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.08), blurRadius: 8),
        ],
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,

          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),

          items: items.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
