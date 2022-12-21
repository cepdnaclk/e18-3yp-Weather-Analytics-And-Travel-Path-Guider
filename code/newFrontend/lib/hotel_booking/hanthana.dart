// import 'dart:io'; // New begin
// import 'package:best_flutter_ui_templates/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// //import 'navigation_home_screen.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:best_flutter_ui_templates/delayed_animation.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:best_flutter_ui_templates/googleLogin.dart';
// import 'package:best_flutter_ui_templates/home_screen.dart';
// import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';
import '../api/routes.dart';
import '../api/responseModels.dart';

void hanthana() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Hanthana Mountain Range';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({super.key});

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  String temp = "Loading";
  String humidity = "Loading";
  String rain = "Loading";
  String airQuality = "Loading";
  String lightIntensity = "Loading";

  void refreshData(String location) async {
    LatestUpdateResponse response = await getLatestUpdateOfLocation(location);
    print(response.lightIntensity);
    setState(() {
      temp = response.temperature;
      humidity = response.humidity;
      rain = response.isRaining;
      lightIntensity = response.lightIntensity;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshData("hanthana");
    });
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        // Row
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/weather3.gif',
              height: 250.0,
              width: 250.0,
            ),
            Expanded(
              child: Text('Date\n2022-12-21\n\nTime\n10.40am',
                  textAlign: TextAlign.center),
            )
            // ),
            // Expanded(
            //   child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
            // ),
          ],
        ),
        //////////
        CustomListItemTwo(
          thumbnail: Image.asset('assets/images/temperature.png'),
          title: 'TEMPERATURE',
          subtitle: temp,
          author: '',
          publishDate: '',
          readDuration: '',
        ),
        CustomListItemTwo(
          thumbnail: Image.asset('assets/images/humidity.png'),
          title: 'HUMIDITY',
          subtitle: humidity,
          author: '',
          publishDate: '',
          readDuration: '',
        ),
        CustomListItemTwo(
          thumbnail: Image.asset('assets/images/rain.png'),
          title: 'RAIN',
          subtitle: rain,
          author: '',
          publishDate: '',
          readDuration: '',
        ),
        CustomListItemTwo(
          thumbnail: Image.asset('assets/images/air.png'),
          title: 'AIR QUALITY',
          subtitle: '74',
          author: '',
          publishDate: '',
          readDuration: '',
        ),
        CustomListItemTwo(
          thumbnail: Image.asset('assets/images/light.png'),
          title: 'LIGHT INTENSITY',
          subtitle: lightIntensity,
          author: '',
          publishDate: '',
          readDuration: '',
        ),
      ],
    );
  }
}






// // Image
// String imagePath = "";

// void hanthana() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown
//   ]).then((_) => runApp(MyApp()));

//   // Image
//   String imagePath = "";
//   int rain = 0;
//   if (rain == 0) {
//     imagePath = 'assets/images/cloudy.png';
//   }
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
//           backgroundColor: Color.fromARGB(255, 129, 226, 161),
//           body: Center(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 90.0,
//                 ),
//                 AvatarGlow(
//                   endRadius: 300,
//                   duration: Duration(seconds: 1),
//                   glowColor: Colors.white24,
//                   repeat: true,
//                   repeatPauseDuration: Duration(seconds: 1),
//                   startDelay: Duration(seconds: 1),
//                   // child: Material(
//                   //     elevation: 8.0,
//                   //     shape: CircleBorder(),
//                   //     child: CircleAvatar(
//                   //       backgroundColor: Colors.grey[100],
//                   //       child: Image.asset('assets/images/cloudy.png'),
//                   //       radius: 90.0,
//                   //     )),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
                    
