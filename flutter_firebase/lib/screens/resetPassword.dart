import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/screens/auth.dart';

class ResetPassowrd extends StatefulWidget{
  @override
  State<ResetPassowrd> createState() => _ResetPassowrdState();
}

class _ResetPassowrdState extends State<ResetPassowrd> {

  ///Controllers
    TextEditingController emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'),backgroundColor: Colors.blue,),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Reset Password with Email',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
              SizedBox(height: 11,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Enter your email",
                ),
              ),
              SizedBox(height: 11,),
              ElevatedButton(
                  onPressed: (){
                    try{
                      firebase.sendPasswordResetEmail(email: emailController.text);
                    } on FirebaseAuthException catch(error){
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
                    }
                  },
                  child: Text('Send verification code'),
              )
            ],
          ),
        ),
      ),
    ) ;
  }
}