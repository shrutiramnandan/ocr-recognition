import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/register/view/scan_face_screen.dart';

class PersonalInfoForm extends StatelessWidget {
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
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: MyTheme.grey)),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "Personal infomations",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: MyTheme.textColor1),
                              ),
                              SizedBox(height: size.height * 0.07),
                              ListTile(
                                leading: Image.asset(
                                  "assets/icons/user.png",
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  "Name Surname",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: MyTheme.black),
                                ),
                                subtitle: Text(
                                  "Personal Number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: MyTheme.black),
                                ),
                              ),
                              SizedBox(height: size.height * 0.07),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nationality",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: MyTheme.black),
                                    ),
                                    Text(
                                      "Bahraini",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: MyTheme.black),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                endIndent: 20,
                                indent: 20,
                                color: MyTheme.buttonColor1,
                              ),
                              SizedBox(height: size.height * 0.04),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Expiration Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: MyTheme.black),
                                    ),
                                    Text(
                                      "02/12/2015",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: MyTheme.black),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                endIndent: 20,
                                indent: 20,
                                color: MyTheme.buttonColor1,
                              ),
                            ],
                          ))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            text: 'By continuing you agree to bank\'s ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Terms\n',
                                  style: new TextStyle(
                                      color: MyTheme.buttonColor1)),
                              new TextSpan(
                                  text: 'and Contditions ',
                                  style: new TextStyle(
                                      color: MyTheme.buttonColor1)),
                              new TextSpan(
                                text: 'and ',
                              ),
                              new TextSpan(
                                  text: 'Privacy Policy',
                                  style: new TextStyle(
                                      color: MyTheme.buttonColor1)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    RoundedBorderTextButton(
                      onTap: () async {
                        final cameras = await availableCameras();

                        // Get a specific camera from the list of available cameras.
                        final firstCamera = cameras.first;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScanFaceScreen(
                                  camera: firstCamera,
                                )));
                      },
                      height: size.height * 0.06,
                      width: size.width,
                      title: "Validate",
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
