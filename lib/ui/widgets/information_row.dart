import 'package:flutter/material.dart';
import 'package:ocr/ui/configuration/configuration.dart';
import 'package:ocr/ui/widgets/app_text.dart';
import 'package:ocr/ui/widgets/gradient_divider.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    this.title,
    this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppMargins.small, AppMargins.small, AppMargins.small, AppMargins.xxSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextWidget(
                title,
                style: AppStyles.mediumTextStyle,
                minFontSize: AppFontSizes.verySmallFontSize,
              ),
              child,
            ],
          ),
        ),
        GradientDivider(),
      ],
    );
  }
}
