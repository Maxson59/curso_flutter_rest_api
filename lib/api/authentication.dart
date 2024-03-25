import 'package:login_api/helpers/http.dart';
import 'package:login_api/helpers/http_response.dart';
import 'package:login_api/models/aunthentication_response.dart';

class AunthenticationAPI{

  final Http _http;
  AunthenticationAPI({required Http http}) : _http = http;

  Future<HttpResponse<AunthenticationResponse>> register({
    required String username,
    required String email,
    required String password
  }) {

    return _http.request<AunthenticationResponse>(
      '/api/v1/register',
      method: 'POST',
      data: {
        'username': username,
        'email': email,
        'password': password
      },
      parser: (data) {
        return AunthenticationResponse.fromJson(data);
      }
    );
    }
  Future<HttpResponse<AunthenticationResponse>> login ({
    required String email,
    required String password
  })
    {
      return _http.request<AunthenticationResponse>(
      '/api/v1/login',
      method: 'POST',
      data: {
        'email': email,
        'password': password
        },
      parser: (data) {
        return AunthenticationResponse.fromJson(data);
      }
      );
    }
}



