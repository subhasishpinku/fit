class AddMemberRequestModel {
  final String name;
  final String gender;
  final String birthYear;
  final String heightValue;
  final String heightUnit;
  final String profilePic;
  final String deviceId;

  AddMemberRequestModel({
    required this.name,
    required this.gender,
    required this.birthYear,
    required this.heightValue,
    required this.heightUnit,
    required this.profilePic,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "height_unit": heightUnit,
      "name": name,
      "profile_pic": profilePic,
      "gender": gender,
      "height_value": heightValue,
      "birth_year": birthYear,
      "device_id": deviceId,
    };
  }
}