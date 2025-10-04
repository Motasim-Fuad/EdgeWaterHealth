import 'package:edgewaterhealth/ViewModel/form_submition_view_model/crisis_calls_controller.dart';
import 'package:get/get.dart';

class CrisisCallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrisisCallsController>(
          () => CrisisCallsController(),
    );
  }
}