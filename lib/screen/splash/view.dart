import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 350,),
              Image.asset('assets/images/logopng.png',height: 150,color: Colors.grey.shade800,),
              Expanded(child: SizedBox()),
              Text("Map",style: TextStyle(color: Colors.grey.shade800,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(height: 30,width: 30,child: CircularProgressIndicator(color: Colors.grey.shade800)),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
