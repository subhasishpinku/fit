class MemberProfileModel {
  final int id;
  final String name;
  final String gender;
  final String age;
  final String? height;
  final String? heightUnit;
  final String? image;
  final String? profilePic;
  final String machineProfileActive;
  final String imageFullUrl;

  MemberProfileModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.machineProfileActive,
    required this.imageFullUrl,
    this.height,
    this.heightUnit,
    this.image,
    this.profilePic,
  });

  factory MemberProfileModel.fromJson(Map<String, dynamic> json) {
    return MemberProfileModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      gender: json["gender"] ?? "",
      age: json["age"]?.toString() ?? "",
      height: json["height_value"]?.toString(),
      heightUnit: json["height_unit"]?.toString(),
      image: json["image"]?.toString(),
      profilePic: json["profile_pic"]?.toString(),
      machineProfileActive:
          json["machine_profile_active"]?.toString() ?? "0",
      imageFullUrl: json["image_full_url"] ?? "",
    );
  }

  String get profileImage {
    if (image != null && image!.isNotEmpty) {
      return imageFullUrl + image!;
    }

    return "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
  }

  String get genderText {
    return gender == "M" ? "Male" : "Female";
  }
}