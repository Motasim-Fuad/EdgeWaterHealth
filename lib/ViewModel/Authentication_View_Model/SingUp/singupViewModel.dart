import 'package:edgewaterhealth/Model/Authentication/SignUpRequestModel.dart';
import 'package:edgewaterhealth/Model/Authentication/sing_up_otp_model.dart' show OTPVerificationRequest;
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Repository/Authentication/Authentication_repository.dart' show AuthRepository;

class SignUpViewModel extends GetxController {
  // Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final isLoading = false.obs;
  final isOTPVerifying = false.obs;
  final isResendingOTP = false.obs;
  final currentStep = 0.obs; // 0: form, 1: otp verification, 2: profile setup
  final userEmail = ''.obs;
  final user = Rx<User?>(null);

  // Validation
  String? validateFullName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Full name is required';
    }
    if (value!.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password is required';
    }
    if (value!.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Sign Up
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final request = SignUpRequest(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final response = await AuthRepository.signUp(request);

      if (response.success) {
        userEmail.value = emailController.text.trim();
        currentStep.value = 1; // Move to OTP verification step
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String otp) async {
    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isOTPVerifying.value = true;

      final request = OTPVerificationRequest(
        email: userEmail.value,
        otp: otp,
      );

      final response = await AuthRepository.verifyOTP(request);

      if (response.success) {
        user.value = response.user;
        currentStep.value = 2; // Move to profile setup or complete

        Get.snackbar(
          'Success',
          'Email verified successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to dashboard or profile setup
        // Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isOTPVerifying.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    try {
      isResendingOTP.value = true;

      final response = await AuthRepository.resendOTP(userEmail.value);

      if (response.success) {
        // Clear OTP fields
        for (var controller in otpControllers) {
          controller.clear();
        }

        Get.snackbar(
          'Success',
          'OTP sent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to resend OTP',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isResendingOTP.value = false;
    }
  }

  // Go back to previous step
  void goBackToPreviousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}