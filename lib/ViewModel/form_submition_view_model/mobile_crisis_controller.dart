import 'package:edgewaterhealth/Model/submit_form_model/MobileCrisisModel.dart';
import 'package:edgewaterhealth/Model/submit_form_model/form_models.dart';
import 'package:edgewaterhealth/Repository/form/form_repository.dart';
import 'package:edgewaterhealth/Resources/AppComponents/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileCrisisController extends GetxController {
  // Form fields data
  final formFields = <FormFieldData>[
    FormFieldData(label: 'Referral Source', isDropdown: true, fieldType: FieldType.referralSource),
    FormFieldData(label: 'Total Dispatches', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Dispatch County', isDropdown: true, fieldType: FieldType.county),
    FormFieldData(label: 'Crisis Type', isDropdown: true, fieldType: FieldType.crisisType),
    FormFieldData(label: 'Outcome', isDropdown: true, fieldType: FieldType.outcome),
    FormFieldData(label: 'Total Response Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Mean Response Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Total On Scene Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Mean On Scene Time (minutes)', isDropdown: false, fieldType: FieldType.time),
    FormFieldData(label: 'Referrals Given', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Referral Type', isDropdown: true, fieldType: FieldType.referralType),
    FormFieldData(label: 'Naloxone Dispensations', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Follow Up Contacts', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Individuals Served', isDropdown: false, fieldType: FieldType.number),
    FormFieldData(label: 'Primary Insurance', isDropdown: true, fieldType: FieldType.insurance),
    FormFieldData(label: 'Age Group', isDropdown: true, fieldType: FieldType.ageGroup),
    FormFieldData(label: 'Veteran Status', isDropdown: true, fieldType: FieldType.veteranStatus),
    FormFieldData(label: 'Serving in Military', isDropdown: true, fieldType: FieldType.servingMilitary),
  ];

  // Text Controllers
  late List<TextEditingController> textControllers;

  // Dropdown values - FIX: Change to RxList<String> instead of RxList<String?>
  late RxList<String> dropdownValues;

  // Loading state
  final RxBool isLoading = false.obs;

  // Static data
  final List<String> referralSources = [
    "Law Enforcement/Justice System", "EMS", "Medical Hospitals", "Psychiatric Hospitals",
    "Behavioral Health Providers", "Schools", "Department of Child Services", "Faith-Based Organizations",
    "Housing Shelters", "Family and Friends", "Self", "Primary Healthcare", "Social Service Agency",
    "988", "911", "Other",
  ];

  final List<String> counties = [
    "adams co.", "allen co.", "bartholomew co.", "benton co.", "blackford co.",
    "boone co.", "brown co.", "carroll co.", "cass co.", "clark co.",
    // ... তোমার counties list
  ];

  final List<String> crisisTypes = [
    "Suicide Risk", "At Risk of Hurting Others", "Adult Mental Health",
    "Youth Mental Health", "Substance Use", "Other",
  ];

  final List<String> outcomes = [
    "Stabilized in the Community", "Sent to a Crisis Stabilization Unit",
    "Sent to the Emergency Room/Called EMS", "Law Enforcement Custody",
    "Sent to an Inpatient Psychiatric Facility", "Sent to a Substance Use Treatment Facility", "Other",
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

  // Get dropdown items based on field
  List<String> getDropdownItems(int index) {
    final fieldType = formFields[index].fieldType;

    switch (fieldType) {
      case FieldType.referralSource:
        return referralSources;
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
      final mobileCrisisData = MobileCrisisModel(
        referralSource: dropdownValues[0],
        totalDispatches: int.parse(textControllers[1].text),
        dispatchCounty: dropdownValues[2],
        crisisType: dropdownValues[3],
        outcome: dropdownValues[4],
        totalResponseTime: int.parse(textControllers[5].text),
        meanResponseTime: int.parse(textControllers[6].text),
        totalOnSceneTime: int.parse(textControllers[7].text),
        meanOnSceneTime: int.parse(textControllers[8].text),
        referralsGiven: int.parse(textControllers[9].text),
        referralType: dropdownValues[10],
        naloxoneDispensations: int.parse(textControllers[11].text),
        followUpContacts: int.parse(textControllers[12].text),
        individualsServed: int.parse(textControllers[13].text),
        primaryInsurance: dropdownValues[14],
        ageGroup: dropdownValues[15],
        veteranStatus: dropdownValues[16],
        servingInMilitary: dropdownValues[17],
      );

      final response = await ApiService.submitMobileCrisis(mobileCrisisData);

      isLoading.value = false;

      if (response.success) {
        SuccessDialog.show(
          onPrimaryPressed: () => resetForm(),
          onSecondaryPressed: () => Get.back(),
        );
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to submit mobile crisis data',
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