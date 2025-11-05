import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordRequest.dart';
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPRequest.dart';
import 'package:edgewaterhealth/Repository/Authentication/ForgotPasswordRepository.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewModel extends GetxController {
  // Controllers
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  // Form Keys
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  // Observable variables
  final isLoading = false.obs;
  final isOTPVerifying = false.obs;
  final isPasswordResetting = false.obs;
  final isResendingOTP = false.obs;
  final currentStep = 0.obs;
  final userEmail = ''.obs;
  final resetToken = ''.obs;

  // Validation methods
  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value?.isEmpty ?? true) return 'New password is required';
    if (value!.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value?.isEmpty ?? true) return 'Please confirm your password';
    if (value != newPasswordController.text) return 'Passwords do not match';
    return null;
  }

  // Send Reset Password OTP
  Future<void> sendResetPasswordOTP() async {
    if (!emailFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final request = ForgotPasswordRequest(
        email: emailController.text.trim(),
      );

      final response = await ForgotPasswordRepository.sendResetPasswordOTP(request);

      print('Send Reset OTP - Status: ${response.statusCode}, Success: ${response.success}');
      print('Send Reset OTP - Message: ${response.message}');

      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        userEmail.value = emailController.text.trim();
        if (response.resetToken != null) {
          resetToken.value = response.resetToken!;
        }
        currentStep.value = 1;

        Get.snackbar(
          'Success',
          response.message.isNotEmpty ? response.message : 'OTP sent to your email',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message.isNotEmpty ? response.message : 'Failed to send OTP',
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

  // Verify Reset Password OTP
  Future<void> verifyResetOTP(String otp) async {
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

      final request = VerifyResetOTPRequest(
        email: userEmail.value,
        otp: otp,
      );

      final response = await ForgotPasswordRepository.verifyResetOTP(request);

      print('Verify Reset OTP - Status: ${response.statusCode}, Success: ${response.success}');
      print('Verify Reset OTP - Message: ${response.message}');
      print('Verify Reset OTP - isValidOTP: ${response.isValidOTP}');

      if (response.success && (response.statusCode == 200 || response.statusCode == 201) && response.isValidOTP) {
        currentStep.value = 2;

        Get.snackbar(
          'Success',
          response.message.isNotEmpty ? response.message : 'OTP verified successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message.isNotEmpty ? response.message : 'Invalid OTP',
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

  // Reset Password
  Future<void> resetPassword() async {
    if (!passwordFormKey.currentState!.validate()) return;

    try {
      isPasswordResetting.value = true;

      final otp = otpControllers.map((c) => c.text).join();

      final request = ResetPasswordRequest(
        email: userEmail.value,
        otp: otp,
        password: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final response = await ForgotPasswordRepository.resetPassword(request);

      print('Reset Password - Status: ${response.statusCode}, Success: ${response.success}');
      print('Reset Password - Message: ${response.message}');

      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        Get.snackbar(
          'Success',
          response.message.isNotEmpty ? response.message : 'Password reset successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );

        _clearAllData();
        await Future.delayed(Duration(seconds: 1));
        Get.offAllNamed(RouteName.signinView);
      } else {
        Get.snackbar(
          'Error',
          response.message.isNotEmpty ? response.message : 'Failed to reset password',
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
      isPasswordResetting.value = false;
    }
  }

  // Resend Reset Password OTP
  Future<void> resendResetOTP() async {
    try {
      isResendingOTP.value = true;

      final response = await ForgotPasswordRepository.resendResetOTP(userEmail.value);

      print('Resend Reset OTP - Status: ${response.statusCode}, Success: ${response.success}');
      print('Resend Reset OTP - Message: ${response.message}');

      if (response.success && (response.statusCode == 200 || response.statusCode == 201)) {
        for (var controller in otpControllers) {
          controller.clear();
        }

        Get.snackbar(
          'Success',
          response.message.isNotEmpty ? response.message : 'OTP sent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message.isNotEmpty ? response.message : 'Failed to resend OTP',
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

  void _clearAllData() {
    emailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    for (var controller in otpControllers) {
      controller.clear();
    }
    currentStep.value = 0;
    userEmail.value = '';
    resetToken.value = '';
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}