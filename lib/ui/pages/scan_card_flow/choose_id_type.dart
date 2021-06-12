import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/ui/configuration/configuration.dart';
import 'package:ocr/ui/pages/scan_card_flow/scan_card_page.dart';
import 'package:ocr/ui/widgets/gradient_button.dart';
import 'package:ocr/ui/widgets/page_title.dart';
import 'package:ocr/ui/widgets/progress_dots.dart';

class ChooseIdTypePage extends StatefulWidget {
  @override
  _ChooseIdTypePageState createState() => _ChooseIdTypePageState();
}

class _ChooseIdTypePageState extends State<ChooseIdTypePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    //_getCurrentPage(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.transparent,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            buildPageTitle(title: 'Document Scan'),
            SizedBox(height: 30),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.greyBackgroundUi,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppRadius.radiusCircular),
                          topRight: Radius.circular(AppRadius.radiusCircular),
                        )),
                  ),
                  _buildChooseIdTypePage(width, height, context),
                  Positioned(
                    width: width,
                    bottom: 50,
                    child: ProgressDot(
                      isCurrentIndex: true,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChooseIdTypePage(
    double width,
    double height,
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size; //YNE06052021
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargins.xxxLarge),
      child: Column(
        children: [
          SizedBox(height: AppMargins.xxxLarge),
          Container(
            width: width,
            height: height * 0.3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radiusCircular),
                )),
            child: Lottie.asset('assets/scan_card.json'),
          ),
          SizedBox(height: 2 * AppMargins.medium),
          /* Start YNE06052021
          GradientButton(
              text: "ID card",
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanCardPage(),
                    ));
              }), */

          RoundedBorderTextButton(
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScanCardPage()));
            },
            height: size.height * 0.06,
            width: size.width,
            title: "ID card",
            bgColor: MyTheme.buttonColor1,
            textColor: MyTheme.white,
            borderRadius: 10,
          ),
          SizedBox(height: 2 * AppMargins.medium),
          // End YNE06052021
          /*
          GradientButton(
              text: "Passport",
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanCardPage(),
                    ));
              }),
              */ //Start YNE06052021
          RoundedBorderTextButton(
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScanCardPage()));
            },
            height: size.height * 0.06,
            width: size.width,
            title: "Passport",
            bgColor: MyTheme.white,
            textColor: MyTheme.buttonColor1,
            borderRadius: 10,
          ),
          //End YNE06052021
        ],
      ),
    );
  }
}
