

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:login_api/helpers/http_response.dart';

class Http{
  late Dio _dio;
  late Logger _logger;
  late bool _logsEnabled;

  Http({
    required Dio dio,
    required Logger logger,
    required bool logsEnabled
  }) {
    _dio = dio;
    _logger = logger;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse <T>> request <T>(
      String path,
      {
      String method = 'GET',
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? formData,
      Map<String, String>? headers,
      T Function(dynamic data)? parser,
      }) async {
    try{
      final Response response = await _dio.post(
      path,
      options: Options(method: method, headers: headers),
      queryParameters: queryParameters,
      data: formData != null ? FormData.fromMap(formData) : data,

    );
    _logger.i(response.data);
    if(parser != null) {
      return HttpResponse.success<T>(parser(response.data));
    }
    return HttpResponse.success<T>(response.data);
    }
    catch(e){
      int? statusCode = 0;
      String? message = "unknown error";
      dynamic data;

      _logger.e(e);
      if(e is DioException){
        statusCode = -1;
        message = e.message;
        if(e.response!= null){
          statusCode = e.response!.statusCode;
          message = e.response!.statusMessage;
          data = e.response!.data;

        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data
      );
    }
  }

}