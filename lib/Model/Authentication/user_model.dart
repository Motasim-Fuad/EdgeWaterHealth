class User {
  final String id;
  final String fullName;
  final String email;
  final bool isEmailVerified;
  final String? profileImage;
  final DateTime createdAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isEmailVerified,
    this.profileImage,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? false,
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'is_email_verified': isEmailVerified,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
