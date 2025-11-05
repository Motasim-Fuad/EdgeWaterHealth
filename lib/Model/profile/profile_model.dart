class ProfileModel {
  final String userId;
  final String fullName;
  final String email;
  final String? profileImage;
  final String? status;

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profileImage,
    this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['_id'] ?? json['userId'] ?? '',
      fullName: json['name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': fullName,
      'email': email,
      'profileImage': profileImage,
      'status': status,
    };
  }
}