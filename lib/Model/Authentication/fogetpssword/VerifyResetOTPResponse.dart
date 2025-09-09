class VerifyResetOTPResponse {
  final bool success;
  final String message;
  final bool isValidOTP;

  VerifyResetOTPResponse({
    required this.success,
    required this.message,
    required this.isValidOTP,
  });

  factory VerifyResetOTPResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResetOTPResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      isValidOTP: json['is_valid_otp'] ?? false,
    );
  }
}
