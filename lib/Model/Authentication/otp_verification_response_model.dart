import 'package:edgewaterhealth/Model/Authentication/user_model.dart';

class OTPVerificationResponse {
  final bool success;
  final String message;
  final User? user;
  final String? token;

  OTPVerificationResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory OTPVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OTPVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}
