import 'package:aifitness/models/DietData.dart';

class DietResponse {
  final bool success;
  final String? message;
  final DietData? data;

  DietResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory DietResponse.fromJson(Map<String, dynamic> json) {
    return DietResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? DietData.fromJson(json['data']) : null,
    );
  }
}