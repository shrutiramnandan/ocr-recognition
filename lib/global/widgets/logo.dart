import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        image:DecorationImage(
            image:  AssetImage("assets/images/logo.png")
          )
      ),
      
    );
  }
}