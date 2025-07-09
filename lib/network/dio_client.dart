
import 'package:dio/dio.dart';

import '../config/endpoints/endpoints.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.options.headers = {
      'Accept': 'application/json',
    };
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);

    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Something went wrong');
    }
  }
}
