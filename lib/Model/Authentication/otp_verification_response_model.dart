// lib/Model/Authentication/otp_verification_response_model.dart
import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';

class OTPVerificationResponse {
  final bool success;
  final int statusCode;
  final String message;
  final User? user;
  final String? token;

  OTPVerificationResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.user,
    this.token,
  });

  factory OTPVerificationResponse.fromApiResponse(ApiResponse apiResponse) {
    return OTPVerificationResponse(
      success: apiResponse.success,
      statusCode: apiResponse.statusCode ?? 0,
      message: apiResponse.data?['message'] ?? '',
      user: apiResponse.data?['user'] != null
          ? User.fromJson(apiResponse.data['user'])
          : null,
      token: apiResponse.data?['token'],
    );
  }
}