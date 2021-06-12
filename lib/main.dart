import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr/core/services/blink_id_service.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:provider/provider.dart';
import 'splash/view/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlinkIdService()),
      ],
      child: MyApp(),
    ),
  );
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
        theme: theme,
        home: SplashScreen());
  }
}
