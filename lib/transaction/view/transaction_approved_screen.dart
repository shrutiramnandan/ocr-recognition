import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';

class TransactionApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyTheme.teal50,
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.only(left: 25, right: 25.0, top: 5),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: MyTheme.white,
        ),
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onVerticalDragDown: (onVerticalDragDown) {
                      print(
                          "onVerticalDragDown.globalPosition; :${onVerticalDragDown.globalPosition}");
                      print(
                          "onVerticalDragDown.localPosition; :${onVerticalDragDown.localPosition}");
                    },
                    child: Container(
                      height: size.height * 0.01,
                      width: size.width * 0.13,
                      decoration: BoxDecoration(
                          color: MyTheme.grey400,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/icons/transactionApproved.png", //assets/icons/transactionApproved.png
                            // height: size.height * 0.1,
                            // width:  size.width ,
                            fit: BoxFit.cover,
                          ))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            RoundedBorderTextButton(
                              onTap: () {},
                              height: size.height * 0.06,
                              width: size.width,
                              title: "Print reciept",
                              bgColor: MyTheme.buttonColor1,
                              textColor: MyTheme.white,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            RoundedBorderTextButton(
                              onTap: () {},
                              height: size.height * 0.06,
                              width: size.width,
                              title: "Finish",
                              bgColor: MyTheme.white,
                              textColor: MyTheme.buttonColor1,
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: size.height * 0.03,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.contain)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
