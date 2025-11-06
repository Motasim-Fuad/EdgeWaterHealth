import 'package:edgewaterhealth/Model/submit_form_model/CrisisCallModel.dart';
import 'package:edgewaterhealth/Repository/form/form_repository.dart';
import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrisisCallsController extends GetxController {
  // Text Controllers - তোমার UI অনুযায়ী
  final addressController = TextEditingController();
  final mainController = TextEditingController();
  final crisisDetailsController = TextEditingController();

  // Reactive variables - তোমার UI অনুযায়ী
  final Rx<String?> selectedCounty = Rx<String?>(null);
  final Rx<String?> selectedCrisisType = Rx<String?>(null);
  final Rx<String?> selectedOther = Rx<String?>(null);
  final RxBool isLoading = false.obs;

  // Static data - তোমার Node.js model অনুযায়ী
  final List<String> counties = [
    "adams co.", "allen co.", "bartholomew co.", "benton co.", "blackford co.",
    "boone co.", "brown co.", "carroll co.", "cass co.", "clark co.",
    "clay co.", "clinton co.", "crawford co.", "daviess co.", "dearborn co.",
    "decatur co.", "dekalb co.", "delaware co.", "dubois co.", "elkhart co.",
    "fayette co.", "floyd co.", "fountain co.", "frankin co.", "fulton co.",
    "gibson co.", "grant co.", "greene co.", "hamilton co.", "hancock co.",
    "harrison co.", "hendricks co.", "henry co.", "howard co.", "huntington co.",
    "jackson co.", "jasper co.", "jay co.", "jefferson co.", "jennings co.",
    "johnson co.", "knox co.", "kosciusko co.", "lagrange co.", "lake co.",
    "laporte co.", "lawrence co.", "madison co.", "marion co.", "marshall co.",
    "martin co.", "miami co.", "monroe co.", "montgomery co.", "morgan co.",
    "newton co.", "noble co.", "ohio co.", "orange co.", "owen co.",
    "parke co.", "perry co.", "pike co.", "porter co.", "posey co.",
    "pulaski co.", "putnam co.", "randolph co.", "ripley co.", "rush co.",
    "scott co.", "shelby co.", "spencer co.", "st. joseph co.", "starke co.",
    "steuben co.", "sullivan co.", "switzerland co.", "tippecanoe co.", "tipton co.",
    "union co.", "vanderburgh co.", "vermillion co.", "vigo co.", "wabash co.",
    "warren co.", "warrick co.", "washington co.", "wayne co.", "wells co.",
    "white co.", "whitley co.",
  ];

  final List<String> crisisTypes = [
    "Suicide Risk",
    "At Risk of Hurting Others",
    "Adult Mental Health",
    "Youth Mental Health",
    "Substance Use",
    "Other",
  ];

  // Validate form
  bool validateForm() {
    if (selectedCounty.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select a county',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }

    if (selectedCrisisType.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select crisis type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }

    return true;
  }

  // Submit form
  Future<void> submitForm() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      final crisisCallData = CrisisCallModel(
        callByCountry: selectedCounty.value!,
        crisisType: selectedCrisisType.value!,
        description: crisisDetailsController.text.isEmpty ? null : crisisDetailsController.text,
      );

      final response = await ApiService.submitCrisisCall(crisisCallData);

      isLoading.value = false;

      if (response.success) {
        SuccessDialog.show(
          title: 'Report Successfully\nSubmitted!',
          message: 'Your crisis call has been recorded successfully.',
          question: 'What would you like to do next?',
          primaryButtonText: 'New Report',
          secondaryButtonText: 'Home',
          onPrimaryPressed: () {
            resetForm();
          },
          onSecondaryPressed: () {
            Get.back();
          },
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to submit crisis call',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to submit report: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  // Reset form
  void resetForm() {
    addressController.clear();
    mainController.clear();
    crisisDetailsController.clear();
    selectedCounty.value = null;
    selectedCrisisType.value = null;
    selectedOther.value = null;
  }

  @override
  void onClose() {
    addressController.dispose();
    mainController.dispose();
    crisisDetailsController.dispose();
    super.onClose();
  }
}