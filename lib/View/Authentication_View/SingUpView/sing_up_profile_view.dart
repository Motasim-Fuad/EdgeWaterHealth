// Profile Info View
import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart' show RoundButton;
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart' show CustomTextField;
import 'package:edgewaterhealth/Resources/AppComponents/password_fields.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart' show SignUpViewModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Icon(
            Icons.person_add_outlined,
            size: 80,
            color: Color(0xFF7BC4D4),
          ),

          const SizedBox(height: 20),

          const Text(
            "Almost finished!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Set up your name & password to create your new account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          // Full Name Field
          CustomTextField(
            label: "Full name",
            hintText: "Enter your full name",
            controller: controller.fullNameController,
            prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF7BC4D4)),
            validator: controller.validateFullName,
          ),

          const SizedBox(height: 20),

          // Password Field
          PasswordField(
            label: "Password",
            controller: controller.passwordController,
            showStrengthIndicator: true,
            validator: controller.validatePassword,
          ),

          const SizedBox(height: 20),

          // Confirm Password Field
          PasswordField(
            label: "Retype password",
            hintText: "Retype your password",
            controller: controller.confirmPasswordController,
            prefixIcon: const Icon(Icons.lock_reset_outlined, color: Color(0xFF7BC4D4)),
            validator: controller.validateConfirmPassword,
          ),

          const SizedBox(height: 30),

          // Create Account Button
          RoundButton(
            title: "Create new account",
            onPress: () {
              if (controller.formKey.currentState!.validate()) {
                // Handle final account creation
                Get.snackbar(
                  'Success',
                  'Account created successfully!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                // Navigate to dashboard
                // Get.offAllNamed('/dashboard');
              }
            },
            width: double.infinity,
            buttonColor: const Color(0xFF7BC4D4),
          ),
        ],
      ),
    );
  }
}