
import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Dashboard/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardData?> fetchUserSummary() async {
    try {
      final response = await NetworkService.get("/api/user/summary");

      if (response.success && response.data != null) {
        final data = response.data;

        // Check if response has nested 'data' field
        if (data is Map && data['success'] == true && data['data'] != null) {
          return DashboardData.fromJson(data['data']);
        }

        return DashboardData.fromJson(data);
      }

      return null;
    } catch (e) {
      print("Error fetching user summary: $e");
      return null;
    }
  }
}