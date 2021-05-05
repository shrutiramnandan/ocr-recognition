import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/logo.dart';
import 'package:ocr/login/view/login_screen.dart';
import 'package:ocr/register/view/register_screen.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  var _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyTheme.teal50,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Logo(),
          Expanded(
            child:
                Align(alignment: Alignment.bottomCenter, child: LoginSignUp()),
          )
        ],
      ),
    );
  }
}

class LoginSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20.0, top: 10),
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: MyTheme.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedBorderTextButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              height: size.height * 0.06,
              width: size.width,
              title: "Create Account",
              bgColor: MyTheme.buttonColor1,
              textColor: MyTheme.white,
              borderRadius: 10,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedBorderTextButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              height: size.height * 0.06,
              width: size.width,
              title: "Sign In",
              bgColor: MyTheme.white,
              textColor: MyTheme.buttonColor1,
              borderRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
