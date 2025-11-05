// lib/Repository/Authentication/Authentication_repository.dart
import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Authentication/SignUpRequestModel.dart';
import 'package:edgewaterhealth/Model/Authentication/otp_verification_response_model.dart';
import 'package:edgewaterhealth/Model/Authentication/sing_up_otp_model.dart';
import 'package:edgewaterhealth/Model/Authentication/sinup_response_model.dart';
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';
import 'package:edgewaterhealth/Services/StorageServices.dart';

class AuthRepository {
  // Sign Up - Request OTP
  static Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/signup/request-otp',
        body: request.toJson(),
      );

      print('SignUp API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return SignUpResponse.fromApiResponse(response);
    } catch (e) {
      print('SignUp Error: $e');
      return SignUpResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Verify OTP
  static Future<OTPVerificationResponse> verifyOTP(OTPVerificationRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/verify-otp',
        body: request.toJson(),
      );

      print('Verify OTP API - StatusCode: ${response.statusCode}, Success: ${response.success}');

      final otpResponse = OTPVerificationResponse.fromApiResponse(response);

      // Save user data if verification successful
      if (otpResponse.success && otpResponse.user != null) {
        await StorageService.saveUser(otpResponse.user!);
      }

      return otpResponse;
    } catch (e) {
      print('Verify OTP Error: $e');
      return OTPVerificationResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Resend OTP
  static Future<SignUpResponse> resendOTP(String email) async {
    try {
      final response = await NetworkService.post(
        '/api/users/signup/request-otp',
        body: {'email': email},
      );

      print('Resend OTP API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return SignUpResponse.fromApiResponse(response);
    } catch (e) {
      print('Resend OTP Error: $e');
      return SignUpResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Complete Signup
  static Future<SignUpResponse> completeSignup(SignUpRequest request) async {
    try {
      final response = await NetworkService.post(
        '/api/users/signup',
        body: request.toJson(),
      );

      print('Complete Signup API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return SignUpResponse.fromApiResponse(response);
    } catch (e) {
      print('Complete Signup Error: $e');
      return SignUpResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Login
  static Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await NetworkService.post(
        '/api/users/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Login API - StatusCode: ${response.statusCode}, Success: ${response.success}');

      final loginResponse = LoginResponse.fromApiResponse(response);

      // Save token and user if login successful
      if (loginResponse.success) {
        if (loginResponse.token != null) {
          await StorageService.saveToken(loginResponse.token!);
        }
        if (loginResponse.user != null) {
          await StorageService.saveUser(loginResponse.user!);
        }
      }

      return loginResponse;
    } catch (e) {
      print('Login Error: $e');
      return LoginResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Forgot Password
  static Future<SignUpResponse> forgotPassword(String email) async {
    try {
      final response = await NetworkService.post(
        '/api/admin/forgot-password/sent-otp',
        body: {'email': email},
      );

      print('Forgot Password API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return SignUpResponse.fromApiResponse(response);
    } catch (e) {
      print('Forgot Password Error: $e');
      return SignUpResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Reset Password
  static Future<SignUpResponse> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await NetworkService.post(
        '/api/admin/reset-password',
        body: {
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        },
      );

      print('Reset Password API - StatusCode: ${response.statusCode}, Success: ${response.success}');
      return SignUpResponse.fromApiResponse(response);
    } catch (e) {
      print('Reset Password Error: $e');
      return SignUpResponse(
        success: false,
        statusCode: 0,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Logout
  static Future<void> logout() async {
    await StorageService.clearAll();
  }
}

// Login Response Model
class LoginResponse {
  final bool success;
  final int statusCode;
  final String? message;
  final String? token;
  final User? user;

  LoginResponse({
    required this.success,
    required this.statusCode,
    this.message,
    this.token,
    this.user,
  });

  factory LoginResponse.fromApiResponse(ApiResponse apiResponse) {
    return LoginResponse(
      success: apiResponse.success,
      statusCode: apiResponse.statusCode ?? 0,
      message: apiResponse.data?['message'] as String?,
      token: apiResponse.data?['token'] as String?,
      user: apiResponse.data?['user'] != null
          ? User.fromJson(apiResponse.data['user'])
          : null,
    );
  }
}