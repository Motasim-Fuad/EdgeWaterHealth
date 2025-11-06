class CrisisStabilizationModel {
  final String? userId;
  final String referralsToCrisisStabilization;
  final int numberOfVisits;
  final String crisisTypes;
  final String outcome;
  final int totalStabilizationTime;
  final int meanStabilizationTime;
  final int referralsGiven;
  final String referralsByType;
  final int naloxoneDispensations;
  final int followUpContacts;
  final int individualsServed;
  final String clientCountyOfResidence;
  final String clientPrimaryInsurance;
  final String clientAgeGroups;
  final String clientVeteranStatus;
  final String clientServingInMilitary;

  CrisisStabilizationModel({
    this.userId,
    required this.referralsToCrisisStabilization,
    required this.numberOfVisits,
    required this.crisisTypes,
    required this.outcome,
    required this.totalStabilizationTime,
    required this.meanStabilizationTime,
    required this.referralsGiven,
    required this.referralsByType,
    required this.naloxoneDispensations,
    required this.followUpContacts,
    required this.individualsServed,
    required this.clientCountyOfResidence,
    required this.clientPrimaryInsurance,
    required this.clientAgeGroups,
    required this.clientVeteranStatus,
    required this.clientServingInMilitary,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId,
      'referralsToCrisisStabilization': referralsToCrisisStabilization,
      'numberOfVisits': numberOfVisits,
      'crisisTypes': crisisTypes,
      'outcome': outcome,
      'totalStabilizationTime': totalStabilizationTime,
      'meanStabilizationTime': meanStabilizationTime,
      'referralsGiven': referralsGiven,
      'referralsByType': referralsByType,
      'naloxoneDispensations': naloxoneDispensations,
      'followUpContacts': followUpContacts,
      'individualsServed': individualsServed,
      'clientCountyOfResidence': clientCountyOfResidence,
      'clientPrimaryInsurance': clientPrimaryInsurance,
      'clientAgeGroups': clientAgeGroups,
      'clientVeteranStatus': clientVeteranStatus,
      'clientServingInMilitary': clientServingInMilitary,
    };
  }
}