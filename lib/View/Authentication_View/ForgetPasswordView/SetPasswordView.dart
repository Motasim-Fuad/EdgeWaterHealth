import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/password_fields.dart' show PasswordField;
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/forget_password_view_model.dart' show ForgotPasswordViewModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Icon(
            Icons.lock_reset_outlined,
            size: 80,
            color: Color(0xFF7BC4D4),
          ),

          const SizedBox(height: 20),

          const Text(
            "Unlock your account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Set a strong new password to unlock your account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          // Password Form
          Form(
            key: controller.passwordFormKey,
            child: Column(
              children: [
                // New Password Field
                PasswordField(
                  label: "New password",
                  hintText: "Enter new password",
                  controller: controller.newPasswordController,
                  showStrengthIndicator: true,
                  validator: controller.validateNewPassword,
                ),

                const SizedBox(height: 20),

                // Retype New Password Field
                PasswordField(
                  label: "Retype new password",
                  hintText: "Retype new password",
                  controller: controller.confirmPasswordController,
                  prefixIcon: const Icon(Icons.lock_reset_outlined, color: Color(0xFF7BC4D4)),
                  validator: controller.validateConfirmPassword,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Update Password Button
          Obx(() => RoundButton(
            title: "Update password",
            onPress: controller.resetPassword,
            loading: controller.isPasswordResetting.value,
            showLoader: true,
            showLoadingText: true,
            loadingText: "Updating...",
            width: double.infinity,
            buttonColor: const Color(0xFF7BC4D4),
          )),
        ],
      ),
    );
  }
}