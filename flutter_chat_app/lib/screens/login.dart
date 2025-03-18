import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chats.dart';
import 'package:flutter_chat_app/screens/register.dart';

import '../main.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  ///Controllers
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passController=TextEditingController();

  Future<bool> loginUser() async {
    if(emailController.text.isNotEmpty || passController.text.isNotEmpty){
      try{
        final FirebaseAuth _auth=FirebaseAuth.instance;
        final UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
        print('-----User loged in successfully-----');
        return true;
      } on FirebaseAuthException catch(error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${error.code}')));
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),backgroundColor: Colors.blue,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blue
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 21,),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blue
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 21,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white
                    ),
                    onPressed: () async {
                      bool check= await loginUser();
                      if(check){
                        if(!mounted) return;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Chats()), (routs)=>false);
                      }
                    },
                    child: Text('Login'),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not have account?   '),
                          Text('Register',style: TextStyle(fontWeight: FontWeight.bold,),)
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
