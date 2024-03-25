import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_api/models/aunthentication_response.dart';
import 'package:login_api/models/session.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;

  AuthenticationClient(this._secureStorage);

  Future<String?> get accessToken async {
    final data = await _secureStorage.read(key: 'SESSION');
    if(data != null) {
     final session = Session.fromJson(jsonDecode(data));
     return session.token;
    }
    return null;
  }

  Future<void> saveSession(
      AunthenticationResponse authenticationResponse) async {
    final Session session = Session(
        token: authenticationResponse.token,
        expiresIn: authenticationResponse.expiresIn,
        createdAt: DateTime.now());

    final data = jsonEncode(session.toJson());
    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}