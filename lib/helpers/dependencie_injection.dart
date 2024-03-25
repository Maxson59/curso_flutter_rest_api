


import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:login_api/api/account.dart';
import 'package:login_api/api/authentication.dart';
import 'package:login_api/data/aunthentication_client.dart';
import 'package:login_api/helpers/http.dart';

abstract class DepedencyInjection {
  static void initialized (){
    final Dio dio = Dio(BaseOptions(baseUrl: 'http://192.168.100.83:9000'));
    final Logger logger = Logger();
    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true
    );
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final AunthenticationAPI aunthenticationAPI = AunthenticationAPI(http: http);
    final AuthenticationClient aunthenticationClient = AuthenticationClient(secureStorage);
    final AccountAPI accountAPI = AccountAPI(http, aunthenticationClient);

    GetIt.instance.registerSingleton<AunthenticationAPI>(aunthenticationAPI);
    GetIt.instance.registerSingleton<AuthenticationClient>(aunthenticationClient);
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
  }
}