import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:login_api/api/account.dart';
import 'package:login_api/data/aunthentication_client.dart';
import 'package:login_api/models/user.dart';
import 'package:login_api/pages/login_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AccountAPI _accountApi = GetIt.instance<AccountAPI>();
  final AuthenticationClient _authenticationClient = GetIt.instance<AuthenticationClient>();
  User? _user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loadUser();
    });
  }

  Future<void> loadUser () async{
    final response = await _accountApi.getUserInfo();
    if(response.data != null){
      _user = response.data!;
      setState(() {});
    }
  }

    Future<void> _signOut () async{
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: unnecessary_null_comparison
            if(_user == null) const CircularProgressIndicator(),
            // ignore: unnecessary_null_comparison
            if(_user != null)
              Column(
                children: [
                  Text(_user!.id),
                  Text(_user!.username),
                  Text(_user!.email),
                  Text(_user!.createdAt.toIso8601String())
                ]
              ),

            ElevatedButton(
                onPressed: _signOut,
                child: const Text("Sign out")),
          ]
        ),
      ),
    );
  }
}