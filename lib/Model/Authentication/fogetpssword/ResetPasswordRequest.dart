// Reset Password Request Model
class ResetPasswordRequest {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}