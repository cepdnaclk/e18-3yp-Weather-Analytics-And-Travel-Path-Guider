// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}

// import 'dart:io'; // New begin
// import 'package:best_flutter_ui_templates/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'navigation_home_screen.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:best_flutter_ui_templates/delayed_animation.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown
//   ]).then((_) => runApp(MyApp()));
// }

// // ###################################################

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }



// class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//   final int delayedAmount = 500;
//   late double _scale;
//   late AnimationController _controller;
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(
//         milliseconds: 200,
//       ),
//       lowerBound: 0.0,
//       upperBound: 0.1,
//     )..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
// //       statusBarColor: Colors.transparent,
// //       statusBarIconBrightness: Brightness.dark,
// //       statusBarBrightness:
// //           !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
// //       systemNavigationBarColor: Colors.white,
// //       systemNavigationBarDividerColor: Colors.transparent,
// //       systemNavigationBarIconBrightness: Brightness.dark,
// //     ));
// //     return MaterialApp(
// //       title: 'Flutter UI',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         textTheme: AppTheme.textTheme,
// //         platform: TargetPlatform.iOS,
// //       ),
// //       //home: NavigationHomeScreen(),
// //     );
// //   }
// // }


// // ############################################################
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness:
//           !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarDividerColor: Colors.transparent,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));
//     final color = Colors.white;
//     _scale = 1 - _controller.value;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           backgroundColor: Color(0xFF8185E2),
//           body: Center(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 90.0,
//                 ),
//                 AvatarGlow(
//                   endRadius: 100,
//                   duration: Duration(seconds: 1),
//                   glowColor: Colors.white24,
//                   repeat: true,
//                   repeatPauseDuration: Duration(seconds: 1),
//                   startDelay: Duration(seconds: 1),
//                   child: Material(
//                       elevation: 8.0,
//                       shape: CircleBorder(),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.grey[100],
//                         child: Image.asset('assets/images/logo_big.png'),
//                         radius: 90.0,
//                       )),
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "WhetherTravel",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25.0,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 1000,
//                 ),
//                 //  SizedBox(
//                 //   height: 30.0,
//                 // ),
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "",
//                 //     style: TextStyle(
//                 //         fontWeight: FontWeight.bold,
//                 //         fontSize: 35.0,
//                 //         color: color),
//                 //   ),
//                 //   delay: delayedAmount + 2000,
//                 // ),
//                 // SizedBox(
//                 //   height: 30.0,
//                 // ),
//                 DelayedAnimation(
//                   child: Text(
//                     "Weather Analytics and Travel Path Guider",
//                     style: TextStyle(fontSize: 15.0, color: color),
//                   ),
//                   delay: delayedAmount + 3000,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "",
//                     style: TextStyle(fontSize: 15.0, color: color),
//                   ),
//                   delay: delayedAmount + 3000,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "",
//                     style: TextStyle(fontSize: 15.0, color: color),
//                   ),
//                   delay: delayedAmount + 3000,
//                 ),
//                 SizedBox(
//                   height: 100.0,
//                 ),
//                 DelayedAnimation(
//                   child: GestureDetector(
//                     onTapDown: _onTapDown,
//                     onTapUp: _onTapUp,
//                     child: Transform.scale(
//                       scale: _scale,
//                       child: _animatedButtonUI,
//                     ),
//                   ),
//                   delay: delayedAmount + 4000,
//                 ),
//                 SizedBox(
//                   height: 50.0,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "Visit Website".toUpperCase(),
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 5000,
//                 ),
//               ],
//             ),
//           )
//           //  Column(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: <Widget>[
//           //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
//           //     SizedBox(
//           //       height: 20.0,
//           //     ),
//           //      Center(

//           //   ),
//           //   ],

//           // ),
//           ),
//     );
//   }

//   Widget get _animatedButtonUI => Container(
//         height: 60,
//         width: 270,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.0),
//           color: Colors.white,
//         ),
        
//         child: Center(
//           child: Text(
//             'LOGIN WITH GOOGLE',
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF8185E2),
//             ),
//           ),
//         ),
//       );

//   void _onTapDown(TapDownDetails details) {
//     _controller.forward();
//   }

//   void _onTapUp(TapUpDetails details) {
//     _controller.reverse();
//   }
// }
// //#########################################################################

// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }
