import 'package:edgewaterhealth/Model/submit_form_model/crisis_form_model.dart';
import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrisisCallsController extends GetxController {
  // Text Controllers
  final addressController = TextEditingController();
  final mainController = TextEditingController();
  final crisisDetailsController = TextEditingController();

  // Reactive variables
  final Rx<String?> selectedCounty = Rx<String?>(null);
  final Rx<String?> selectedCrisisType = Rx<String?>(null);
  final Rx<String?> selectedOther = Rx<String?>(null);
  final RxBool isLoading = false.obs;

  // Data lists
  final RxList<String> counties = <String>[
    'Adams Co.',
    'Bartholomew Co.',
    'Benton Co.',
    'Blackford Co.',
    'Boone Co.',
  ].obs;

  final RxList<String> crisisTypes = <String>[
    'Crisis Type A',
    'Crisis Type B',
    'Crisis Type C',
    'Crisis Type D',
  ].obs;

  // Get form data as model
  CrisisFormModel getFormData() {
    return CrisisFormModel(
      county: selectedCounty.value,
      address: addressController.text,
      mainCo: mainController.text,
      crisisType: selectedCrisisType.value,
      other: selectedOther.value,
      crisisDetails: crisisDetailsController.text,
    );
  }

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

    if (addressController.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter an address',
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
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final formData = getFormData();
      print('Form Data: ${formData.toJson()}');

      // Hide loading
      isLoading.value = false;

      // Show success dialog
      SuccessDialog.show(
        title: 'Report Successfully\nSubmitted!',
        message: 'Your data has been recorded accurately.\nThank you for your contribution.',
        question: 'What would you like to do next?',
        primaryButtonText: 'New Report',
        secondaryButtonText: 'Home',
        onPrimaryPressed: () {
          // Create new report - reset form
          resetForm();
        },
        onSecondaryPressed: () {
          // Go to home or previous screen
          Get.back(); // Or Get.offAllNamed(Routes.HOME);
        },
      );
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
