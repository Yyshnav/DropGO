import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropgo/app/constants/api_constants.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  String? _refreshToken;
  String? _accessToken;
  bool _isRefreshing = false;
  List<Future<void> Function()> _retryQueue = [];

  TokenInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('token'); // use consistent key
    if (_accessToken != null) {
      options.headers['Authorization'] = 'Bearer $_accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();

    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      _refreshToken = prefs.getString('refresh');

      try {
        final response = await _dio.post(
          '${ApiConstants.baseUrl}/auth/token/refresh/',
          data: {'refresh': _refreshToken},
        );

        final newToken = response.data['access'];
        await prefs.setString('token', newToken);
        _accessToken = newToken;

        _isRefreshing = false;

        for (var callback in _retryQueue) {
          await callback();
        }
        _retryQueue.clear();

        final clonedRequest = err.requestOptions;
        clonedRequest.headers['Authorization'] = 'Bearer $newToken';
        final newResponse = await _dio.fetch(clonedRequest);
        return handler.resolve(newResponse);
      } catch (e) {
        _isRefreshing = false;
        return handler.reject(err);
      }
    } else if (err.response?.statusCode == 401 && _isRefreshing) {
      _retryQueue.add(() async {
        final clonedRequest = err.requestOptions;
        clonedRequest.headers['Authorization'] = 'Bearer $_accessToken';
        final newResponse = await _dio.fetch(clonedRequest);
        handler.resolve(newResponse);
      });
    } else {
      return handler.next(err);
    }
  }
}
