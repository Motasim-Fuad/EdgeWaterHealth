import 'dart:convert';
import 'dart:io';
import 'package:edgewaterhealth/Services/StorageServices.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class NetworkService {
  static const String baseUrl = 'http://206.162.244.133:5000';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // GET Request
  static Future<ApiResponse> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print("🌐 GET: $uri");

      final response = await http.get(
        uri,
        headers: await _getHeaders(headers),
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      print("❌ GET Error: $e");
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // POST Request
  static Future<ApiResponse> post(String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print("🌐 POST: $uri");

      final response = await http.post(
        uri,
        headers: await _getHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      print("❌ POST Error: $e");
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // PUT Request
  static Future<ApiResponse> put(String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print("🌐 PUT: $uri");
      print("📦 Body: $body");

      final response = await http.put(
        uri,
        headers: await _getHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      print("❌ PUT Error: $e");
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  static Future<ApiResponse> uploadFile(
      String endpoint,
      String filePath, {
        Map<String, String>? fields,
        String fileFieldName = 'profileImage',
      }) async {
    try {
      print("🌐 Upload: $baseUrl$endpoint");
      print("📁 File: $filePath");
      print("📝 Fields: $fields");

      // Check file exists
      final file = File(filePath);
      if (!await file.exists()) {
        print("❌ File not found");
        return ApiResponse.error('File not found');
      }

      // Detect MIME type from file path
      final mimeType = lookupMimeType(filePath);
      print("🎭 Detected MIME type: $mimeType");

      if (mimeType == null || !mimeType.startsWith('image/')) {
        print("❌ Invalid MIME type");
        return ApiResponse.error('File is not a valid image');
      }

      final uri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('PUT', uri);

      // Add token
      final token = await StorageService.getToken();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
        print("🔐 Token added");
      }

      // Add file with explicit content type
      try {
        final multipartFile = await http.MultipartFile.fromPath(
          fileFieldName,
          filePath,
          contentType: MediaType.parse(mimeType), // Explicitly set content type
        );
        request.files.add(multipartFile);
        print("✅ File added (${multipartFile.length} bytes)");
        print("📎 Content-Type: ${multipartFile.contentType}");
      } catch (e) {
        print("❌ File read error: $e");
        return ApiResponse.error('Failed to read file');
      }

      // Add fields
      if (fields != null && fields.isNotEmpty) {
        request.fields.addAll(fields);
        print("✅ Fields added");
      }

      print("📤 Sending...");
      final streamedResponse = await request.send().timeout(timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("❌ Upload Error: $e");
      return ApiResponse.error('Upload error: ${e.toString()}');
    }
  }

  static Future<Map<String, String>> _getHeaders(Map<String, String>? customHeaders) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = await StorageService.getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  static ApiResponse _handleResponse(http.Response response) {
    try {
      print("📊 Status: ${response.statusCode}");

      final data = response.body.isNotEmpty ? json.decode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(
          data,
          statusCode: response.statusCode,
        );
      } else {
        final errorMessage = data?['message'] ?? 'Request failed: ${response.statusCode}';
        return ApiResponse.error(
          errorMessage,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      print("❌ Parse Error: $e");
      return ApiResponse.error('Parse error: ${e.toString()}');
    }
  }
}

// API Response Model
class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;
  final int? statusCode;

  ApiResponse.success(this.data, {this.message, this.statusCode})
      : success = true;

  ApiResponse.error(this.message, {this.statusCode})
      : success = false,
        data = null;
}