// lib/ViewModel/Authentication_View_Model/singin_view_model.dart
import 'package:edgewaterhealth/Repository/Authentication/Authentication_repository.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:edgewaterhealth/Services/StorageServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninViewModel extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable variables
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberMe();
  }

  // Load remember me preference
  Future<void> _loadRememberMe() async {
    rememberMe.value = await StorageService.getRememberMe();
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
    StorageService.saveRememberMe(rememberMe.value);
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Sign in method
  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await AuthRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );

      print('Login - Status: ${response.statusCode}, Success: ${response.success}');

      // ✅ Status Code দিয়ে success check
      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        Get.snackbar(
          'Success',
          response.message ?? 'Sign in successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16),
        );

        // Navigate to home or dashboard
        Get.offAllNamed(RouteName.appNavBarView);
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Sign in failed. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password
  void forgotPassword() {
    Get.toNamed(RouteName.forgotPasswordView);
  }

  // Create account
  void createAccount() {
    Get.toNamed(RouteName.signupView);
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}