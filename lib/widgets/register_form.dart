// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:login_api/api/authentication.dart';
import 'package:login_api/data/aunthentication_client.dart';
import 'package:login_api/helpers/http_response.dart';
import 'package:login_api/pages/home_page.dart';
import 'package:login_api/utils/dialogs.dart';
import 'package:login_api/utils/responsive.dart';
import 'package:login_api/widgets/input_text.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthenticationClient _authenticationClient = GetIt.instance<AuthenticationClient>();
  final aunthenticationAPI = GetIt.instance<AunthenticationAPI>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _passWord = '', _userName = '';

  final Logger _logger = Logger();
Future<void>      _submit() async {
    final bool isOk = _formKey.currentState!.validate();
    print("form isOk: $isOk");
    if(isOk){
      ProgressDialog.show(context);

      final HttpResponse response = await aunthenticationAPI.register(
        username: _userName,
        email: _email,
        password: _passWord
      );
      ProgressDialog.dismiss(context);
      print(":::::::::: $response.data");
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data);
        _logger.i('register ok:::: ${response.data}');
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      }
      else {
        String message = response.error!.message;
        if(response.error!.statusCode == -1){
          message = 'Bad Network';
        }
        else if (response.error!.statusCode == 409){
          message = 'Duplicated User ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }
        Dialogs.alert(
          context,
          title: 'ERROR',
          description: message
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet?430:360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              InputText(
                label: 'USER NAME',
                fontSize: responsive.dp(responsive.isTablet? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text){
                    print('::::: USERNAME : $text');
                    _userName = text;
                },
                validator: (text) {
                  if(text!.trim().length < 5 ){
                    return 'invalid username';
                  }
                  return null;
                },
              ),
              // ignore: avoid_unnecessary_containers
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'EMAIL ADDRESS',
                fontSize: responsive.dp(responsive.isTablet? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text){
                    print('::::: EMAIL : $text');
                    _email = text;
                },
                validator: (text) {
                  if(text?.trim().isEmpty ?? true){
                    return 'invalid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'PASSWORD',
                fontSize: responsive.dp(responsive.isTablet? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                isPassword: true,
                onChanged: (text){
                    print('::::: PASSWORD : $text');
                    _passWord = text;
                },
                validator: (text) {
                  if(text!.trim().length < 6){
                    return 'invalid password';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: _submit,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: Colors.pinkAccent,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5)
                    ),
                  )
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: responsive.dp(1.5),
                  )
                ),
                MaterialButton(
                  onPressed:() {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.pinkAccent),
                  )
                )
              ],
            ),
            SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}