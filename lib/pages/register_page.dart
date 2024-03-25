import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_api/utils/responsive.dart';
import 'package:login_api/widgets/avatar_button.dart';
import 'package:login_api/widgets/circle.dart';
import 'package:login_api/widgets/icon_container.dart';
import 'package:login_api/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
  final Responsive responsive = Responsive.of(context);
  final double pinkSize = responsive.wp(88);
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
                  top: -(pinkSize) * 0.22,
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
                  top: -(orangeSize) * 0.35,
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
                  top: pinkSize * 0.17,
                  child: Column(
                    children: <Widget> [

                     Text(
                      "Hello! \n Sign up to get started.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.dp(1.6),
                        color: Colors.white
                      ),
                    ),
                    SizedBox(
                      height: responsive.dp(4.5),
                    ),
                    AvatarButton(imageSize: responsive.wp(25))


                    ],
                  )
                ),
                const RegisterForm(),
                Positioned(
                  left: 15,
                  top: 15,
                  child: SafeArea(
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(30),
                      child: const Icon (Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}