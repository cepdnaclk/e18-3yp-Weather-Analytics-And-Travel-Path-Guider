// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:WhetherTravel/screens/homeScreen.dart';
import 'package:WhetherTravel/screens/signUpScreen.dart';
import 'package:device_preview/device_preview.dart';

// screens
import 'screens/loginScreen.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap your app
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Welcome to WhetherTravel',
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
