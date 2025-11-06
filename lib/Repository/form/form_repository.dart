import 'package:edgewaterhealth/Data/nework_services.dart';
import 'package:edgewaterhealth/Model/submit_form_model/CrisisCallModel.dart';
import 'package:edgewaterhealth/Model/submit_form_model/CrisisStabilizationModel.dart';
import 'package:edgewaterhealth/Model/submit_form_model/MobileCrisisModel.dart';

class ApiService {
  static const String baseUrl = 'https://katheleen-unerrant-consolingly.ngrok-free.dev';

  // Crisis Calls API
  static Future<ApiResponse> submitCrisisCall(CrisisCallModel data) async {
    return await NetworkService.post(
      '/api/crisis_calls/create',
      body: data.toJson(),
    );
  }

  // Mobile Crisis API
  static Future<ApiResponse> submitMobileCrisis(MobileCrisisModel data) async {
    return await NetworkService.post(
      '/api/mobile_crisis/create',
      body: data.toJson(),
    );
  }

  // Crisis Stabilization API
  static Future<ApiResponse> submitCrisisStabilization(CrisisStabilizationModel data) async {
    return await NetworkService.post(
      '/api/crisis_stabilization_unit/create',
      body: data.toJson(),
    );
  }
}