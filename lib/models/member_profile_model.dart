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
      machineProfileActive: json["machine_profile_active"]?.toString() ?? "0",
      imageFullUrl: json["image_full_url"] ?? "",
    );
  }

  // Add copyWith method to create a new instance with updated values
  MemberProfileModel copyWith({
    int? id,
    String? name,
    String? gender,
    String? age,
    String? height,
    String? heightUnit,
    String? image,
    String? profilePic,
    String? machineProfileActive,
    String? imageFullUrl,
  }) {
    return MemberProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      image: image ?? this.image,
      profilePic: profilePic ?? this.profilePic,
      machineProfileActive: machineProfileActive ?? this.machineProfileActive,
      imageFullUrl: imageFullUrl ?? this.imageFullUrl,
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