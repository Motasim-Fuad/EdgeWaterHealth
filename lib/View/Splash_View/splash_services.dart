import 'dart:async';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:get/get.dart';


class SplashServices {
  void isLogin() async {
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token');
    // final role = prefs.getString('role');

    // print("💾 Token: $token");
    // print("💾 Role: $role");
    //
    // Timer(const Duration(seconds: 3), () {
    //   if (token == null || token.isEmpty) {
    //     Get.offNamed(RouteName.authView);
    //   } else {
    //     if (role == 'user') {
    //       Get.offNamed(RouteName.userBottomNavView);
    //     } else if (role == 'service_provider') {
    //       Get.offNamed(RouteName.providerBtmNavView);
    //     } else if (role == 'vendor') {
    //       Get.off(Vendorhome());
    //       Utils.successSnackBar("vendor", "vendor page");
    //     } else {
    //       Get.snackbar("Error", "Unknown role: $role");
    //       Get.offNamed(RouteName.authView);
    //     }
    //   }
    // });

    Timer(Duration (seconds: 3),(){
      Get.offAllNamed(RouteName.onbordingOne);
    });


  }
}
