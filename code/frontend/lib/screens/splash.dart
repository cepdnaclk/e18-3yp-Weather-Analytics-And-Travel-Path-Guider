import 'package:flutter/material.dart';
import 'package:WhetherTravel/screens/welcome.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whether Travel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds:Welcome(),
        image: new Image.asset('logo_big.png'),
        photoSize: 100.0,
        backgroundColor: Colors.blue,
        styleTextUnderTheLoader: new TextStyle(),
        loaderColor: Colors.white,

        title: Text(
          'Welcome to WhetherTravel',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.white),
        ),

      )
        // image: Image.asset("logo_big.png"),
        // backgroundColor: Colors.lightBlue[200],
      // )
        
  
    );
  }
}