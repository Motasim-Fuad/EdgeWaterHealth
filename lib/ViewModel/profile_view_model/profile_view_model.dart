import 'dart:io';
import 'package:edgewaterhealth/Model/Profile/profile_model.dart';
import 'package:edgewaterhealth/Repository/Profile/profile_repository.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:edgewaterhealth/Services/StorageServices.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepository _repo = ProfileRepository();

  var profile = Rxn<ProfileModel>();
  var isLoading = false.obs;
  var pickedImage = Rxn<File>();
  var isSaving = false.obs;

  // For editing name
  var isEditingName = false.obs;
  var editedName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final data = await _repo.fetchProfile();
      if (data != null) {
        profile.value = data;
        editedName.value = data.fullName;
      }
    } catch (e) {
      print("❌ Fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        print("✅ Image picked: ${pickedFile.path}");
        pickedImage.value = File(pickedFile.path);

        // Show message - user needs to click save
        Get.snackbar(
          "Image Selected",
          "Click the ✓ button to save changes",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      print("❌ Pick error: $e");
      Get.snackbar(
        "Error",
        "Failed to pick image",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void toggleEditName() {
    isEditingName.value = !isEditingName.value;
    if (!isEditingName.value && profile.value != null) {
      editedName.value = profile.value!.fullName;
    }
  }

  Future<void> saveProfile() async {
    try {
      isSaving.value = true;

      String? nameToUpdate;
      if (isEditingName.value && editedName.value.trim() != profile.value?.fullName) {
        nameToUpdate = editedName.value.trim();
        if (nameToUpdate.isEmpty) {
          Get.snackbar(
            "Error",
            "Name cannot be empty",
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      print("💾 Saving profile...");
      print("📝 Name: $nameToUpdate");
      print("🖼️ Image: ${pickedImage.value?.path}");

      final Map<String, dynamic> result = (await _repo.updateProfile(
        name: nameToUpdate,
        imagePath: pickedImage.value?.path,
      )) as Map<String, dynamic>;

      print("📥 Result: $result");

      if (result['success'] == true) {
        Get.snackbar(
          "Success",
          "Profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Refresh profile
        await fetchProfile();

        // Clear picked image and editing state
        pickedImage.value = null;
        isEditingName.value = false;
      } else {
        Get.snackbar(
          "Error",
          result['message']?.toString() ?? "Failed to update profile",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Save error: $e");
      Get.snackbar(
        "Error",
        "An error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.clearAll();
    Get.offAllNamed(RouteName.signinView);
  }
}