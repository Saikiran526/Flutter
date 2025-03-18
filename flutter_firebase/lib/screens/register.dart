import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  /// Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailRegExp = RegExp(r'^(?!\s)([a-z0-9.]+)@(gmail\.com|yahoo\.com)(?!\s)$');
  var passwordRegExp = RegExp(r'^(?!\s)(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*_])(?!\s).{6,}$');
  bool hidePassword1 = false;
  bool hidePassword2 = false;

  void isValid() async {
    if (formKey.currentState!.validate()) {
      try{
        final userCredentials= await firebase.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
        print(userCredentials);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
      }
    } else {
      print('Form is not validated..!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'), backgroundColor: Colors.blue),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(21),
                color: Colors.blue.shade100,
                boxShadow: [BoxShadow(color: Colors.black, spreadRadius: 2, blurRadius: 10, offset: Offset(0, 5))],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign Up Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 30),

                      /// Name field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(label: Text('Enter your Name'), border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          } else if (!RegExp(r'^.{1,20}$').hasMatch(value)) {
                            return 'Min 1 and Max 20 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      /// Email field
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(label: Text('Enter your email'), border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email id';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      /// Password field
                      TextFormField(
                        controller: passwordController,
                        obscureText: hidePassword1,
                        decoration: InputDecoration(
                          label: Text('Enter your password'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            },
                            icon: hidePassword1 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (!passwordRegExp.hasMatch(value)) {
                            return 'Min one uppercase, lowercase, special char & number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      /// Re-entered password field
                      TextFormField(
                        controller: rePasswordController,
                        obscureText: hidePassword2,
                        decoration: InputDecoration(
                          label: Text('Re-enter your password'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword2 = !hidePassword2;
                              });
                            },
                            icon: hidePassword2 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter password';
                          } else if (passwordController.text != rePasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      /// Sign Up Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        onPressed: () async {
                          isValid();
                        },
                        child: Text('Sign Up'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
