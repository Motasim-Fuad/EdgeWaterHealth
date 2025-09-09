
// signin_controller.dart
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
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

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically call your authentication service
      // AuthService.signIn(emailController.text, passwordController.text);

      Get.snackbar(
        'Success',
        'Sign in successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to home or dashboard
      // Get.offAllNamed('/home');

    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign in failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}