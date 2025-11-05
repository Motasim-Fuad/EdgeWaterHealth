
import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/Profile/profile_model.dart';
import 'package:edgewaterhealth/Model/Authentication/user_model.dart';
import 'package:edgewaterhealth/Services/StorageServices.dart';

class ProfileRepository {
  // Fetch profile from storage
  Future<ProfileModel?> fetchProfile() async {
    try {
      final user = await StorageService.getUser();
      if (user != null) {
        return ProfileModel(
          userId: user.id ?? '',
          fullName: user.name ?? '',
          email: user.email ?? '',
          profileImage: user.profileImage,
          status: user.status,
        );
      }
      return null;
    } catch (e) {
      print("Error fetching profile: $e");
      return null;
    }
  }

  // Update profile (name & image)
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? imagePath,
  }) async {
    try {
      print("🔄 Starting profile update...");
      print("📝 Name: $name");
      print("🖼️ Image path: $imagePath");

      dynamic response;

      if (imagePath != null) {
        // Upload with image
        print("📤 Uploading image...");

        Map<String, String>? fields;
        if (name != null && name.isNotEmpty) {
          fields = {'name': name};
        }

        response = await NetworkService.uploadFile(
          "/api/users/update/profile",
          imagePath,
          fields: fields,
        );
      } else if (name != null && name.isNotEmpty) {
        // Update only name
        print("📝 Updating name only...");
        response = await NetworkService.put(
          "/api/users/update/profile",
          body: {'name': name},
        );
      } else {
        print("❌ No data to update");
        return {
          'success': false,
          'message': 'No data provided for update',
        };
      }

      print("📥 Response success: ${response.success}");
      print("📦 Response data: ${response.data}");

      if (response.success) {
        await _updateLocalStorage(response.data);
        return {
          'success': true,
          'message': 'Profile updated successfully',
          'data': response.data,
        };
      } else {
        print("❌ API Error: ${response.message}");
        return {
          'success': false,
          'message': response.message ?? 'Failed to update profile',
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  // Update local storage
  Future<void> _updateLocalStorage(dynamic responseData) async {
    try {
      print("💾 Updating local storage...");

      if (responseData == null) {
        print("⚠️ Response data is null");
        return;
      }

      Map<String, dynamic>? userData;

      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('user')) {
          userData = responseData['user'] as Map<String, dynamic>?;
        } else if (responseData.containsKey('data')) {
          final data = responseData['data'];
          if (data is Map<String, dynamic> && data.containsKey('user')) {
            userData = data['user'] as Map<String, dynamic>?;
          } else {
            userData = data as Map<String, dynamic>?;
          }
        } else {
          userData = responseData;
        }
      }

      if (userData != null) {
        print("✅ User data found");

        final existingUser = await StorageService.getUser();

        final updatedUser = User(
          id: userData['_id'] ?? userData['id'] ?? existingUser?.id,
          name: userData['name'] ?? existingUser?.name,
          email: userData['email'] ?? existingUser?.email,
          profileImage: userData['profileImage'] ?? existingUser?.profileImage,
          status: userData['status'] ?? existingUser?.status,
        );

        await StorageService.saveUser(updatedUser);
        print("✅ Storage updated");
      }
    } catch (e) {
      print("❌ Storage update error: $e");
    }
  }
}