import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    String path = 'v2/top-headlines',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }
}
