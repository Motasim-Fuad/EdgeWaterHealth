// import 'dart:io';
// import 'package:edgewaterhealth/Model/profile/profile_model.dart' show ProfileModel;
// import 'package:edgewaterhealth/Repository/profile/profile_repository.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
//
// class ProfileViewModel extends GetxController {
//   final ProfileRepository _repo = ProfileRepository();
//
//   var profile = Rxn<ProfileModel>();
//   var isLoading = false.obs;
//   var pickedImage = Rxn<File>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProfile();
//   }
//
//   Future<void> fetchProfile() async {
//     try {
//       isLoading.value = true;
//       final data = await _repo.fetchProfile();
//       if (data != null) {
//         profile.value = data;
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       pickedImage.value = File(pickedFile.path);
//
//       // Call upload API
//       final success = await _repo.updateProfilePicture(pickedFile.path);
//       if (success) {
//         Get.snackbar("Success", "Profile image updated!");
//       } else {
//         Get.snackbar("Error", "Failed to update image");
//       }
//     }
//   }
//
//   void logout() {
//     // Clear user session
//     Get.offAllNamed("/login");
//   }
// }







///--------with out api------///



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModel {
  final String userId;
  final String fullName;
  final String email;
  final String? profileImage;

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profileImage,
  });
}

class ProfileViewModel extends GetxController {
  var isLoading = false.obs;
  var profile = Rxn<ProfileModel>();
  var pickedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadDummyProfile();
  }

  // 🧠 Dummy data loader instead of API
  void loadDummyProfile() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // simulate loading
    profile.value = ProfileModel(
      userId: "U123456",
      fullName: "John Doe",
      email: "john.doe@example.com",
      profileImage:
      "https://cdn-icons-png.flaticon.com/512/149/149071.png", // sample image
    );
    isLoading.value = false;
  }

  // 📷 Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  // 🚪 Logout action
  void logout() {
    Get.snackbar("Logout", "You have been logged out successfully",
        snackPosition: SnackPosition.BOTTOM);
  }
}
