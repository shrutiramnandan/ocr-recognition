
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr/global/theme/colors.dart';
import 'splash/view/splash_screen.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
final theme = ThemeData(
  textTheme: GoogleFonts.interTextTheme(),

  primaryColor: MyTheme.primaryColor,
  
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:theme,
      home: SplashScreen()
     
    );
  }
}


