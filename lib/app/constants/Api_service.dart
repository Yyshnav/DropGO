import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropgo/app/constants/api_constants.dart';
import 'package:dropgo/app/constants/enpoints.dart';
import 'package:dropgo/app/models/Delivery_userProfile.dart';
import 'package:dropgo/app/models/all_orders_model.dart';
import 'package:dropgo/app/models/chat_model.dart';
import 'package:dropgo/app/models/delivery_order_model.dart';
import 'package:dropgo/app/models/order_datail_model.dart';
import 'package:dropgo/app/models/order_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class DeliveryAuthApis {
  // static final Dio _dio = ApiConstants.dio;
  Dio get _dio => ApiConstants.dio;
  String token = '';

  /// ✅ Save token to SharedPreferences
  static Future<void> _saveToken(String token, refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refresh', refreshToken);
  }

  /// ✅ Get token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// ✅ Login: Save token
   Future<String?> login({
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
        final token1 = response.data['token'];
        token = token1;
        final refreshToken = response.data['refresh'];
        print(token);
        print(refreshToken);
        await _saveToken(token, refreshToken);
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

//   static Future<bool> refreshAccessToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   final refreshToken = prefs.getString('refresh');

//   if (refreshToken == null) return false;

//   try {
//     final response = await _dio.post(
//       ApiEndpoints.refreshToken, 
//       data: {"refresh": refreshToken},
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final newAccessToken = response.data['token'];
//       await prefs.setString('token', newAccessToken);
//       return true;
//     }
//   } catch (e) {
//     print("Token refresh failed: $e");
//   }

//   return false;
// }

static Future<bool> refreshAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh');

  if (refreshToken == null) {
    print("❌ No refresh token found");
    return false;
  }

  try {
    final response = await ApiConstants.dio.post(
      ApiEndpoints.refreshToken,
      data: {"refresh": refreshToken},
    );

    print("🔁 Refresh token response: ${response.data}");

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        response.data['access'] != null) {
      final newAccessToken = response.data['access']; // ✅ use 'token' instead of 'access'
      await prefs.setString('token', newAccessToken);
      print("Token refreshed and saved");
      return true;
    } else {
      print("Invalid token refresh response");
    }
  } catch (e) {
    print("Token refresh failed: $e");
  }

  return false;
}


void setupInterceptors() {
  _dio.interceptors.clear();

  _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (DioException error, ErrorInterceptorHandler handler) async {
  final requestOptions = error.requestOptions;

  // Check if error is 401 and not already retried
  if (error.response?.statusCode == 401 &&
      requestOptions.extra['retried'] != true) {
    final success = await refreshAccessToken();

    if (success) {
      final prefs =await SharedPreferences.getInstance();
      final newToken = prefs.getString('token');

      // Mark as retried
      final options = Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
        extra: {'retried': true},
      );

      try {
        final cloneReq = await _dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );

        return handler.resolve(cloneReq);
      } catch (e) {
        return handler.reject(e as DioException);
      }
    }
  }

  return handler.next(error);
}

  ));
}



  /// ✅ Fetch Profile
  static Future<DeliveryUser?> fetchProfile() async {
    try {
      final token = await getToken();
      print(token);

      if (token == null || token.isEmpty) {
        print("Token not found!");
        return null;
      }

      final response = await ApiConstants.dio.get(
        ApiEndpoints.profile,
        // options: Options(headers: {'Authorization': 'Bearer $token'}),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("Profile Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201 && response.data is Map) {
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

    final response = await ApiConstants.dio.put(
      ApiEndpoints.editprofile,
      data: formData,
      // options: Options(
      //   headers: {
          // 'Authorization': 'Bearer $token',
          // 'Content-Type': 'multipart/form-data',
      //   },
      // ),
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
    await prefs.remove('refresh');
  }
  final List orders=[];

  Future<DeliveryOrder?> getOrderDetails(String orderId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("❌ No token found");
      return null;
    }
    final response = await _dio.get(
      ApiEndpoints.latestorders,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    log(response.data.toString());

    final List data = response.data;
    final matchingOrder = data.firstWhere(
      (order) => order['id'].toString() == orderId,
      orElse: () => null,
    );

    if (matchingOrder != null) {
      return DeliveryOrder.fromJson(matchingOrder);
    }

    log("⚠️ Order ID $orderId not found");
    return null;
  } catch (e) {
    log("❌ Error fetching order details: $e");
    return null;
  }
}

Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        print('❌ No token found when fetching orders.');
        return [];
      }

      final response = await _dio.get(
        ApiEndpoints.latestorders,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log('📦 Orders response======>>>>>: ${response.data}');
      if (response.statusCode == 200 && response.data is List) {
        final list = response.data as List;
        return list.map((e) => OrderModel.fromJson(e as Map<String, dynamic>)).toList();
      }

      print('⚠️ Unexpected orders response: ${response.statusCode} ${response.data}');
      return [];
    } catch (e) {
      print('❌ Error fetching orders: $e');
      return [];
    }
  }

   Future<OrderDetailModel> orderDetails(String orderId) async {
    final response = await _dio.get('${ApiEndpoints.orderDetails}/$orderId/');
    log('=============>>>>>>>${response.data}');
    if (response.statusCode == 200) {
      return OrderDetailModel.fromJson(response.data);
    } else {
      throw Exception("Failed to load order");
    }
  }

  Future<void> updateOrderStatus(String orderId, String status,{
  bool paymentDone = false,
  String? paymentType,
}) async {
    await _dio.post("${ApiEndpoints.orderStatus}/$orderId/", data: {
      "order_id" : orderId,
      "status": status,
      "payment_done": paymentDone,
      "payment_type": paymentType ?? "",
      });
  }

  Future<List<OrderHistoryItem>> fetchOrderHistory() async {
    try {
      final response = await _dio.get(ApiEndpoints.orderHistory);
      print(response.data);

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => OrderHistoryItem.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load order history");
      }
    } catch (e) {
      throw Exception("Error fetching order history: $e");
    }
  }

