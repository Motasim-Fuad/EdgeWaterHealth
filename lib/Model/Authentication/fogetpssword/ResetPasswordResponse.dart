import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';

class ResetPasswordResponse {
  final bool success;
  final String message;
  final User? user;
  final int? statusCode;

  ResetPasswordResponse({
    required this.success,
    required this.message,
    this.user,
    this.statusCode,
  });

  factory ResetPasswordResponse.fromApiResponse(ApiResponse apiResponse) {
    return ResetPasswordResponse(
      success: apiResponse.success,
      message: apiResponse.data?['message'] ?? 'Password reset completed',
      user: apiResponse.data?['user'] != null
          ? User.fromJson(apiResponse.data['user'])
          : null,
      statusCode: apiResponse.statusCode,
    );
  }

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}