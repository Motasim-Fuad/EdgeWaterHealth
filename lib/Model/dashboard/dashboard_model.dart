class SubmissionDay {
  final DateTime date;
  final int count;

  SubmissionDay(this.date, this.count);
}

class DashboardData {
  final String userId;
  final int totalFormsSubmitted;
  final String? lastSubmittedAt;
  final FormBreakdown formBreakdown;
  final List<WeeklyInsight> weeklyInsights;

  DashboardData({
    required this.userId,
    required this.totalFormsSubmitted,
    this.lastSubmittedAt,
    required this.formBreakdown,
    required this.weeklyInsights,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      userId: json['userId'],
      totalFormsSubmitted: json['totalFormsSubmitted'] ?? 0,
      lastSubmittedAt: json['lastSubmittedAt'],
      formBreakdown: FormBreakdown.fromJson(json['formBreakdown'] ?? {}),
      weeklyInsights: (json['weeklyInsights'] as List?)
          ?.map((e) => WeeklyInsight.fromJson(e))
          .toList() ?? [],
    );
  }
}

class FormBreakdown {
  final int crisisCalls;
  final int mobileCrisis;
  final int crisisStabilization;

  FormBreakdown({
    required this.crisisCalls,
    required this.mobileCrisis,
    required this.crisisStabilization,
  });

  factory FormBreakdown.fromJson(Map<String, dynamic> json) {
    return FormBreakdown(
      crisisCalls: json['crisisCalls'] ?? 0,
      mobileCrisis: json['mobileCrisis'] ?? 0,
      crisisStabilization: json['crisisStabilization'] ?? 0,
    );
  }
}

class WeeklyInsight {
  final String day;
  final String date;
  final int total;

  WeeklyInsight({
    required this.day,
    required this.date,
    required this.total,
  });

  factory WeeklyInsight.fromJson(Map<String, dynamic> json) {
    return WeeklyInsight(
      day: json['day'],
      date: json['date'],
      total: json['total'] ?? 0,
    );
  }
}