import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/profile/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel?> fetchProfile() async {
    final response = await NetworkService.get("/profile");
    if (response.success) {
      return ProfileModel.fromJson(response.data);
    }
    return null;
  }

  Future<bool> updateProfilePicture(String filePath) async {
    // Replace with your real upload API endpoint
    final response = await NetworkService.post("/profile/upload", body: {
      "file": filePath, // for now just send path, later use multipart
    });

    return response.success;
  }
}
