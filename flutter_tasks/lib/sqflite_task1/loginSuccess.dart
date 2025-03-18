import 'package:flutter/material.dart';

class LoginSuccess extends StatefulWidget{
  final String user;
  const LoginSuccess(this.user, {Key? key}) : super(key: key);
 


  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Status'),backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${widget.user} !',style: TextStyle(fontSize: 25),),
            Text('Your loged in Successfully',style: TextStyle(color: Colors.green),),
          ],
        ),
      ),
    );
  }
}