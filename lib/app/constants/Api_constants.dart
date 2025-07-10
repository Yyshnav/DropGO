// lib/constants/api_constants.dart
import 'package:dio/dio.dart';

class ApiConstants {
  static const String baseUrl = 'http://192.168.1.40:5000';

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
