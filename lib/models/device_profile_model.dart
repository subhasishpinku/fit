import 'dart:convert';

class DeviceProfileModel {
  final int id;
  final String name;
  final String? profilePic;
  final int noOfDaysRegistered;
  final dynamic currentDashboardData;

  final String? createdAt;
  final String? updatedAt;

  DeviceProfileModel({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.noOfDaysRegistered,
    required this.currentDashboardData,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DeviceProfileModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      profilePic: json["profile_pic"],
      noOfDaysRegistered:
          json["no_of_days_registered"] ?? 0,
      currentDashboardData:
          json["current_dashboard_data"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> get dashboardJson {
    if (currentDashboardData == null) {
      return {};
    }

    if (currentDashboardData is String) {
      return jsonDecode(
        currentDashboardData,
      );
    }

    return currentDashboardData;
  }
}