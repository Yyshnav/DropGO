import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropgo/app/constants/api_constants.dart';
import 'package:dropgo/app/constants/enpoints.dart';
import 'package:dropgo/app/models/Delivery_userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAuthApis {
  static final Dio _dio = ApiConstants.dio;

  /// ✅ Save token to SharedPreferences
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// ✅ Get token from SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// ✅ Login: Save token
  static Future<String?> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.deliveryLogin,
        data: {"username": username, "password": password},
      );

      print("Login Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        await _saveToken(token);
        return null; // success
      } else {
        return response.data['message'] ?? "Login failed";
      }
    } on DioException catch (e) {
      print("Login error: ${e.response?.data}");
      return e.response?.data['message'] ?? "Login failed";
    } catch (e) {
      print("Unexpected login error: $e");
      return "Something went wrong";
    }
  }

  /// ✅ Fetch Profile
  static Future<DeliveryUser?> fetchProfile() async {
    try {
      final token = await _getToken();
      print(token);

      if (token == null || token.isEmpty) {
        print("Token not found!");
        return null;
      }

      final response = await _dio.get(
        ApiEndpoints.profile,
        options: Options(headers: {'Authorization': 'token $token'}),
      );

      print("Profile Response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map) {
        return DeliveryUser.fromJson(response.data);
      }
    } on DioException catch (e) {
      print('Fetch profile error: ${e.response?.data}');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return null;
  }

  /// ✅ Update Profile
  static Future<String?> updateProfile({
  required String name,
  required String email,
  required String phone,
  File? imageFile, // ✅ optional image
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });

    final response = await _dio.put(
      ApiEndpoints.editprofile,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'token $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return null; // ✅ Success
    } else {
      return response.data['message'] ?? 'Update failed';
    }
  } on DioException catch (e) {
    return e.response?.data['message'] ?? 'Update failed';
  } catch (e) {
    return 'Something went wrong';
  }
}

  /// ✅ Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
