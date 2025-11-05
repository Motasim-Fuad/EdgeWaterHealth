// lib/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart
import 'package:edgewaterhealth/Model/Authentication/SignUpRequestModel.dart';
import 'package:edgewaterhealth/Model/Authentication/sing_up_otp_model.dart';
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';
import 'package:edgewaterhealth/Repository/Authentication/Authentication_repository.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isOTPVerifying = false.obs;
  final isResendingOTP = false.obs;
  final currentStep = 0.obs;
  final userEmail = ''.obs;
  final user = Rx<User?>(null);

  // Validations
  String? validateFullName(String? value) {
    if (value?.isEmpty ?? true) return 'Full name is required';
    if (value!.length < 2) return 'Full name must be at least 2 characters';
    return null;
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) return 'Password is required';
    if (value!.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value?.isEmpty ?? true) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  // Request OTP (Step 1)
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await AuthRepository.signUp(
        SignUpRequest(email: emailController.text.trim()),
      );

      print('SignUp - Status: ${response.statusCode}, Success: ${response.success}');

      // ✅ Status Code দিয়ে success check
      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        userEmail.value = emailController.text.trim();
        currentStep.value = 1;

        Get.snackbar(
          'Success',
          response.message ?? 'OTP sent to your email',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to send OTP',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP (Step 2)
  Future<void> verifyOTP(String otp) async {
    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
      return;
    }

    try {
      isOTPVerifying.value = true;

      final response = await AuthRepository.verifyOTP(
        OTPVerificationRequest(email: userEmail.value, otp: otp),
      );

      print('Verify OTP - Status: ${response.statusCode}, Success: ${response.success}');

      // ✅ Status Code দিয়ে success check
      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        user.value = response.user;
        currentStep.value = 2;

        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    } finally {
      isOTPVerifying.value = false;
    }
  }

  // Complete Signup (Step 3)
  Future<void> completeSignup() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await AuthRepository.completeSignup(
        SignUpRequest(
          email: userEmail.value,
          name: fullNameController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
      );

      print('Complete Signup - Status: ${response.statusCode}, Success: ${response.success}');

      // ✅ Status Code দিয়ে success check
      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        Get.snackbar(
          'Success',
          response.message ?? 'Account created successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );

        await Future.delayed(Duration(seconds: 1));
        Get.offAllNamed(RouteName.signinView);
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to create account',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    try {
      isResendingOTP.value = true;

      final response = await AuthRepository.resendOTP(userEmail.value);

      print('Resend OTP - Status: ${response.statusCode}, Success: ${response.success}');

      // ✅ Status Code দিয়ে success check
      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        for (var controller in otpControllers) {
          controller.clear();
        }

        Get.snackbar(
          'Success',
          response.message ?? 'OTP sent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to resend OTP',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    } finally {
      isResendingOTP.value = false;
    }
  }

  void goBackToPreviousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  // @override
  // void onClose() {
  //   fullNameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   for (var controller in otpControllers) {
  //     controller.dispose();
  //   }
  //   super.onClose();
  // }
}