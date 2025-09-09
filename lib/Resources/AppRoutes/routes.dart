import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:edgewaterhealth/View/Authentication_View/ForgetPasswordView/ForgotPasswordView.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingIn_view/signin_view.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingUpView/singUpView.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_one.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_three.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_two.dart';
import 'package:edgewaterhealth/View/navbar.dart';
import 'package:edgewaterhealth/View/splash_view/splash_view.dart';
import 'package:get/get.dart';

class AppRouts {
  static approutes() => [
  GetPage(
  name: RouteName.splashScreen,
  page: () => SplashView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),
 GetPage(
  name: RouteName.onbordingOne,
  page: () => OnbordingViewOne(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),
    GetPage(
  name: RouteName.onbordingViewTwo,
  page: () => OnbordingViewTwo(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),
    GetPage(
  name: RouteName.onbordingViewThree,
  page: () => OnbordingViewThree(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.signinView,
  page: () => SigninView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.signupView,
  page: () => SignUpView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.forgotPasswordView,
  page: () => ForgotPasswordView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.appNavBarView,
  page: () => APPNavBarView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

  ];
}