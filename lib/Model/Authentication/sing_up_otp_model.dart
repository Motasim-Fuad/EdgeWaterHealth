class OTPVerificationRequest {
  final String email;
  final String otp;

  OTPVerificationRequest({
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
