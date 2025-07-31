// lib/constants/api_constants.dart
import 'package:dio/dio.dart';
import 'package:dropgo/app/constants/token_interceptor.dart';

// class ApiConstants {
//   static const String baseUrl = 'http://192.168.1.61:5000';

//   static final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: baseUrl,
//       connectTimeout: Duration(seconds: 10),
//       receiveTimeout: Duration(seconds: 10),
//       headers: {'Content-Type': 'application/json'},
//     ),
//   )..interceptors.add(TokenInterceptor(dio));
  
// }n 

class ApiConstants {
  static const String baseUrl = 'http://192.168.1.57:5000';
  static final Dio dio = _createDio();

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(TokenInterceptor(dio));
    return dio;
  }
}


