import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/forget_password_view_model.dart' show ForgotPasswordViewModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetOTPView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Icon(
            Icons.email_outlined,
            size: 80,
            color: Color(0xFF7BC4D4),
          ),

          const SizedBox(height: 20),

          const Text(
            "Don't panic!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Enter your registered email address. We'll send you a verification code.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          // Email Form
          Form(
            key: controller.emailFormKey,
            child: CustomTextField(
              label: "Email",
              hintText: "Enter your email",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF7BC4D4)),
              validator: controller.validateEmail,
            ),
          ),

          const SizedBox(height: 30),

          // Get OTP Button
          Obx(() => RoundButton(
            title: "Get OTP",
            onPress: controller.sendResetPasswordOTP,
            loading: controller.isLoading.value,
            showLoader: true,
            showLoadingText: true,
            loadingText: "Sending...",
            width: double.infinity,
            buttonColor: const Color(0xFF7BC4D4),
          )),
        ],
      ),
    );
  }
}