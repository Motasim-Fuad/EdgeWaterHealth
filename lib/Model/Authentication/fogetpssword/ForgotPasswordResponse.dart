class ForgotPasswordResponse {
  final bool success;
  final String message;
  final String? resetToken;

  ForgotPasswordResponse({
    required this.success,
    required this.message,
    this.resetToken,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      resetToken: json['reset_token'],
    );
  }
}