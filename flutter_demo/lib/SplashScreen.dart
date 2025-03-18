import 'package:flutter/material.dart';
import 'package:flutter_demo/IntroScreen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key,required this.userName});
  final String userName;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=>IntroScreen(uName: widget.userName)),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          // width: double.infinity,
          child: Text('Welcome..! \n ${widget.userName} ',style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}