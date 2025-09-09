import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  final PageController pageController = PageController();

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
