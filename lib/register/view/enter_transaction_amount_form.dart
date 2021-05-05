import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/global/widgets/number_keypad.dart';
import 'package:ocr/transaction/view/transaction_screen.dart';

class EnterTransactionAmountForm extends StatelessWidget {
  TextEditingController _amountController = TextEditingController();
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
                "Transaction Amount",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: MyTheme.textColor1),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child:
                        Icon(Icons.arrow_drop_down, color: MyTheme.textColor1),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Expanded(
                    child: TextField(
                        showCursor: true,
                        // autofocus: true,
                        style: TextStyle(fontSize: 25),
                        controller: _amountController,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintText: "Amount", border: InputBorder.none)),
                  ),
                ],
              ),
              Divider(
                height: 0,
                thickness: 2,
              ),
              NumberKeypad(_amountController),
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
                            builder: (context) => TransactionScreen()));
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
                    RoundedBorderTextButton(
                      onTap: () {},
                      height: size.height * 0.06,
                      width: size.width,
                      title: "Cancel",
                      bgColor: MyTheme.white,
                      textColor: MyTheme.buttonColor1,
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
