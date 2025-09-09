// Sign Up Form View
import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart' show SignUpViewModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field
            CustomTextField(
              label: "Email",
              hintText: "Enter your email",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF7BC4D4)),
              validator: controller.validateEmail,
            ),

            const SizedBox(height: 20),

            // Get OTP Button
            Obx(() => RoundButton(
              title: "Get OTP",
              onPress: controller.signUp,
              loading: controller.isLoading.value,
              showLoader: true,
              showLoadingText: true,
              loadingText: "Sending...",
              width: double.infinity,
              buttonColor: const Color(0xFF7BC4D4),
            )),

            const SizedBox(height: 20),

            // Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    // Navigate to sign in
                    Get.toNamed(RouteName.signinView);
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFF7BC4D4),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}