import 'package:edgewaterhealth/Data/nework_services.dart' show NetworkService, ApiResponse;
import 'package:edgewaterhealth/Model/Authentication/SignUpRequestModel.dart';
import 'package:edgewaterhealth/Model/Authentication/otp_verification_response_model.dart';
import 'package:edgewaterhealth/Model/Authentication/sing_up_otp_model.dart' show OTPVerificationRequest;
import 'package:edgewaterhealth/Model/Authentication/sinup_response_model.dart';
import 'package:get/get.dart';

class AuthRepository {
  // Sign Up
  static Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await NetworkService.post('/auth/signup', body: request.toJson());

      if (response.success) {
        return SignUpResponse.fromJson(response.data);
      } else {
        return SignUpResponse(
          success: false,
          message: response.message ?? 'Sign up failed',
        );
      }
    } catch (e) {
      return SignUpResponse(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Verify OTP
  static Future<OTPVerificationResponse> verifyOTP(OTPVerificationRequest request) async {
    try {
      final response = await NetworkService.post('/auth/verify-otp', body: request.toJson());

      if (response.success) {
        return OTPVerificationResponse.fromJson(response.data);
      } else {
        return OTPVerificationResponse(
          success: false,
          message: response.message ?? 'OTP verification failed',
        );
      }
    } catch (e) {
      return OTPVerificationResponse(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Resend OTP
  static Future<ApiResponse> resendOTP(String email) async {
    try {
      return await NetworkService.post('/auth/resend-otp', body: {'email': email});
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: ${e.toString()}');
    }
  }
}