// import 'package:edgewaterhealth/ViewModel/profile_view_model/profile_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProfileView extends StatelessWidget {
//   final ProfileViewModel controller = Get.put(ProfileViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Profile"), centerTitle: true),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final profile = controller.profile.value;
//         if (profile == null) {
//           return const Center(child: Text("No profile data"));
//         }
//
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   Obx(() {
//                     if (controller.pickedImage.value != null) {
//                       return CircleAvatar(
//                         radius: 50,
//                         backgroundImage: FileImage(controller.pickedImage.value!),
//                       );
//                     } else if (profile.profileImage != null) {
//                       return CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(profile.profileImage!),
//                       );
//                     } else {
//                       return const CircleAvatar(
//                         radius: 50,
//                         child: Icon(Icons.person, size: 50),
//                       );
//                     }
//                   }),
//                   IconButton(
//                     icon: const Icon(Icons.camera_alt, color: Colors.blue),
//                     onPressed: controller.pickImage,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               Card(
//                 margin: const EdgeInsets.all(16),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       _buildField("User ID", profile.userId),
//                       _buildField("Full name", profile.fullName),
//                       _buildField("Email", profile.email),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red.shade100,
//                   foregroundColor: Colors.red,
//                 ),
//                 onPressed: controller.logout,
//                 icon: const Icon(Icons.logout),
//                 label: const Text("Logout"),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(12),
//           margin: const EdgeInsets.only(bottom: 10),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(value),
//         ),
//       ],
//     );
//   }
// }








///--------with out api---------///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/profile_view_model/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel controller = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
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
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 50),
                      );
                    }
                  }),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: controller.pickImage,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildField("User ID", profile.userId),
                      _buildField("Full Name", profile.fullName),
                      _buildField("Email", profile.email),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  foregroundColor: Colors.red,
                ),
                onPressed: controller.logout,
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
