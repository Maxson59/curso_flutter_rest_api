


import 'package:logger/logger.dart';
import 'package:login_api/data/aunthentication_client.dart';
import 'package:login_api/helpers/http.dart';
import 'package:login_api/helpers/http_response.dart';
import 'package:login_api/models/user.dart';

class AccountAPI {
  final Http _http;
  final AuthenticationClient _authenticationClient;
  final Logger logger = Logger();

  AccountAPI(this._http, this._authenticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;

    if (token != null) {
      return _http.request<User>(
        '/api/v1/user-info',
        method: "GET",
        headers: {
          "token": token,
        },
        parser: (data) {
          return User.fromJson(data);
        },
      );
    } else {
      return HttpResponse.fail<User>(
          statusCode: -1, message: "No se pudo obtener el token de sesión", data: null);
    }
  }
}