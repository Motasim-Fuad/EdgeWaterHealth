import 'package:edgewaterhealth/View/Authentication_View/ForgetPasswordView/GetOTPView.dart';
import 'package:edgewaterhealth/View/Authentication_View/ForgetPasswordView/OTPVerificationViewForgetPassword.dart';
import 'package:edgewaterhealth/View/Authentication_View/ForgetPasswordView/SetPasswordView.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordViewModel());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Forgot password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(() => controller.currentStep.value > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.goBackToPreviousStep,
        )
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        )),
      ),
      body: Obx(() {
        switch (controller.currentStep.value) {
          case 0:
            return GetOTPView();
          case 1:
            return OTPVerificationViewForgetPassword();
          case 2:
            return SetPasswordView();
          default:
            return GetOTPView();
        }
      }),
    );
  }
}