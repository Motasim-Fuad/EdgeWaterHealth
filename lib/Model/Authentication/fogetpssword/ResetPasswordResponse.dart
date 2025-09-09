import 'package:edgewaterhealth/Model/Authentication/user_model.dart';

class ResetPasswordResponse {
  final bool success;
  final String message;
  final User? user;

  ResetPasswordResponse({
    required this.success,
    required this.message,
    this.user,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