Future<List<MessageModel>> fetchHistory(String orderId) async {
    try {
      if (orderId.isEmpty) throw Exception('Order ID is empty');
      final response = await _dio.get('${ApiEndpoints.orderchat}/$orderId/');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching chat history: $e');
      rethrow;
    }
  }

  Future<MessageModel?> sendText(
    String orderId, {
    required String message,
    required SenderType senderType,
  }) async {
    try {
      if (orderId.isEmpty || message.trim().isEmpty) {
        throw Exception('Order ID or message is empty');
      }
      final response = await _dio.post(
        '${ApiEndpoints.orderchat}/$orderId/',
        data: {
          'text': message.trim(),
          'sender_type': senderTypeToString(senderType),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MessageModel.fromJson(response.data);
      } else {
        throw Exception('Failed to send text: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error sending text: $e');
      return null;
    }
  }

  Future<MessageModel?> sendMedia(
    String orderId, {
    required File file,
    required SenderType senderType,
    required MediaType mediaType,
  }) async {
    try {
      if (orderId.isEmpty || !await file.exists()) {
        throw Exception('Order ID is empty or file does not exist');
      }
      final formData = FormData.fromMap({
        'file_url': await MultipartFile.fromFile(file.path),
        'sender_type': senderTypeToString(senderType),
        'message_type': mediaTypeToString(mediaType),
      });

      final response = await _dio.post(
        '${ApiEndpoints.orderchat}/$orderId/',
        data: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MessageModel.fromJson(response.data);
      } else {
        throw Exception('Failed to send media: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error sending media: $e');
      return null;
    }
  }

  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.changePassword,
        data: {
          'old_password': currentPassword,
          'new_password': confirmPassword,
          // 'confirm_password': confirmPassword,
        },
        // options: Options(headers: {
        //   'Authorization': 'Bearer YOUR_TOKEN', // replace with your auth logic
        // }),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    final response = await _dio.post(
      ApiEndpoints.forgotPassword,
      data: {'email': email},
    );
    print("Password reset response: ${response.data}");

    if (response.statusCode != 200) {
      throw Exception("Failed to send reset link");
    }
  }

  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      print("OTP Verification Response: ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('OTP verification failed: $e');
      return false;
    }
  }

  Future<bool> resendOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('OTP resend failed: $e');
      return false;
    }
  }

  Future<bool> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.setnewpassword,
        data: {
          'email': email,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Password update failed');
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to update password: ${e.toString()}");
    }
  }

   Future<Response> submitFeedback(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(ApiEndpoints.submitDeliveryFeedback, data: payload);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to submit feedback: ${response.statusMessage}',
        );
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}



