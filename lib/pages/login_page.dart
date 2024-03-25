import 'package:flutter/material.dart';
import 'package:login_api/utils/responsive.dart';
import 'package:login_api/widgets/circle.dart';
import 'package:login_api/widgets/icon_container.dart';
import 'package:login_api/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
  final Responsive responsive = Responsive.of(context);
  final double pinkSize = responsive.wp(80);
  final double orangeSize = responsive.wp(57);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget> [
                Positioned(
                  top: -(pinkSize) * 0.5,
                  right: -(pinkSize) * 0.2,
                  child: Circle(
                    size: pinkSize,
                    colors: const [
                      Colors.pinkAccent,
                      Colors.pink
                    ],
                  )
                  ),
                Positioned(
                  top: -(orangeSize) * 0.55,
                  left: -(orangeSize) * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: const [
                      Colors.deepOrange,
                      Colors.orangeAccent
                    ],
                  )
                  ),
                Positioned(
                  top: pinkSize * 0.35,
                  child: Column(
                    children: <Widget> [
                      IconContainer(size: responsive.wp(17)),
                       SizedBox(
                        height:  responsive.dp(3),
                    ),
                     Text(
                      "Hello Again \n Welcome Back!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                    ],
                  )
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}