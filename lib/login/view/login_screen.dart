import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/logo.dart';
import 'package:ocr/login/view/pin_code_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          // SizedBox(height:40),
          Expanded(
            child:
                Align(alignment: Alignment.bottomCenter, child: InputEmail()),
          )
        ],
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20.0, top: 10),
      height: size.height * 0.4,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: MyTheme.textColor1),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextField(decoration: InputDecoration(hintText: "Email")),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedBorderTextButton(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PinCodeScreen()));
              },
              height: size.height * 0.06,
              width: size.width,
              title: "Validate",
              bgColor: MyTheme.buttonColor1,
              textColor: MyTheme.white,
              borderRadius: 10,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              width: size.width,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Need Support?",
                  style: TextStyle(fontSize: 15, color: MyTheme.textColor2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
