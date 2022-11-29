import 'package:flutter/material.dart';
import 'package:WhetherTravel/screens/welcome.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        seconds: 8,
        navigateAfterSeconds:Welcome(),
        title: Text(
          'SplashScreen Example',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[200],
      )
    );
  }
}