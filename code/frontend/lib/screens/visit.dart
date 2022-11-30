import 'package:flutter/material.dart';
import 'package:WhetherTravel/screens/welcome.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:to_app/ui/size_config.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:WhetherTravel/detail_page.dart';
import 'package:WhetherTravel/widgets/category_boxes.dart';
import 'package:WhetherTravel/icons.dart';
import 'package:WhetherTravel/widgets/discover_card.dart';
import 'package:WhetherTravel/widgets/discover_small_card.dart';
import 'package:WhetherTravel/widgets/svg_asset.dart';


class Visit extends StatelessWidget {
  const Visit({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ScreenConfig.init();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whether Travel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child : Text("Whether Travel"),
          ) ,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget> [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body : Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/hanthana1.jpg',
                  height: 300,
                  width: 300,
                  //scale: 2.5,
                  // color: Color.fromARGB(255, 15, 147, 59),
                  // opacity:
                  // const AlwaysStoppedAnimation<double>(0.5)
              ), //Image.asset
              Image.asset(
                'assets/meemure1.jpg',
                height: 300,
                width: 300,
              ), // Image.asset
            ], //<Widget>[]
          ), //Column
        ),

      ),
    );
  }
}


