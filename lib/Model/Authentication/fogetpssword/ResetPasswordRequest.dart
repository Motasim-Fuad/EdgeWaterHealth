class ResetPasswordRequest {
  final String email;
  final String otp;
  final String password;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}