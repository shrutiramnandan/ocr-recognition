import 'package:flutter/material.dart';
import 'package:ocr/global/theme/colors.dart';

class RoundedBorderTextButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final double height;
  final double width;
  final Color textColor;
  final Color bgColor;
  final double  fontSize;
  final double borderRadius;

  const RoundedBorderTextButton({Key key, 
  this.title, this.onTap, this.height,
   this.width, this.textColor, this.bgColor, this.fontSize, this.borderRadius}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height:height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color:MyTheme.buttonColor1 ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor
        ),
        child: Text(title,
        style: TextStyle(
          fontSize:  fontSize ,
          // fontWeight: FontWeight.bold,
          color:textColor),
        )
      ),
    );
  }
}








class CircularButton extends StatelessWidget {
  final void Function() onTap;
  final double buttonRadius ;
  final Color buttonBgColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;


  const CircularButton({Key key, 
  this.onTap, this.buttonRadius, 
  this.buttonBgColor,
   this.icon, this.iconColor, this.iconSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        alignment: Alignment.center,
        height: buttonRadius,
        width: buttonRadius,
        decoration: BoxDecoration(
          color: buttonBgColor,
          shape: BoxShape.circle,

        ),
        child: Icon(
          icon,
          size: iconSize,
         color: iconColor,),


        
      ),
    );
  }
}