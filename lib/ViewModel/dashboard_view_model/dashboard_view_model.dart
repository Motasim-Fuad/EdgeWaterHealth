
import 'package:edgewaterhealth/Repository/Dashbord_Repository/dashboard_repository.dart';
import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Model/Dashboard/dashboard_model.dart';
import 'package:edgewaterhealth/Services/StorageServices.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardViewModel extends GetxController {
  final DashboardRepository _repo = DashboardRepository();

  // User info from storage
  final name = "".obs;
  final profileImage = "https://cdn-icons-png.flaticon.com/512/147/147144.png".obs;

  // UI elements
  final topSvgUrl = AppImages.dashboard1.obs;
  final card1SvgUrl = AppImages.dashboard2.obs;
  final card2SvgUrl = AppImages.dashboard2.obs;

  // Dashboard data from API
  final card1Count = 0.obs;
  final card1Subtitle = "Form submitted".obs;
  final card2Subtitle = "Last submitted".obs;
  final card2TimeAgo = "N/A".obs;

  final submissions = <SubmissionDay>[].obs;
  final selectedIndex = (-1).obs;
  final isLoading = false.obs;

  final todayDate = DateFormat("dd MMM yyyy").format(DateTime.now()).obs;
  final greeting = "Good morning".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
    _updateGreeting();
    fetchDashboardData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserFromStorage() async {
    final user = await StorageService.getUser();
    if (user != null) {
      name.value = user.name ?? "User";
      if (user.profileImage != null && user.profileImage!.isNotEmpty) {
        profileImage.value = user.profileImage!;
      }
    }
  }

  // Update greeting based on local time
  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = "Good morning";
    } else if (hour < 17) {
      greeting.value = "Good afternoon";
    } else {
      greeting.value = "Good evening";
    }
  }

  // Fetch dashboard data from API
  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final data = await _repo.fetchUserSummary();

      if (data != null) {
        // Update form count
        card1Count.value = data.totalFormsSubmitted;

        // Update last submitted time
        if (data.lastSubmittedAt != null) {
          card2TimeAgo.value = _formatTimeAgo(DateTime.parse(data.lastSubmittedAt!));
        }

        // Update weekly insights chart
        submissions.clear();
        for (var insight in data.weeklyInsights) {
          final date = DateTime.parse(insight.date);
          submissions.add(SubmissionDay(date, insight.total));
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load dashboard data",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh data (pull to refresh)
  Future<void> refreshData() async {
    await Future.wait([
      _loadUserFromStorage(),
      fetchDashboardData(),
    ]);
  }

  // Format time ago (e.g., "2 hours ago")
  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return DateFormat('MMM dd').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  double get chartMaxY {
    final maxCount = submissions.fold<int>(0, (p, e) => p > e.count ? p : e.count);
    return (maxCount < 10) ? 10.0 : (maxCount + 5).toDouble();
  }
}