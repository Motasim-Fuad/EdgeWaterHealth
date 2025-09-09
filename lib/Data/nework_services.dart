import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  static const String baseUrl = 'https://your-api-base-url.com/api';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // GET Request
  static Future<ApiResponse> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(
        uri,
        headers: _getHeaders(headers),
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
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
      final response = await http.post(
        uri,
        headers: _getHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
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
      final response = await http.put(
        uri,
        headers: _getHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // DELETE Request
  static Future<ApiResponse> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(
        uri,
        headers: _getHeaders(headers),
      ).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  static Map<String, String> _getHeaders(Map<String, String>? customHeaders) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  static ApiResponse _handleResponse(http.Response response) {
    try {
      final data = response.body.isNotEmpty ? json.decode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(data);
      } else {
        final errorMessage = data?['message'] ?? 'Request failed with status: ${response.statusCode}';
        return ApiResponse.error(errorMessage, statusCode: response.statusCode);
      }
    } catch (e) {
      return ApiResponse.error('Failed to parse response: ${e.toString()}');
    }
  }
}

// API Response Model
class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;
  final int? statusCode;

  ApiResponse.success(this.data, {this.message})
      : success = true, statusCode = null;

  ApiResponse.error(this.message, {this.statusCode})
      : success = false, data = null;
}
