import 'package:edgewaterhealth/Model/Authentication/user_model.dart';

class SignUpResponse {
  final bool success;
  final String message;
  final User? user;
  final String? token;

  SignUpResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}