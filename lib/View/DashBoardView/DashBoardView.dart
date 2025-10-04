import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:edgewaterhealth/ViewModel/dashboard_view_model/dashboard_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewModel vm = Get.put(DashboardViewModel());

  DashboardView({Key? key}) : super(key: key);

  Widget _topCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 150,
      child: Stack(
        children: [
          // SVG background from URL
          Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SvgPicture.asset(
              vm.topSvgUrl.value,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholderBuilder: (ctx) => Container(
                color: Colors.blueGrey.shade100,
              ),
            ),
          )),
          // overlay content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // profile picture
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(vm.profileImage.value),
                  ),
                  const SizedBox(width: 12),
                  // greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Good morning,",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(vm.name.value + "!",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            const SizedBox(width: 8),
                            const Text("👋"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Every form you submit brings hope. Ready to begin?",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoCard({
    required String svgUrl,
    required Widget topIcon,
    required String mainText,
    required String subText,
  }) {
    return Expanded(
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            // background svg
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SvgPicture.asset(
                svgUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholderBuilder: (_) => Container(
                  color: Colors.green.shade50,
                ),
              ),
            ),
            // content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.topLeft, child: topIcon),
                  const Spacer(),
                  Text(mainText,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(subText, style:  TextStyle(fontSize: 12,color:Color(0xffe0eef1))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Submission Insights",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text("Last 7 days",
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: Obx(() {
                final data = vm.submissions;
                final maxY = vm.chartMaxY;

                return GestureDetector(
                  onTap: () {
                    // clicking outside removes selection + hides tooltip
                    vm.selectedIndex.value = -1;
                  },
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final day = data[groupIndex];
                            final dateStr =
                            DateFormat("dd MMM yyyy").format(day.date);
                            return BarTooltipItem(
                              "${day.count}\n$dateStr",
                              const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        touchCallback: (event, response) {
                          if (event.isInterestedForInteractions &&
                              response?.spot != null) {
                            final index =
                                response!.spot!.touchedBarGroupIndex;
                            vm.selectedIndex.value = index;
                          }
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: (maxY / 4).ceilToDouble(),
                            getTitlesWidget: (value, _) => Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 10),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= data.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  DateFormat("E").format(data[idx].date),
                                  style: TextStyle(
                                      color: Colors.grey.shade800, fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                      barGroups: data.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final day = entry.value;
                        final y = day.count.toDouble();

                        Color color = Colors.blue;
                        if (vm.selectedIndex.value == idx) {
                          if (y > 10) {
                            color = Colors.green;
                          } else {
                            color = Colors.red;
                          }
                        }

                        return BarChartGroupData(x: idx, barRods: [
                          BarChartRodData(
                            toY: y,
                            width: 18,
                            borderRadius: BorderRadius.circular(6),
                            color: color,
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // remove bottom navigation as requested, so only top content and chart.
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: SvgPicture.asset(
          AppImages.dashboardsecondarylogo, // replace with your top logo or remove
          height: 36,
          errorBuilder: (_, __, ___) => const Text("edgewater"),
        ),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              _topCard(context),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 16),
                  const Text(
                    "Your Impact Today",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Spacer(),
                  Obx(() => Text(vm.todayDate.value)),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 12),
              // two small info cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Obx(() => _infoCard(
                      svgUrl: vm.card1SvgUrl.value,
                      topIcon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          AppImages.dashboardIcon1,
                          fit: BoxFit.contain,
                          height: 30,
                        ),
                      ),

                      mainText: vm.card1Count.value.toString(),
                      subText: vm.card1Subtitle.value,
                    )),
                    Obx(() => _infoCard(
                      svgUrl: vm.card2SvgUrl.value,
                      topIcon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          AppImages.dashboardIcon2,
                          fit: BoxFit.contain,
                           height: 30,
                        ),
                      ),
                      mainText: vm.card2TimeAgo.value,
                      subText: vm.card2Subtitle.value,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _chartCard(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
