import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth.dart';
import 'package:flutter_firebase/screens/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSuccess extends StatefulWidget{
  // final String user;
  // const LoginSuccess(this.user, {Key? key}) : super(key: key);

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {

  final _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignInInstance=GoogleSignIn();
  User? firebaseUser;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
     setState(() {
       firebaseUser=_auth.currentUser;
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Status'),backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome  !',style: TextStyle(fontSize: 25),),
            Text('Your loged in Successfully',style: TextStyle(color: Colors.green),),
            SizedBox(height: 50,),

            Container(
              child: Column(
                children: [
                  if(firebaseUser?.photoURL!=null)
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(firebaseUser?.photoURL ?? "No photo"),
                        fit: BoxFit.cover
                      )
                    )
                  ),
                  Text(firebaseUser?.email ?? "No Email"),
                  Text(firebaseUser?.displayName ?? "No Name"),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try{

                    await googleSignInInstance.signOut();
                    await _auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context)=>SignIn()),(route)=>false,);
                  } on FirebaseAuthException catch(error){
                    ScaffoldMessenger.of(context).clearMaterialBanners();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? "Sign out failed")));
                  }
                },
                child: Text('Logout')
            ),
          ],
        ),
      ),
    );
  }
}