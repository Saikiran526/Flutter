import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage(title: 'Home'),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message,size: 100,),
            SizedBox(height: 21,),
          ],
        )
      ),
    );
  }
}
