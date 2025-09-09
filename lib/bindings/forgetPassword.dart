import 'package:edgewaterhealth/ViewModel/Authentication_View_Model/forget_password_view_model.dart' show ForgotPasswordViewModel;
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  }
}