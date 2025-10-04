import 'package:edgewaterhealth/ViewModel/form_submition_view_model/mobile_crisis_controller.dart';
import 'package:get/get.dart';

class MobileCrisisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileCrisisController>(
          () => MobileCrisisController(),
    );
  }
}