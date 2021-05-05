import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/login/view/pin_code_form.dart';

class PinCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyTheme.teal50,
        body: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.2,
                  width: size.width * 0.8,
                ),
              ),
              Expanded(child: PinCodeForm())
            ],
          ),
        )
        //

        );
  }
}
