import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordResponse.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordResponse.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPRequest.dart' show VerifyResetOTPRequest;
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPResponse.dart';

class ForgotPasswordRepository {
  // Send Reset Password OTP
  static Future<ForgotPasswordResponse> sendResetPasswordOTP(ForgotPasswordRequest request) async {
    try {
      final response = await NetworkService.post('/auth/forgot-password', body: request.toJson());

      if (response.success) {
        return ForgotPasswordResponse.fromJson(response.data);
      } else {
        return ForgotPasswordResponse(
          success: false,
          message: response.message ?? 'Failed to send reset password OTP',
        );
      }
    } catch (e) {
      return ForgotPasswordResponse(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Verify Reset Password OTP
  static Future<VerifyResetOTPResponse> verifyResetOTP(VerifyResetOTPRequest request) async {
    try {
      final response = await NetworkService.post('/auth/verify-reset-otp', body: request.toJson());

      if (response.success) {
        return VerifyResetOTPResponse.fromJson(response.data);
      } else {
        return VerifyResetOTPResponse(
          success: false,
          message: response.message ?? 'OTP verification failed',
          isValidOTP: false,
        );
      }
    } catch (e) {
      return VerifyResetOTPResponse(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
        isValidOTP: false,
      );
    }
  }

  // Reset Password
  static Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await NetworkService.post('/auth/reset-password', body: request.toJson());

      if (response.success) {
        return ResetPasswordResponse.fromJson(response.data);
      } else {
        return ResetPasswordResponse(
          success: false,
          message: response.message ?? 'Password reset failed',
        );
      }
    } catch (e) {
      return ResetPasswordResponse(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Resend Reset Password OTP
  static Future<ApiResponse> resendResetOTP(String email) async {
    try {
      return await NetworkService.post('/auth/resend-reset-otp', body: {'email': email});
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }
}
