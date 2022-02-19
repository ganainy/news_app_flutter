import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getDataByCategory({
    String path = 'v2/top-headlines',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  static Future<Response> getDataBySearch({
    String path = 'v2/everything',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }
}