//                     children: [
//                       SizedBox(),
//                       Builder(builder: ((context) {
//                         int rain = 0;
//                         if (rain == 0 || rain == 1) {
//                           return Image.asset('assets/images/night_cloudy.png');
//                         } else if (rain == 100) {
//                           return Image.asset('assets/images/cloudy.png');
//                         } else if (rain == 200) {
//                           return Image.asset('assets/images/mixed.png');
//                         } else {
//                           return Image.asset('assets/images/sunny.png');
//                         }
//                       })),
//                       SizedBox(
//                   height: 90.0,
//                 ),
//                 SizedBox(),
//                 Text('Temperature :')
//                       // SizedBox(
//                       //   height: 200,
//                       //   child: Text(
//                       //     'tempMax'.toString() +
//                       //         'degree' +
//                       //         ' / ' +
//                       //         'tempMin'.toString() +
//                       //         'degree',
//                       //     style: const TextStyle(
//                       //       color: Colors.white,
//                       //       fontSize: 17,
//                       //       //fontWeight: FontWeight.w300,
//                       //     ),
//                       //     // minFontSize: 14,
//                       //     // stepGranularity: 2,
//                       //     maxLines: 2,
//                       //     overflow: TextOverflow.ellipsis,
//                       //   ),
//                       // ),
//                       // Container(
//                       //   margin: const EdgeInsets.only(top: 2),
//                       //   width: 5,
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       const Text(
//                       //         'Feels Like: ',
//                       //         style: TextStyle(
//                       //           color: Colors.white,
//                       //           fontSize: 16,
//                       //           //fontWeight: FontWeight.w500,
//                       //         ),
//                       //         // minFontSize: 14,
//                       //         // stepGranularity: 2,
//                       //         maxLines: 2,
//                       //         overflow: TextOverflow.ellipsis,
//                       //       ),
//                             // Text(
//                             //   "feelsLike".toString() +
//                             //       "tepm = 25" +
//                             //       ' C',
//                             //   style: const TextStyle(
//                             //     color: Colors.white,
//                             //     fontSize: 17,
//                             //     fontWeight: FontWeight.w600,
//                             //   ),
//                             //   // minFontSize: 14,
//                             //   // stepGranularity: 2,
//                             //   maxLines: 2,
//                             //   overflow: TextOverflow.ellipsis,
//                             // ),
//                       //     ],
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "WhetherTravel",
//                 //     style: TextStyle(
//                 //         fontWeight: FontWeight.bold,
//                 //         fontSize: 25.0,
//                 //         color: color),
//                 //   ),
//                 //   delay: delayedAmount + 1000,
//                 // ),
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
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "Weather Analytics and Travel Path Guider",
//                 //     style: TextStyle(fontSize: 15.0, color: color),
//                 //   ),
//                 //   delay: delayedAmount + 3000,
//                 // ),
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "",
//                 //     style: TextStyle(fontSize: 15.0, color: color),
//                 //   ),
//                 //   delay: delayedAmount + 3000,
//                 // ),
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "",
//                 //     style: TextStyle(fontSize: 15.0, color: color),
//                 //   ),
//                 //   delay: delayedAmount + 3000,
//                 // ),
//                 // SizedBox(
//                 //   height: 100.0,
//                 // // ),
//                 // DelayedAnimation(
//                 //   child: GestureDetector(
//                 //     onTapDown: _onTapDown,
//                 //     onTapUp: _onTapUp,
//                 //     child: Transform.scale(
//                 //       scale: _scale,
//                 //       child: _animatedButtonUI,

//                       // child: TextButton(
//                       //                     style: ButtonStyle(
//                       //                       overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                       //                         (Set<MaterialState> states) {
//                       //                           if (states.contains(MaterialState.focused))
//                       //                             return Colors.red;
//                       //                           return null; // Defer to the widget's default.
//                       //                         }
//                       //                       ),
//                       //                     ),
//                       //                     onPressed: () { },
//                       //                     child: Text(
//                       //                               'LOGIN WITH GOOGLE',
//                       //                               style: TextStyle(
//                       //                                 fontSize: 20.0,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                                 color: Color.fromARGB(255, 255, 255, 255),

//                       //                               ),
//                       //                             ),
//                       //                   )
//                 //     ),
//                 //   ),
//                 //   delay: delayedAmount + 4000,
//                 // ),
//                 // SizedBox(
//                 //   height: 50.0,
//                 // ),
//                 // DelayedAnimation(
//                 //   child: Text(
//                 //     "For TEsting".toUpperCase(),
//                 //     style: TextStyle(
//                 //         fontSize: 20.0,
//                 //         fontWeight: FontWeight.bold,
//                 //         color: color),
//                 //   ),
//                 //   delay: delayedAmount + 5000,
//                 // ),

//                 // Container(
//                 //   height: 60,
//                 //   width: 270,
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(100.0),
//                 //     color: Colors.white,
//                 //   ),
//                 //   child: Center(
//                 //       child: TextButton(
//                 //     style: ButtonStyle(
//                 //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                 //           (Set<MaterialState> states) {
//                 //         if (states.contains(MaterialState.focused))
//                 //           return Colors.red;
//                 //         return null; // Defer to the widget's default.
//                 //       }),
//                 //     ),
//                 //     onPressed: homeScreen,
//                 //     child: Text(
//                 //       'GO TO APP',
//                 //       style: TextStyle(
//                 //         fontSize: 20.0,
//                 //         fontWeight: FontWeight.bold,
//                 //         color: Color(0xFF8185E2),
//                 //       ),
//                 //     ),
//                 //   )),
//                 // )
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

//   // Widget get _animatedButtonUI => Container(
//   //       height: 60,
//   //       width: 270,
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(100.0),
//   //         color: Colors.white,
//   //       ),
//   //       child: Center(
//   //           child: TextButton(
//   //         style: ButtonStyle(
//   //           overlayColor: MaterialStateProperty.resolveWith<Color?>(
//   //               (Set<MaterialState> states) {
//   //             if (states.contains(MaterialState.focused)) return Colors.red;
//   //             return null; // Defer to the widget's default.
//   //           }),
//   //         ),
//   //         onPressed: googleLogin,
//   //         child: Text(
//   //           'LOGIN WITH GOOGLE',
//   //           style: TextStyle(
//   //             fontSize: 20.0,
//   //             fontWeight: FontWeight.bold,
//   //             color: Color(0xFF8185E2),
//   //           ),
//   //         ),
//   //       )),
//   //     );

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
