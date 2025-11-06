class MobileCrisisModel {
  final String? userId;
  final String referralSource;
  final int totalDispatches;
  final String dispatchCounty;
  final String crisisType;
  final String outcome;
  final int totalResponseTime;
  final int meanResponseTime;
  final int totalOnSceneTime;
  final int meanOnSceneTime;
  final int referralsGiven;
  final String referralType;
  final int naloxoneDispensations;
  final int followUpContacts;
  final int individualsServed;
  final String primaryInsurance;
  final String ageGroup;
  final String veteranStatus;
  final String servingInMilitary;

  MobileCrisisModel({
    this.userId,
    required this.referralSource,
    required this.totalDispatches,
    required this.dispatchCounty,
    required this.crisisType,
    required this.outcome,
    required this.totalResponseTime,
    required this.meanResponseTime,
    required this.totalOnSceneTime,
    required this.meanOnSceneTime,
    required this.referralsGiven,
    required this.referralType,
    required this.naloxoneDispensations,
    required this.followUpContacts,
    required this.individualsServed,
    required this.primaryInsurance,
    required this.ageGroup,
    required this.veteranStatus,
    required this.servingInMilitary,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId,
      'referralSource': referralSource,
      'totalDispatches': totalDispatches,
      'dispatchCounty': dispatchCounty,
      'crisisType': crisisType,
      'outcome': outcome,
      'totalResponseTime': totalResponseTime,
      'meanResponseTime': meanResponseTime,
      'totalOnSceneTime': totalOnSceneTime,
      'meanOnSceneTime': meanOnSceneTime,
      'referralsGiven': referralsGiven,
      'referralType': referralType,
      'naloxoneDispensations': naloxoneDispensations,
      'followUpContacts': followUpContacts,
      'individualsServed': individualsServed,
      'primaryInsurance': primaryInsurance,
      'ageGroup': ageGroup,
      'veteranStatus': veteranStatus,
      'servingInMilitary': servingInMilitary,
    };
  }
}