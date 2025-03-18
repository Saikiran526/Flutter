import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSuccess extends StatefulWidget{
  // LoginSuccess();
  // get error => null;


  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  
  String? userName;


  
  void getDetails()async{
    var sharedPref= await SharedPreferences.getInstance();
    setState(() {
      userName=sharedPref.getString("name");
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    setState(() {

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Form'),backgroundColor: Colors.blue,),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(widget.error),
              // if (widget.error != null && widget.error!.isNotEmpty)
                // Text(widget.error!, style: TextStyle(fontSize: 20, color: Colors.red)),              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                  Text('Welcome',style: TextStyle(fontSize: 30,),),
                  Text('  $userName',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                // ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}