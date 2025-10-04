class ProfileModel {
  final String userId;
  final String fullName;
  final String email;
  final String? profileImage; // image URL from API

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'].toString(),
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'],
    );
  }
}
