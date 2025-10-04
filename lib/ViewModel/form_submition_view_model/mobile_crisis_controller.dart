import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileCrisisController extends GetxController {
  // Form fields data
  final formFields = <FormFieldData>[
    FormFieldData(label: 'Referrals to Mobile Crisis', isDropdown: true),
    FormFieldData(label: 'Number of Mobile Crisis Dispatches', isDropdown: false),
    FormFieldData(label: 'Mobile Crisis Dispatches by County', isDropdown: true),
    FormFieldData(label: 'Crisis Types', isDropdown: true),
    FormFieldData(label: 'Outcome', isDropdown: true),
    FormFieldData(label: 'Total Response Time', isDropdown: false),
    FormFieldData(label: 'Mean Response Time', isDropdown: false),
    FormFieldData(label: 'Total On-Scene Time', isDropdown: false),
    FormFieldData(label: 'Mean On-Scene Time', isDropdown: false),
    FormFieldData(label: 'Referrals Given', isDropdown: false),
    FormFieldData(label: 'Referrals by Type', isDropdown: true),
    FormFieldData(label: 'Referrals to Psychiatric', isDropdown: true),
    FormFieldData(label: 'Follow-Up Contacts', isDropdown: false),
    FormFieldData(label: 'Individuals Served', isDropdown: true),
    FormFieldData(label: 'Client Primary Insurance', isDropdown: true),
  ];

  // Text Controllers
  late List<TextEditingController> textControllers;

  // Dropdown values
  late RxList<String?> dropdownValues;

  // Loading state
  final RxBool isLoading = false.obs;

  // Dropdown options
  final RxList<String> dropdownOptions = <String>[
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    textControllers = List.generate(
      formFields.length,
          (index) => TextEditingController(),
    );
    dropdownValues = List.generate(formFields.length, (index) => null).obs;
  }

  // Get form data
  Map<String, dynamic> getFormData() {
    Map<String, dynamic> data = {};
    for (int i = 0; i < formFields.length; i++) {
      if (formFields[i].isDropdown) {
        data[formFields[i].label] = dropdownValues[i];
      } else {
        data[formFields[i].label] = textControllers[i].text;
      }
    }
    return data;
  }

  // Validate form
  bool validateForm() {
    for (int i = 0; i < formFields.length; i++) {
      if (formFields[i].isDropdown) {
        if (dropdownValues[i] == null) {
          Get.snackbar(
            'Validation Error',
            'Please select ${formFields[i].label}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
          );
          return false;
        }
      } else {
        if (textControllers[i].text.isEmpty) {
          Get.snackbar(
            'Validation Error',
            'Please enter ${formFields[i].label}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
          );
          return false;
        }
      }
    }
    return true;
  }

  // Submit form
  Future<void> submitForm() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      final formData = getFormData();
      print('Mobile Crisis Form Data: $formData');

      isLoading.value = false;

      // Show success dialog
      SuccessDialog.show(
        onPrimaryPressed: () => resetForm(),
        onSecondaryPressed: () => Get.back(),
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
    for (var controller in textControllers) {
      controller.clear();
    }
    for (int i = 0; i < dropdownValues.length; i++) {
      dropdownValues[i] = null;
    }
  }

  @override
  void onClose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

// Form field data model
class FormFieldData {
  final String label;
  final bool isDropdown;

  FormFieldData({
    required this.label,
    required this.isDropdown,
  });
}
