import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapapi/screen/home/view/home_screen.dart';
import 'package:mapapi/screen/splash/view.dart';

void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(p0) => SplashScreen(),
        'home':(p0) => HomeScreen(),
      },
    )
  );
}