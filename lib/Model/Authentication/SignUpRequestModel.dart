class SignUpRequest {
  final String fullName;
  final String email;
  final String password;

  SignUpRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
    };
  }
}
