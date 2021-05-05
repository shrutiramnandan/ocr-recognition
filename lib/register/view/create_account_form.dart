import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/register/view/enter_phone_number_screen.dart';

class CreateAccountForm extends StatelessWidget {
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create account",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: MyTheme.textColor1),
          ),
          SizedBox(height: size.height * 0.03),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(decoration: InputDecoration(hintText: "Full Name")),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Country",
                        suffixIcon: Icon(Icons.arrow_drop_down))),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "City")),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Address")),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
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
                            builder: (context) => EnterPhoneNumberScreen()));
                      },
                      height: size.height * 0.06,
                      width: size.width,
                      title: "Next",
                      bgColor: MyTheme.buttonColor1,
                      textColor: MyTheme.white,
                      borderRadius: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
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
