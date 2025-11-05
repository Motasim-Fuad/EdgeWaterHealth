import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/singin_view_model.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninViewModel>(
          () => SigninViewModel(),
      fenix: false,
    );
  }
}