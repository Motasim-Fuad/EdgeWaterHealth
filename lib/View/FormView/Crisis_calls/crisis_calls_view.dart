import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_dropdownd.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_text_field.dart';
import 'package:edgewaterhealth/ViewModel/form_submition_view_model/crisis_calls_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CrisisCallsView extends GetView<CrisisCallsController> {
  const CrisisCallsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Crisis Calls',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
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
              // Call By County
              _buildSectionLabel('Call By County'),
              const SizedBox(height: 8),
              Obx(() => AppDropdown<String>(
                items: controller.counties,
                selectedItem: controller.selectedCounty.value,
                hintText: 'Select an option',
                itemAsString: (item) => item,
                onChanged: (value) {
                  controller.selectedCounty.value = value;
                },
              )),
              const SizedBox(height: 16),

              // Address On
              _buildSectionLabel('Address On'),
              const SizedBox(height: 8),
              CustomTextField(
                label: '',
                hintText: 'Search Here...',
                controller: controller.addressController,
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),

              // Main Co
              _buildSectionLabel('Main Co'),
              const SizedBox(height: 8),
              CustomTextField(
                label: '',
                hintText: 'Search Here...',
                controller: controller.mainController,
              ),
              const SizedBox(height: 16),

              // Crisis Type
              _buildSectionLabel('Crisis Type'),
              const SizedBox(height: 8),
              Obx(() => AppDropdown<String>(
                items: controller.crisisTypes,
                selectedItem: controller.selectedCrisisType.value,
                hintText: 'Select an option',
                itemAsString: (item) => item,
                onChanged: (value) {
                  controller.selectedCrisisType.value = value;
                },
              )),
              const SizedBox(height: 16),

              // Other
              _buildSectionLabel('Other'),
              const SizedBox(height: 8),
              Obx(() => AppDropdown<String>(
                items: controller.counties,
                selectedItem: controller.selectedOther.value,
                hintText: 'Select an option',
                itemAsString: (item) => item,
                onChanged: (value) {
                  controller.selectedOther.value = value;
                },
              )),
              const SizedBox(height: 16),

              // Crisis Details
              _buildSectionLabel('Write here crisis details'),
              const SizedBox(height: 8),
              CustomTextField(
                label: '',
                hintText: 'Enter details...',
                controller: controller.crisisDetailsController,
                maxLines: 4,
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

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }
}