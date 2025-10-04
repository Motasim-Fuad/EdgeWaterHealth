import 'package:edgewaterhealth/ViewModel/form_submition_view_model/crisis_stabilization_controller.dart';
import 'package:get/get.dart';

class CrisisStabilizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrisisStabilizationController>(
          () => CrisisStabilizationController(),
    );
  }
}