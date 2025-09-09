import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/SingUp/singupViewModel.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(() => SignUpViewModel());
  }
}