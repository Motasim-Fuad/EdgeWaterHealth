import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordResponse.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordResponse.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPResponse.dart';

class ForgotPasswordRepository {
  // Send Reset Password OTP
  static Future<ForgotPasswordResponse> sendResetPasswordOTP(ForgotPasswordRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/send-forget-pass-otp',
        body: request.toJson(),
      );

      print('Send Reset OTP API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return ForgotPasswordResponse.fromApiResponse(response);
    } catch (e) {
      print('Send Reset OTP Error: $e');
      return ForgotPasswordResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Verify Reset Password OTP
  static Future<VerifyResetOTPResponse> verifyResetOTP(VerifyResetOTPRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/verify-forget-pass-otp',
        body: request.toJson(),
      );

      print('Verify Reset OTP API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return VerifyResetOTPResponse.fromApiResponse(response);
    } catch (e) {
      print('Verify Reset OTP Error: $e');
      return VerifyResetOTPResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
        isValidOTP: false,
      );
    }
  }

  // Reset Password
  static Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/reset-password',
        body: request.toJson(),
      );

      print('Reset Password API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return ResetPasswordResponse.fromApiResponse(response);
    } catch (e) {
      print('Reset Password Error: $e');
      return ResetPasswordResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Resend Reset Password OTP
  static Future<ForgotPasswordResponse> resendResetOTP(String email) async {
    try {
      final request = ForgotPasswordRequest(email: email);
      return await sendResetPasswordOTP(request);
    } catch (e) {
      print('Resend Reset OTP Error: $e');
      return ForgotPasswordResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }
}