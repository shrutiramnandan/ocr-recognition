import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/number_keypad.dart';
import 'package:ocr/register/view/verification_code_screen.dart';

class EnterPhoneNumberForm extends StatelessWidget {
  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode = "+973";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 25, right: 25.0, top: 30),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: MyTheme.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            children: [
              Text(
                "Phone Number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: MyTheme.textColor1),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      countryCode,
                      style: TextStyle(fontSize: 22, color: MyTheme.textColor1),
                    ),
                    SizedBox(width: size.width * 0.1),
                    Expanded(
                      child: TextField(
                          showCursor: true,
                          // autofocus: true,
                          style: TextStyle(fontSize: 25),
                          controller: _phoneNumberController,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              hintText: "Number", border: InputBorder.none)),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 2,
              ),
              NumberKeypad(_phoneNumberController),
              SizedBox(height: size.height * 0.03),
            ],
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    RoundedBorderTextButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerificationCodeScreen()));
                      },
                      height: size.height * 0.06,
                      width: size.width,
                      title: "Verify",
                      bgColor: MyTheme.buttonColor1,
                      textColor: MyTheme.white,
                      borderRadius: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: size.width,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Need Support?",
                          style: TextStyle(
                              fontSize: 15, color: MyTheme.textColor2),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
