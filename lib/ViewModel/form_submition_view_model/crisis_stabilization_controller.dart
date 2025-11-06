import 'package:edgewaterhealth/Model/submit_form_model/CrisisStabilizationModel.dart';
import 'package:edgewaterhealth/Model/submit_form_model/form_models.dart';
import 'package:edgewaterhealth/Repository/form/form_repository.dart';
import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrisisStabilizationController extends GetxController {
  // Form fields data
  final formFields = <FormFieldData>[
    FormFieldData(label: 'Referrals to Crisis Stabilization', isDropdown: true, fieldType: FieldType.referralStabilization),
    FormFieldData(label: 'Number of Visits', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Crisis Types', isDropdown: true, fieldType: FieldType.crisisType),
    FormFieldData(label: 'Outcome', isDropdown: true, fieldType: FieldType.outcome),
    FormFieldData(label: 'Total Stabilization Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Mean Stabilization Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Referrals Given', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Referrals by Type', isDropdown: true, fieldType: FieldType.referralType),
    FormFieldData(label: 'Naloxone Dispensations', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Follow Up Contacts', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Individuals Served', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Client County of Residence', isDropdown: true, fieldType: FieldType.county),
    FormFieldData(label: 'Client Primary Insurance', isDropdown: true, fieldType: FieldType.insurance),
    FormFieldData(label: 'Client Age Groups', isDropdown: true, fieldType: FieldType.ageGroup),
    FormFieldData(label: 'Client Veteran Status', isDropdown: true, fieldType: FieldType.veteranStatus),
    FormFieldData(label: 'Client Serving in Military', isDropdown: true, fieldType: FieldType.servingMilitary),
  ];

  // Text Controllers
  late List<TextEditingController> textControllers;

  // Dropdown values - FIX: Change to RxList<String> instead of RxList<String?>
  late RxList<String> dropdownValues;

  // Loading state
  final RxBool isLoading = false.obs;

  // Static data
  final List<String> referralsToCrisisStabilization = [
    "Law Enforcement/Justice System", "EMS", "Mobile Crisis Team", "Medical Hospitals",
    "Psychiatric Hospitals", "Behavioral Health Providers", "Schools", "Department of Child Services",
    "Faith-Based Organizations", "Housing Shelters", "Family and Friends", "Self", "Primary Healthcare",
    "Social Service Agency", "988", "911", "Other",
  ];

  final List<String> counties = [
    "adams co.", "allen co.", "bartholomew co.", "benton co.", "blackford co.",
    // ... তোমার counties list
  ];

  final List<String> crisisTypes = [
    "Suicide Risk", "At Risk of Hurting Others", "Adult Mental Health",
    "Youth Mental Health", "Substance Use", "Other",
  ];

  final List<String> outcomes = [
    "Stabilized in the Community", "Sent to the Emergency Room/Called EMS",
    "Law Enforcement Custody", "Sent to an Inpatient Psychiatric Facility",
    "Sent to a Substance Use Treatment Facility", "Other",
  ];

  final List<String> referralTypes = [
    "Social Service Agency", "Mental Health Services/Treatment", "Substance Use Treatment",
    "Primary Health Care", "Domestic Violence Support", "Other",
  ];

  final List<String> primaryInsurances = [
    "Medicaid (not dually-eligible)", "HIP", "Medicare (not dually-eligible)",
    "Medicaid and Medicare (dually-eligible)", "Commercially Insured", "VHA/TRI Care",
    "CHIP", "Uninsured", "Other",
  ];

  final List<String> ageGroups = [
    "0–5 years", "6–12 years", "13–17 years", "18–20 years", "21–24 years",
    "25–44 years", "45–64 years", "65 years or over", "Unknown",
  ];

  final List<String> veteranStatuses = [
    "Yes", "No", "Not Applicable (Client under 18 years of age)",
  ];

  final List<String> servingInMilitaryStatuses = [
    "Yes", "No", "Refused", "Not Applicable (Client under 18 years of age)",
  ];

  @override
  void onInit() {
    super.onInit();
    textControllers = List.generate(
      formFields.length,
          (index) => TextEditingController(),
    );
    // FIX: Initialize with empty strings instead of null
    dropdownValues = List.generate(formFields.length, (index) => '').obs;
  }

  // Get dropdown items based on field type
  List<String> getDropdownItems(int index) {
    final fieldType = formFields[index].fieldType;

    switch (fieldType) {
      case FieldType.referralStabilization:
        return referralsToCrisisStabilization;
      case FieldType.county:
        return counties;
      case FieldType.crisisType:
        return crisisTypes;
      case FieldType.outcome:
        return outcomes;
      case FieldType.referralType:
        return referralTypes;
      case FieldType.insurance:
        return primaryInsurances;
      case FieldType.ageGroup:
        return ageGroups;
      case FieldType.veteranStatus:
        return veteranStatuses;
      case FieldType.servingMilitary:
        return servingInMilitaryStatuses;
      default:
        return [];
    }
  }

  // Validate form
  bool validateForm() {
    for (int i = 0; i < formFields.length; i++) {
      if (formFields[i].isDropdown) {
        if (dropdownValues[i].isEmpty) {
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
      final stabilizationData = CrisisStabilizationModel(
        referralsToCrisisStabilization: dropdownValues[0],
        numberOfVisits: int.parse(textControllers[1].text),
        crisisTypes: dropdownValues[2],
        outcome: dropdownValues[3],
        totalStabilizationTime: int.parse(textControllers[4].text),
        meanStabilizationTime: int.parse(textControllers[5].text),
        referralsGiven: int.parse(textControllers[6].text),
        referralsByType: dropdownValues[7],
        naloxoneDispensations: int.parse(textControllers[8].text),
        followUpContacts: int.parse(textControllers[9].text),
        individualsServed: int.parse(textControllers[10].text),
        clientCountyOfResidence: dropdownValues[11],
        clientPrimaryInsurance: dropdownValues[12],
        clientAgeGroups: dropdownValues[13],
        clientVeteranStatus: dropdownValues[14],
        clientServingInMilitary: dropdownValues[15],
      );

      final response = await ApiService.submitCrisisStabilization(stabilizationData);

      isLoading.value = false;

      if (response.success) {
        SuccessDialog.show(
          onPrimaryPressed: () => resetForm(),
          onSecondaryPressed: () => Get.back(),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to submit crisis stabilization data',
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
    for (var controller in textControllers) {
      controller.clear();
    }
    for (int i = 0; i < dropdownValues.length; i++) {
      dropdownValues[i] = '';
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