import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_otp_field.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPVerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 80,
                color: Color(0xFF7BC4D4),
              ),

              const SizedBox(height: 20),

              const Text(
                "OTP verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // ❌ Obx bad diye static Text rakhlam
              const Text(
                "We've sent a code to your email. Enter it below to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              OTPInputField(
                controllers: controller.otpControllers,
                onCompleted: (otp) {
                  controller.verifyOTP(otp);
                },
              ),

              const SizedBox(height: 30),

              // ✅ Obx er vitor hocche reactive part
              Obx(() => RoundButton(
                title: "Verify OTP",
                onPress: () {
                  final otp = controller.otpControllers.map((c) => c.text).join();
                  controller.verifyOTP(otp);
                },
                loading: controller.isOTPVerifying.value,
                showLoader: true,
                showLoadingText: true,
                loadingText: "Verifying...",
                width: double.infinity,
                buttonColor: const Color(0xFF7BC4D4),
              )),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't get the OTP? "),
                  Obx(() => GestureDetector(
                    onTap: controller.isResendingOTP.value ? null : controller.resendOTP,
                    child: Text(
                      controller.isResendingOTP.value ? "Sending..." : "Resend",
                      style: TextStyle(
                        color: controller.isResendingOTP.value
                            ? Colors.grey
                            : const Color(0xFF7BC4D4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
