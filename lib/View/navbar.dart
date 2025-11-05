import 'package:edgewaterhealth/ViewModel/dashboard_view_model/dashboard_view_model.dart';
import 'package:edgewaterhealth/ViewModel/profile_view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../View/FormView/FormView.dart';
import '../View/ProfileView/profile_view.dart';
import '../ViewModel/navBarController.dart';
import 'DashBoardView/DashBoardView.dart';

class APPNavBarView extends StatelessWidget {
  APPNavBarView({super.key});

  final AppNavBarController controller = Get.put(AppNavBarController());
  final ProfileViewModel profileController = Get.put(ProfileViewModel());

  final List<Widget> _pages = [
    DashboardView(),
    NewReportView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.selectedIndex.value = index;
        },
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changePage(1);
        },
        backgroundColor: Colors.white,
        elevation: 9,
        shape: CircleBorder(),
        child: Image.asset(
          'assets/Form.png',
          height: 28,
          width: 28,
        ),
      ),
      bottomNavigationBar: Obx(
            () {
          int selectedIndex = controller.selectedIndex.value;
          return BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 20,
            elevation: 10,
            color: Colors.white,
            shadowColor: Colors.blue,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => controller.changePage(0),
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            size: 28,
                            color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // space for FAB
                  _buildProfileBottomBarItem(
                    label: 'Profile',
                    index: 2,
                    selectedColor: Colors.blue,
                    isSelected: selectedIndex == 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileBottomBarItem({
    required String label,
    required int index,
    required Color selectedColor,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final profile = profileController.profile.value;
              final pickedImage = profileController.pickedImage.value;

              return Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? selectedColor : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: _buildProfileImage(profile?.profileImage, pickedImage),
                ),
              );
            }),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? selectedColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? networkImageUrl, dynamic pickedImage) {
    // If user picked a new image (not saved yet)
    if (pickedImage != null) {
      return Image.file(
        pickedImage,
        fit: BoxFit.cover,
      );
    }

    // If user has a profile image
    if (networkImageUrl != null && networkImageUrl.isNotEmpty) {
      return Image.network(
        networkImageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultAvatar();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    // Default avatar
    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: 24,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildBottomBarItem({
    required String image,
    required String label,
    required int index,
    required Color selectedColor,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected ? selectedColor : Colors.grey,
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? selectedColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}