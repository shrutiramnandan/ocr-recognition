import 'dart:convert';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:ocr/core/models/scan_result.dart';
import 'package:ocr/core/services/blink_id_service.dart';
import 'package:ocr/ui/configuration/configuration.dart';
import 'package:ocr/ui/pages/scan_card_flow/verify_photo_page.dart';
import 'package:ocr/ui/widgets/app_text.dart';
import 'package:ocr/ui/widgets/gradient_button.dart';
import 'package:ocr/ui/widgets/information_row.dart';
import 'package:ocr/ui/widgets/page_title.dart';
import 'package:ocr/ui/widgets/progress_dots.dart';
import 'package:provider/provider.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({
    this.cameraDescription,
  });

  final CameraDescription cameraDescription;
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

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
              buildPageTitle(title: 'About me'),
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
                    _buildAboutMePage(width, height, context),
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
        ));
  }

  Widget _buildAboutMePage(double width, double height, BuildContext context) {
    final _blinkIdService = Provider.of<BlinkIdService>(context);
    final scanResult = _blinkIdService.scanResult;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargins.xxxLarge),
      child: Column(
        children: [
          SizedBox(height: AppMargins.xxxLarge),
          Row(
            children: [
              _buildFaceImage(_blinkIdService),
              SizedBox(width: AppMargins.xxLarge),
              _buildNameAndDocumentNumber(scanResult),
            ],
          ),
          SizedBox(height: AppMargins.xxxLarge),
          InformationRow(
            title: 'Nationality',
            child: Container(
              width: 120,
              height: 50,
              child: TextFormField(
                initialValue:
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.nationality,
                onChanged: (value) {
                  setState(() {
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.nationality =
                        value;
                    print(
                        Provider.of<BlinkIdService>(context, listen: false).scanResult.nationality);
                  });
                },
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Hint here"),
              ),
            ),
          ),
          SizedBox(height: AppMargins.xxxLarge),
          InformationRow(
            title: 'Expiration Date',
            child: Container(
              width: 120,
              height: 50,
              child: TextFormField(
                initialValue:
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.dateOfExpiry,
                onChanged: (value) {
                  setState(() {
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.dateOfExpiry =
                        value;
                    print(Provider.of<BlinkIdService>(context, listen: false)
                        .scanResult
                        .dateOfExpiry);
                  });
                },
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Hint here"),
              ),
            ),
          ),
          SizedBox(height: 70),
          _buildPrivacyPolicy(),
          SizedBox(height: 2 * AppMargins.medium),
          GradientButton(
            text: 'Next',
            onPressed: () {
              Provider.of<BlinkIdService>(context, listen: false).scanResult = scanResult;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => VerifyPhotoPage(
                    cameraDescription: widget.cameraDescription,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    final primaryStyle = AppStyles.regularTextStyle
        .copyWith(color: AppColors.blackUi, fontSize: AppFontSizes.verySmallFontSize);
    final secondaryStyle = primaryStyle.copyWith(color: AppColors.greenLightUi);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppMargins.xxxSmall),
      child: RichText(
        text: TextSpan(
          text: 'By continuing you agree to Bank’s  and Privacy Policy ',
          style: primaryStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'Terms and Conditions ',
              style: secondaryStyle,
            ),
            TextSpan(
              text: 'and ',
              style: primaryStyle,
            ),
            TextSpan(text: 'Privacy Policy ', style: secondaryStyle),
          ],
        ),
      ),
    );
  }

  getFullName(ScanResult scanResult) {
    return scanResult.fullName != null && scanResult.fullName != ""
        ? '${scanResult.fullName}'
        : scanResult.firstName != null && scanResult.lastName != null
            ? '${scanResult.firstName} ${scanResult.lastName}'
            : 'N/A';
  }

  Column _buildNameAndDocumentNumber(ScanResult scanResult) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 200,
              height: 50,
              child: TextFormField(
                initialValue: getFullName(scanResult),
                onChanged: (value) {
                  setState(() {
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.fullName = value;
                    print(Provider.of<BlinkIdService>(context, listen: false).scanResult.fullName);
                  });
                },
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Hint here"),
              ),
            ),
          ],
        ),
        Container(
          width: 200,
          height: 50,
          child: TextFormField(
            initialValue:
                scanResult.documentNumber != null ? "${scanResult.documentNumber}" : 'N/A',
            onChanged: (value) {
              setState(() {
                Provider.of<BlinkIdService>(context, listen: false).scanResult.documentNumber =
                    value;
                print(
                    Provider.of<BlinkIdService>(context, listen: false).scanResult.documentNumber);
              });
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Hint here"),
          ),
        ),
      ],
    );
  }

  // Container _buildTextFormField(initialvalue, textValue, {double width}) {
  //   return Container(
  //     width: width ?? 200,
  //     height: 50,
  //     child: TextFormField(
  //       initialValue: initialvalue,
  //       onChanged: (value) {
  //         textValue = value;
  //         print(textValue);
  //       },
  //       decoration: new InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //           hintText: "Hint here"),
  //     ),
  //   );
  // }

  Widget _buildFaceImage(BlinkIdService _blinkIdService) {
    return getImage(_blinkIdService) != null
        ? Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getImage(_blinkIdService),
              ),
            ),
          )
        : Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: AppTextWidget(
              "No image",
              style: TextStyle(color: Colors.black),
            ));
  }

  getImage(BlinkIdService _blinkIdService) {
    return _blinkIdService.faceImageBase64 != null
        ? MemoryImage(
            base64Decode(
              _blinkIdService.faceImageBase64,
            ),
          )
        : _blinkIdService.fullDocumentFrontImageBase64 != null
            ? MemoryImage(
                base64Decode(
                  _blinkIdService.fullDocumentFrontImageBase64,
                ),
              )
            : null;
  }
}
