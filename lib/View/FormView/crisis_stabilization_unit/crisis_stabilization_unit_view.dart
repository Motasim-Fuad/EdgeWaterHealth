import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_dropdownd.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart';
import 'package:edgewaterhealth/ViewModel/form_submition_view_model/crisis_stabilization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CrisisStabilizationView extends GetView<CrisisStabilizationController> {
  const CrisisStabilizationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Crisis Stabilization Unit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.resetForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(),
            borderRadius: BorderRadius.circular(20),
            color: AppColor.boxColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Generate form fields dynamically
              ...List.generate(
                controller.formFields.length,
                    (index) => _buildFormField(index),
              ),

              const SizedBox(height: 24),

              // Submit Button
              Obx(() => RoundButton(
                title: 'Submit Report',
                width: double.infinity,
                height: 50,
                loading: controller.isLoading.value,
                showLoader: true,
                showLoadingText: true,
                loadingText: 'Submitting...',
                onPress: controller.submitForm,
              )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(int index) {
    final field = controller.formFields[index];

    return Column(
      children: [
        _buildSectionLabel(field.label),
        const SizedBox(height: 8),
        if (field.isDropdown)
          Obx(() => AppDropdown<String>(
            items: controller.getDropdownItems(index),
            selectedItem: controller.dropdownValues[index].isEmpty ? null : controller.dropdownValues[index],
            hintText: 'Select an option',
            itemAsString: (item) => item,
            onChanged: (value) {
              if (value != null) {
                controller.dropdownValues[index] = value;
              }
            },
          ))
        else
          CustomTextField(
            label: '',
            hintText: 'Enter a number',
            controller: controller.textControllers[index],
            keyboardType: TextInputType.number,
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
      ),
    );
  }
}