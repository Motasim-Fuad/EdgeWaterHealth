import 'package:edgewaterhealth/Data/nework_services.dart';

class VerifyResetOTPResponse {
  final bool success;
  final String message;
  final bool isValidOTP;
  final int? statusCode;

  VerifyResetOTPResponse({
    required this.success,
    required this.message,
    required this.isValidOTP,
    this.statusCode,
  });

  factory VerifyResetOTPResponse.fromApiResponse(ApiResponse apiResponse) {
    return VerifyResetOTPResponse(
      success: apiResponse.success,
      message: apiResponse.data?['message'] ?? 'OTP verification completed',
      isValidOTP: apiResponse.data?['is_valid_otp'] ??
          apiResponse.data?['isValidOTP'] ??
          apiResponse.success,
      statusCode: apiResponse.statusCode,
    );
  }

  factory VerifyResetOTPResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResetOTPResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      isValidOTP: json['is_valid_otp'] ?? json['isValidOTP'] ?? false,
    );
  }
}