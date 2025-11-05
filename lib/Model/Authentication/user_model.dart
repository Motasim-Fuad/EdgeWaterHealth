class User {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;
  final String? status;

  User({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'status': status,
    };
  }
}