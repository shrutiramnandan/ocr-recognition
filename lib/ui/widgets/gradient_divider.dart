import 'package:flutter/material.dart';
import 'package:ocr/ui/configuration/configuration.dart';

class GradientDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: AppColors.linearGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(36),
          )),
    );
  }
}
