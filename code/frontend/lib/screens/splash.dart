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
        seconds: 4,
        navigateAfterSeconds:Welcome(),
        title: Text(
          'Welcome to WhetherTravel',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white),
        ),
        image: Image.asset("/logo.png",
          scale : 0.2),
        backgroundColor: Colors.lightBlue[200],
      )
  
    );
  }
}