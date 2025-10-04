class CrisisFormModel {
  String? county;
  String? address;
  String? mainCo;
  String? crisisType;
  String? other;
  String? crisisDetails;

  CrisisFormModel({
    this.county,
    this.address,
    this.mainCo,
    this.crisisType,
    this.other,
    this.crisisDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'county': county,
      'address': address,
      'mainCo': mainCo,
      'crisisType': crisisType,
      'other': other,
      'crisisDetails': crisisDetails,
    };
  }

  factory CrisisFormModel.fromJson(Map<String, dynamic> json) {
    return CrisisFormModel(
      county: json['county'],
      address: json['address'],
      mainCo: json['mainCo'],
      crisisType: json['crisisType'],
      other: json['other'],
      crisisDetails: json['crisisDetails'],
    );
  }
}