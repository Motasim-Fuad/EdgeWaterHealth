import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubmissionDay {
  final DateTime date;
  final int count;
  SubmissionDay(this.date, this.count);
}

class DashboardViewModel extends GetxController {
  final name = "Benjamin".obs;
  final profileImage =
      "https://cdn-icons-png.flaticon.com/512/147/147144.png".obs;

  final topSvgUrl = "${AppImages.dashboard1}".obs;
  final card1SvgUrl = "${AppImages.dashboard2}".obs;
  final card2SvgUrl = "${AppImages.dashboard2}".obs;

  final card1Count = 32.obs;
  final card1Subtitle = "Form submitted".obs;
  final card2Subtitle = "Last submitted".obs;
  final card2TimeAgo = "2 hours ago".obs;

  final submissions = <SubmissionDay>[].obs;
  final selectedIndex = (-1).obs; // 🟢 newly added

  final todayDate = DateFormat("dd MMM yyyy").format(DateTime.now()).obs;


  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    final today = DateTime.now();
    final rnd = [12, 5, 18, 8, 30, 3, 25]; // test values
    submissions.clear();
    for (int i = 6; i >= 0; i--) {
      final d = today.subtract(Duration(days: i));
      submissions.add(SubmissionDay(d, rnd[6 - i]));
    }
  }

  double get chartMaxY {
    final maxCount =
    submissions.fold<int>(0, (p, e) => p > e.count ? p : e.count);
    return (maxCount < 30) ? 30.0 : maxCount.toDouble();
  }
}

