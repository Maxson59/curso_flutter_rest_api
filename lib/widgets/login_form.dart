import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:login_api/api/authentication.dart';
import 'package:login_api/data/aunthentication_client.dart';
import 'package:login_api/pages/home_page.dart';
import 'package:login_api/utils/dialogs.dart';
import 'package:login_api/utils/responsive.dart';
import 'package:login_api/widgets/input_text.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _aunthenticationAPI = GetIt.instance<AunthenticationAPI>();
  final AuthenticationClient _authenticationClient = GetIt.instance<AuthenticationClient>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';
Future<void> _submit() async{
    final bool isOk = _formKey.currentState!.validate();
    print("form isOk: $isOk");
    if(isOk){
    ProgressDialog.show(context);
    final response =  await _aunthenticationAPI.login(email: _email, password: _password);
    // ignore: use_build_context_synchronously
    ProgressDialog.dismiss(context);
    if(response.data != null){
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          HomePage.routeName,
          (_) => false,
        );
    } else {
        String message = response.error!.message;
        if(response.error!.statusCode == -1){

          message = 'Bad Network';
        }
        else if (response.error!.statusCode == 403){
          message = 'Invalid Password';
        }
        else if (response.error!.statusCode == 404) {
          message = 'User Not Found';
        }
        Dialogs.alert(
          // ignore: use_build_context_synchronously
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
              // ignore: avoid_unnecessary_containers
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Colors.black12
                  ))
                ),
                child: Row(
                  children: <Widget> [
                    Expanded(
                      child: InputText(
                      label: 'PASSWORD',
                      isPassword: true,
                      fontSize: responsive.dp(responsive.isTablet? 1.2 : 1.4),
                      borderEnabled: false,
                      onChanged: (text){
                        print('::::: PASSWORD : $text');
                        _password = text;
                      },
                      validator: (text) {
                        if(text!.trim().isEmpty){
                          return "Invalid Password";
                        }
                        return null;
                      },
                    ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {},
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(responsive.isTablet? 1.2 : 1.5)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: _submit,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: Colors.pinkAccent,
                  child: Text(
                    'Sign In',
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
                  'New to Friendly Desi?',
                  style: TextStyle(
                    fontSize: responsive.dp(1.5),
                  )
                ),
                MaterialButton(
                  onPressed:() {
                    Navigator.pushNamed(context, 'register');
                  },

                  child: const Text(
                    'Sign Up',
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