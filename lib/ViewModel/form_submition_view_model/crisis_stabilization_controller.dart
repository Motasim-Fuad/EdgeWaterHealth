import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrisisStabilizationController extends GetxController {
  // Form fields data
  final formFields = <FormFieldData>[
    FormFieldData(label: 'Referrals to Crisis Stabilization', isDropdown: true),
    FormFieldData(label: 'Number of Visits', isDropdown: false),
    FormFieldData(label: 'Crisis Types', isDropdown: true),
    FormFieldData(label: 'Outcome', isDropdown: true),
    FormFieldData(label: 'Total Stabilization Time', isDropdown: false),
    FormFieldData(label: 'Mean Stabilization Time', isDropdown: false),
    FormFieldData(label: 'Referrals Given', isDropdown: false),
    FormFieldData(label: 'Referrals by Type', isDropdown: true),
    FormFieldData(label: 'Service by Type', isDropdown: true),
    FormFieldData(label: 'Follow-Up Contacts', isDropdown: false),
    FormFieldData(label: 'Individuals Served', isDropdown: true),
    FormFieldData(label: 'Resource Dispensations', isDropdown: false),
    FormFieldData(label: 'Clients County of Residence', isDropdown: true),
    FormFieldData(label: 'Client Primary Insurance', isDropdown: true),
    FormFieldData(label: 'Client Age Groups', isDropdown: true),
    FormFieldData(label: 'Client Gender', isDropdown: true),
    FormFieldData(label: 'Client Veteran Status', isDropdown: true),
    FormFieldData(label: 'Client Serving in Military', isDropdown: true),
  ];

  // Text Controllers
  late List<TextEditingController> textControllers;

  // Dropdown values
  late RxList<String?> dropdownValues;

  // Loading state
  final RxBool isLoading = false.obs;

  // Dropdown options
  final RxList<String> crisisOptions = <String>[
    'Crisis Type A',
    'Crisis Type B',
    'Crisis Type C',
  ].obs;

  final RxList<String> outcomeOptions = <String>[
    'Resolved',
    'Referred',
    'Ongoing',
  ].obs;

  final RxList<String> countyOptions = <String>[
    'Adams Co.',
    'Bartholomew Co.',
    'Benton Co.',
  ].obs;

  final RxList<String> insuranceOptions = <String>[
    'Medicaid',
    'Medicare',
    'Private',
    'None',
  ].obs;

  final RxList<String> ageGroupOptions = <String>[
    '0-17',
    '18-25',
    '26-40',
    '41-60',
    '60+',
  ].obs;

  final RxList<String> genderOptions = <String>[
    'Male',
    'Female',
    'Non-Binary',
    'Prefer not to say',
  ].obs;

  final RxList<String> yesNoOptions = <String>[
    'Yes',
    'No',
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

  // Get dropdown items based on field
  List<String> getDropdownItems(int index) {
    final label = formFields[index].label;

    if (label.contains('Crisis Type')) return crisisOptions;
    if (label.contains('Outcome')) return outcomeOptions;
    if (label.contains('County')) return countyOptions;
    if (label.contains('Insurance')) return insuranceOptions;
    if (label.contains('Age')) return ageGroupOptions;
    if (label.contains('Gender')) return genderOptions;
    if (label.contains('Veteran') || label.contains('Military')) {
      return yesNoOptions;
    }

    return crisisOptions; // Default
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
      print('Crisis Stabilization Form Data: $formData');

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