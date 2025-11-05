import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:edgewaterhealth/View/Authentication_View/ForgetPasswordView/ForgotPasswordView.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingIn_view/signin_view.dart';
import 'package:edgewaterhealth/View/Authentication_View/SingUpView/singUpView.dart';
import 'package:edgewaterhealth/View/FormView/Crisis_calls/crisis_calls_view.dart';
import 'package:edgewaterhealth/View/FormView/crisis_stabilization_unit/crisis_stabilization_unit_view.dart';
import 'package:edgewaterhealth/View/FormView/mobile_crisis/mobile_crisis_view.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_one.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_three.dart';
import 'package:edgewaterhealth/View/OnboardingView/onbording_view_two.dart';
import 'package:edgewaterhealth/View/navbar.dart';
import 'package:edgewaterhealth/View/splash_view/splash_view.dart';
import 'package:edgewaterhealth/bindings/form/call_crisis_binding.dart';
import 'package:edgewaterhealth/bindings/form/crisis_stabilization_binding.dart';
import 'package:edgewaterhealth/bindings/form/mobile_crisis_binding.dart';
import 'package:edgewaterhealth/bindings/singin.dart';
import 'package:edgewaterhealth/bindings/singup.dart';
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
  binding: SignInBinding(),
      preventDuplicates: true,
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.signupView,
  page: () => SignUpView(),
  binding: SignUpBinding(),
      preventDuplicates: true,

  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.forgotPasswordView,
  page: () => ForgotPasswordView(),
      preventDuplicates: true,
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.appNavBarView,
  page: () => APPNavBarView(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

    GetPage(
  name: RouteName.crisisCallsView,
  page: () => CrisisCallsView(),
  binding: CrisisCallsBinding(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),


    GetPage(
  name: RouteName.crisisStabilizationUnitView,
  page: () => CrisisStabilizationView(),
      binding: CrisisStabilizationBinding(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),


    GetPage(
  name: RouteName.mobileCrisisView,
  page: () => MobileCrisisView(),
  binding: MobileCrisisBinding(),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(microseconds: 250),
  ),

  ];
}