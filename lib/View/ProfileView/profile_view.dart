import 'package:edgewaterhealth/ViewModel/profile_view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel controller = Get.put(ProfileViewModel());

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          Obx(() {
            if (controller.isEditingName.value || controller.pickedImage.value != null) {
              return IconButton(
                icon: controller.isSaving.value
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.check),
                onPressed: controller.isSaving.value
                    ? null
                    : controller.saveProfile,
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: Text("No profile data"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Image Section
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(() {
                    if (controller.pickedImage.value != null) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(controller.pickedImage.value!),
                      );
                    } else if (profile.profileImage != null) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profile.profileImage!),
                        backgroundColor: Colors.grey.shade300,
                      );
                    } else {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.person, size: 50),
                      );
                    }
                  }),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        onPressed: controller.pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile Details Card
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // User ID (read-only)
                      _buildReadOnlyField("User ID", profile.userId),

                      // Full Name (editable)
                      _buildEditableField(
                        "Full Name",
                        controller.editedName.value,
                        controller.isEditingName.value,
                        onEdit: controller.toggleEditName,
                        onChanged: (value) => controller.editedName.value = value,
                      ),

                      // Email (read-only)
                      _buildReadOnlyField("Email", profile.email),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text("Logout"),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                controller.logout();
                              },
                              child: const Text("Logout", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildEditableField(
      String label,
      String value,
      bool isEditing, {
        required VoidCallback onEdit,
        required Function(String) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.close : Icons.edit, size: 20),
              onPressed: onEdit,
            ),
          ],
        ),
        const SizedBox(height: 8),
        isEditing
            ? TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        )
            : Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}