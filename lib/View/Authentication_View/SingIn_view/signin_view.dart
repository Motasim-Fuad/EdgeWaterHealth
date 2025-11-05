// signin_view.dart
import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart';
import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/singin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SigninViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                //logo
                SvgPicture.asset(AppImages.splashScreen,height: 150,),

                const SizedBox(height: 20),


                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.boxColor,
                  ),
                  child: Column(
                    children: [
                      // Welcome Back Text
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Sign in to continue your account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Email Field
                      CustomTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF7BC4D4),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Password Field
                      Obx(() => CustomTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        validator: controller.validatePassword,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF7BC4D4),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      )),

                      const SizedBox(height: 12),

                      // Remember Me & Forgot Password Row
                      Row(
                        children: [
                          Obx(() => Row(
                            children: [
                              Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: controller.toggleRememberMe,
                                activeColor: const Color(0xFF2489B0),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ],
                          )),

                          const Spacer(),

                          TextButton(
                            onPressed: controller.forgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2489B0),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Sign In Button
                      Obx(() => SizedBox(
                        width: double.infinity,
                        child: RoundButton(
                          title: 'Sign In',
                          onPress: controller.signIn,
                          buttonColor: const Color(0xFF2489B0),
                          height: 50,
                          width: double.infinity,
                          loading: controller.isLoading.value,
                          showLoader: true,
                          showLoadingText: true,
                          loadingText: 'Signing in...',
                        ),
                      )),
                    ],
                  ),
                ),



                const SizedBox(height: 12),

                // Don't have account text
                const Text(
                  "Don't have any account?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9CA3AF),
                  ),
                ),

                const SizedBox(height: 12),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.createAccount,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF2489B0),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2489B0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
