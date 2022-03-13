import 'package:dio/dio.dart';
import 'package:lavaloon/domain_layer/end_points.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
       'Authorization': 'Bearer $token',
       'Content-Type': 'application/json'
    };
    return await dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required dynamic data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
    url,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    return await dio.post(
      path,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
  //    'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}