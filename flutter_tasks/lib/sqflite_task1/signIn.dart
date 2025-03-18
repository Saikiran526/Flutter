import 'package:flutter/material.dart';
import 'package:flutter_tasks/sqflite/db_helper.dart';
import 'package:flutter_tasks/sqflite_task1/signUp.dart';
import 'package:sqflite/sqflite.dart';

import 'loginSuccess.dart';

class SignIn extends StatefulWidget{
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef=DBHelper.getInstance;
  }

  ///Controllers
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  ///variables
  bool  passwordHide=false;
  var emailRegExp=RegExp(r'^(?!\s)([a-z0-9.]+)@(gmail\.com|yahoo\.com)(?!\s)$');
  var passwordRegExp=RegExp(r'^(?!\s)(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*_])(?!\s).{6,}$');
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String errorMsg="";


  ///Validate User
  void validateUser() async{
    List<Map<String,dynamic>> users= await dbRef!.getAllUsers();
    bool flag=true;
    for(var user in users){
      print(user['email']);
      if(user['email']==emailController.text){
        flag=false;
        if(user['password']!=passwordController.text){
          setState(() {
            errorMsg="Invalid password";
          });
          break;
        } else {///if(user['password']==passwordController.text){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSuccess(user['name'])));
        }
      }
    }
    if(flag){
      setState(() {
        errorMsg="User not found! Please Register";
      });
    }
  }

  void getAllUsersDetails() async {
    List<Map<String,dynamic>> users= await dbRef!.getAllUsers();
    for(var user in users){
      print('userId ${user['sno']} , Email Address ${user['email']} , Password ${user['password']}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Singn In'),backgroundColor: Colors.blue,),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue,Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width*0.90,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(21),
                // border: Border.all(
                //   width: 1,
                //   // color: Colors.grey
                // )
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 10,
                //     spreadRadius: 2,
                //     offset: Offset(0, 0),
                //   )
                // ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.80,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///email field
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        label: Text('Enter your email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                        )
                      ),
                      validator: (value){
                        if(value==null || value .isEmpty){
                          return 'Please enter email';
                        } else if(!emailRegExp.hasMatch(value)){
                          return 'Please enter valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 21,),
                    ///password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordHide,
                      decoration: InputDecoration(
                        label: Text('Enter your Password'),
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                passwordHide=!passwordHide;
                              });
                            },
                            icon: SizedBox(
                                child: passwordHide ? Icon(Icons.visibility,) : Icon(Icons.visibility_off)
                            )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                        )
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter password';
                        } else if(!passwordRegExp.hasMatch(value)){
                          return 'Password must be at least 6 characters, including: \n• 1 uppercase letter\n• 1 lowercase letter\n• 1 number\n• 1 special character (@#%^&*_)';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 2,),
                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forget Password?'),
                      )
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        // padding: ,
                        // shape: RoundedRectangleBorder()
                      ),
                        onPressed: (){
                        if(!formKey.currentState!.validate()){
                          print('Form is not valid');
                        }
                        validateUser();
                        errorMsg="";
                        },
                        child: Text('Login in')
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New to here ... ',style: TextStyle()),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context)=>SignUp())
                            );
                          },
                          child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
                        ),
                      ],
                    ),
                    Text(errorMsg,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                    // ElevatedButton(
                    //     onPressed: (){getAllUsersDetails();},
                    //     child: Text('All users data')
                    // )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}