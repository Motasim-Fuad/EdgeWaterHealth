import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ForgotPasswordRequest.dart' show ForgotPasswordRequest;
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/ResetPasswordRequest.dart' show ResetPasswordRequest;
import 'package:edgewaterhealth/Model/Authentication/fogetpssword/VerifyResetOTPRequest.dart' show VerifyResetOTPRequest;
import 'package:edgewaterhealth/Repository/Authentication/ForgotPasswordRepository.dart' show ForgotPasswordRepository;
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
  final currentStep = 0.obs; // 0: email, 1: otp verification, 2: new password
  final userEmail = ''.obs;
  final resetToken = ''.obs;

  // Validation methods
  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'New password is required';
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
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
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

      if (response.success) {
        userEmail.value = emailController.text.trim();
        if (response.resetToken != null) {
          resetToken.value = response.resetToken!;
        }
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

  // Verify Reset Password OTP
  Future<void> verifyResetOTP(String otp) async {
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

      final request = VerifyResetOTPRequest(
        email: userEmail.value,
        otp: otp,
      );

      final response = await ForgotPasswordRepository.verifyResetOTP(request);

      if (response.success && response.isValidOTP) {
        currentStep.value = 2; // Move to new password step

        Get.snackbar(
          'Success',
          'OTP verified successfully!',
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
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final response = await ForgotPasswordRepository.resetPassword(request);

      if (response.success) {
        Get.snackbar(
          'Success',
          'Password reset successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear all data
        _clearAllData();

        // Navigate to sign in
        Get.offAllNamed('/signin');
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
      isPasswordResetting.value = false;
    }
  }

  // Resend Reset Password OTP
  Future<void> resendResetOTP() async {
    try {
      isResendingOTP.value = true;

      final response = await ForgotPasswordRepository.resendResetOTP(userEmail.value);

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

  // Clear all data
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

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   newPasswordController.dispose();
  //   confirmPasswordController.dispose();
  //   for (var controller in otpControllers) {
  //     controller.dispose();
  //   }
  //   super.onClose();
  // }
}