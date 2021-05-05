import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/register/view/scan_cpr_form.dart';

class ScanCPRscreen extends StatelessWidget {
  final CameraDescription camera;

  const ScanCPRscreen({Key key, this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyTheme.teal50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyTheme.teal50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, color: MyTheme.textColor1)),
          centerTitle: true,
          title: Text("4/4",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: MyTheme.textColor1)),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.001,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.contain)),
              ),
            )
          ],
        ),
        body: ScanCPRform(
          camera: camera,
        ));
  }
}
