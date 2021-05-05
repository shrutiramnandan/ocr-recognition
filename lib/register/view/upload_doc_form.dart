import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/register/view/scan_cpr_screen.dart';

class UploadDocForm extends StatelessWidget {
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
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_upward,
                          size: size.height * 0.2,
                          color: MyTheme.buttonColor1,
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Upload your document",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: MyTheme.textColor1),
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
                        final firstCamera = cameras.first;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScanCPRscreen(
                                  camera: firstCamera,
                                )));
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
