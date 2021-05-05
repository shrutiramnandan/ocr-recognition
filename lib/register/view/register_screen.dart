import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/logo.dart';
import 'package:ocr/register/view/create_account_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      padding: const EdgeInsets.only(left: 25, right: 25.0, top: 30),
      height: size.height * 0.5,
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
            TextField(decoration: InputDecoration(hintText: "Email")),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Password")),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedBorderTextButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateAccountScreen()));
              },
              height: size.height * 0.06,
              width: size.width,
              title: "Create Account",
              bgColor: MyTheme.buttonColor1,
              textColor: MyTheme.white,
              borderRadius: 10,
            ),
            SizedBox(
              height: size.height * 0.13,
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
