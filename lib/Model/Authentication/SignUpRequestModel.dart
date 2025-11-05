// lib/Model/Authentication/SignUpRequestModel.dart
class SignUpRequest {
  final String email;
  final String? name;
  final String? password;
  final String? confirmPassword;

  SignUpRequest({
    required this.email,
    this.name,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
    };

    if (name != null) data['name'] = name;
    if (password != null) data['password'] = password;
    if (confirmPassword != null) data['confirmPassword'] = confirmPassword;

    return data;
  }
}