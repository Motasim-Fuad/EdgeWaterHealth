import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewReportView extends StatelessWidget {
  const NewReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Report',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // IMAGE ASSET PLACEHOLDER
            // Replace this Container with your actual Image.asset or SvgPicture.asset
            Container(
              height: 150,
              width: double.infinity,

              child: Center(child: SvgPicture.asset(AppImages.newReport)),
            ),
            SizedBox(height: 20),
            Text(
              'Choose. Complete. Submit.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'You can fill one form or all three, then submit together',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionCard(
                    title: 'Crisis Calls',
                    subtitle: 'Log incoming calls with details by location and type.',
                    onTap: () {
                      // Navigate to Crisis Calls form
                      Get.toNamed(RouteName.crisisCallsView);
                    },
                  ),
                  _buildOptionCard(
                    title: 'Mobile Crisis',
                    subtitle: 'Document dispatches, response times, and outcomes on the go',
                    onTap: () {
                      // Navigate to Mobile Crisis form
                      Get.toNamed(RouteName.mobileCrisisView);
                    },
                  ),
                  _buildOptionCard(
                    title: 'Crisis Stabilization Unit',
                    subtitle: 'Document visits, stabilization times and outcomes cases',
                    onTap: () {
                      // Navigate to CSU form
                      Get.toNamed(RouteName.crisisStabilizationUnitView);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
