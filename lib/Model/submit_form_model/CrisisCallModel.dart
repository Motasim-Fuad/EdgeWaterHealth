class CrisisCallModel {
  final String? userId;
  final String callByCountry;
  final String crisisType;
  final String? description;

  CrisisCallModel({
    this.userId,
    required this.callByCountry,
    required this.crisisType,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId,
      'callByCountry': callByCountry,
      'crisisType': crisisType,
      if (description != null && description!.isNotEmpty) 'description': description,
    };
  }
}