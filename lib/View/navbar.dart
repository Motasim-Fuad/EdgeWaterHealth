import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/HomeView/Home_view.dart';
import '../View/FormView/FormView.dart';
import '../View/ProfileView/profile_view.dart';
import '../ViewModel/navBarController.dart';

class APPNavBarView extends StatelessWidget {
  APPNavBarView({super.key});

  final AppNavBarController controller = Get.put(AppNavBarController());

  final List<Widget> _pages = [
    HomeView(),
    Formview(),
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
          'asstes/Form.png', // your image
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
            // surfaceTintColor: Colors.white,
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
                  const SizedBox(width: 48,), // space for FAB
                  _buildBottomBarItem(
                    image: 'asstes/pexels-olly-3785424.jpg',
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
        height: 70, // match BottomAppBar height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: isSelected ? selectedColor : Colors.grey , width: 2),
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
