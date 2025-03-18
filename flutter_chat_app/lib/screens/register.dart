import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/main.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/screens/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  ///Controllers
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passController=TextEditingController();
  final TextEditingController nameController=TextEditingController();
  final TextEditingController mobileController=TextEditingController();
  final TextEditingController repassController=TextEditingController();

  Future<void> storeEmailPassInFirebase() async {
    try{
      final FirebaseAuth _auth=FirebaseAuth.instance;
      final UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
      print('User credentials \n email : ${userCredential}');
      postDetailsToFireStore();
    } on FirebaseAuthException catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code)));
    }
  }

  void postDetailsToFireStore() async {

    ///Get the current user
    User? user=FirebaseAuth.instance.currentUser;

    ///Create instance for the FirebaseFirestore
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

    ///Create instnce for the UserModel
    UserModel userModel=UserModel();
    userModel.uid=user?.uid;
    userModel.name=nameController.text;
    userModel.mobile=int.tryParse(mobileController.text);
    userModel.email=emailController.text;

    await firebaseFirestore.collection('users').doc(user?.uid).set(userModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Enter your name",
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
                      controller: mobileController,
                      decoration: InputDecoration(
                          labelText: "Mobile No",
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
                    TextFormField(
                      controller: repassController,
                      decoration: InputDecoration(
                          labelText: "Reenter password",
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
                      onPressed: (){
                        storeEmailPassInFirebase();
                      },
                      child: Text('Register'),
                    ),
        
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
