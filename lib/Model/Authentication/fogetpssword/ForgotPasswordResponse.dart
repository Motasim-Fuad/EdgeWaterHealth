import 'package:edgewaterhealth/Data/nework_services.dart';

class ForgotPasswordResponse {
  final bool success;
  final String message;
  final String? resetToken;
  final int? statusCode;

  ForgotPasswordResponse({
    required this.success,
    required this.message,
    this.resetToken,
    this.statusCode,
  });

  factory ForgotPasswordResponse.fromApiResponse(ApiResponse apiResponse) {
    return ForgotPasswordResponse(
      success: apiResponse.success,
      message: apiResponse.data?['message'] ?? 'Operation completed',
      resetToken: apiResponse.data?['reset_token'] ?? apiResponse.data?['resetToken'],
      statusCode: apiResponse.statusCode,
    );
  }

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      resetToken: json['reset_token'] ?? json['resetToken'],
    );
  }
}