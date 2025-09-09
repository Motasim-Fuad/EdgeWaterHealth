class VerifyResetOTPRequest {
  final String email;
  final String otp;

  VerifyResetOTPRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}