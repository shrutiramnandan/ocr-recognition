import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/number_keypad.dart';
import 'package:ocr/register/view/upload_doc_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationCodeForm extends StatelessWidget {
  TextEditingController _verificationCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: MyTheme.grey300,
      borderRadius: BorderRadius.circular(20.0),
    );
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(left: 25, right: 25.0, top: 50),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: MyTheme.white,
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Verification Code",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: MyTheme.textColor1),
            ),
            SizedBox(height: size.height * 0.03),
            PinPut(
              validator: (s) {
                if (s.contains('1')) return null;
                return 'NOT VALID';
              },
              useNativeKeyboard: false,
              withCursor: true,
              fieldsCount: 4,
              fieldsAlignment: MainAxisAlignment.spaceAround,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
              eachFieldMargin: EdgeInsets.all(0),
              eachFieldWidth: 55.0,
              eachFieldHeight: 65.0,
              onSubmit: (String pin) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UploadDocScreen()));
              },
              autofocus: true,
              controller: _verificationCodeController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration.copyWith(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: MyTheme.primaryColor,
                ),
              ),
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.scale,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Resend Code",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: MyTheme.textColor2),
            ),
            NumberKeypad(_verificationCodeController)
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  RoundedButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: MyTheme.white),
        alignment: Alignment.center,
        child: Text(
          '$title',
          style: TextStyle(fontSize: 35, color: MyTheme.black),
        ),
      ),
    );
  }
}
