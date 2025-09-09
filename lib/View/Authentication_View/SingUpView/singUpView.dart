import 'package:edgewaterhealth/View/Authentication_View/SingUpView/otp_verification_view.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingUpView/sing_up_form_view.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingUpView/sing_up_profile_view.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpViewModel());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create new account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(() => controller.currentStep.value > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.goBackToPreviousStep,
        )
            : const SizedBox.shrink()),
      ),
      body: Obx(() {
        switch (controller.currentStep.value) {
          case 0:
            return SignUpFormView();
          case 1:
            return OTPVerificationView();
          case 2:
            return ProfileInfoView();
          default:
            return SignUpFormView();
        }
      }),
    );
  }
}
