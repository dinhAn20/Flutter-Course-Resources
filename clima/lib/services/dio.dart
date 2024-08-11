import 'package:dio/dio.dart';

const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/';
const apiKey = 'api_key';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: openWeatherMapUrl,
    headers: {'Accept': 'application/json'},
    queryParameters: {'appid': apiKey, 'units': 'metric'},
    connectTimeout: const Duration(minutes: 3),
    receiveTimeout: const Duration(minutes: 3),
  ));

  static Dio get instance {
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
    return _dio;
  }

  static Future<Response> get(String uri,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(uri, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  // Các method khác như post, put, delete...
}
