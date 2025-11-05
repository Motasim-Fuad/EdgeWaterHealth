// lib/Model/Authentication/sinup_response_model.dart
import 'package:edgewaterhealth/Data/nework_services.dart';

class SignUpResponse {
  final bool success;
  final int statusCode;
  final String? message;
  final String? email;

  SignUpResponse({
    required this.success,
    required this.statusCode,
    this.message,
    this.email,
  });

  factory SignUpResponse.fromApiResponse(ApiResponse apiResponse) {
    return SignUpResponse(
      success: apiResponse.success,
      statusCode: apiResponse.statusCode ?? 0,
      message: apiResponse.data?['message'] as String?,
      email: apiResponse.data?['email'] as String?,
    );
  }
}