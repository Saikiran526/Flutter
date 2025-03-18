import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth.dart';
import 'package:flutter_firebase/screens/register.dart';
import 'package:flutter_firebase/screens/resetPassword.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'loginSuccess.dart';

class SignIn extends StatefulWidget{
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  ///Firebase Authentication
  final FirebaseAuth _auth=FirebaseAuth.instance;


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
  void validateUser() async {
    try{
      final userCredentials=await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSuccess()));
      print('User Login');
    } on FirebaseAuthException catch(error){
      _showSnackbar('Authentication Failed');
    }
  }

  void _googleSignInButton() async {
    try{

      final GoogleSignIn googleSignInInstance=GoogleSignIn();///Show Google accounts
      final GoogleSignInAccount? chosedGoogleAccount= await googleSignInInstance.signIn();///Stores the chosen google account

      if(chosedGoogleAccount==null){
        _showSnackbar('Google sign in canceled!');
      }

      final GoogleSignInAuthentication? authenticationDetails= await chosedGoogleAccount?.authentication;
      final OAuthCredential userCredentials=GoogleAuthProvider.credential(
        accessToken: authenticationDetails?.accessToken,
        idToken: authenticationDetails?.idToken,
      );
      await _auth.signInWithCredential(userCredentials);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSuccess()),);
    } catch(error){
      _showSnackbar('\n\n Google signing failed!');
    }
  }
  void _showSnackbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),backgroundColor: Colors.blue,),
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
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassowrd()));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('Forget Password?'),
                          ),
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
                            return;
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
                    SizedBox(height: 21,),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('or',style: TextStyle(fontSize: 20),),
                        ),
                        Expanded(
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            )
                        ),

                      ],
                    ),
                    SizedBox(height: 21,),
                    ElevatedButton(
                        onPressed: (){
                          _googleSignInButton();
                        },
                        child: Text('Signing with google'),
                    )
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

///gpt Code



// import 'package:flutter/material.dart';
// import 'package:flutter_firebase/screens/register.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_firebase/screens/resetPassword.dart';
// import 'loginSuccess.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class SignIn extends StatefulWidget {
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   /// Controllers for email and password fields
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   /// Form validation key
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   /// Password visibility toggle
//   bool passwordHide = true;
//
//   /// Regular expressions for email and password validation
//   final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$');
//   final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*_]).{6,}$');
//
//   /// Handles email-password login
//   void validateUser() async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginSuccess()),
//       );
//     } on FirebaseAuthException catch (error) {
//       _showSnackbar(error.message ?? 'Authentication failed');
//     }
//   }
//
//   /// Google Sign-In function
//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//       if (googleUser == null) {
//         _showSnackbar("Google Sign-In canceled");
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       await _auth.signInWithCredential(credential);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginSuccess()),
//       );
//     } catch (error) {
//       _showSnackbar("\n\nGoogle Sign-In failed: $error");
//     }
//   }
//
//   /// Shows a Snackbar for error messages
//   void _showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In'), backgroundColor: Colors.blue),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 /// Email Field
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter email';
//                     } else if (!emailRegExp.hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 /// Password Field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: passwordHide,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your password',
//                     suffixIcon: IconButton(
//                       icon: Icon(passwordHide ? Icons.visibility : Icons.visibility_off),
//                       onPressed: () {
//                         setState(() {
//                           passwordHide = !passwordHide;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter password';
//                     } else if (!passwordRegExp.hasMatch(value)) {
//                       return 'Password must contain:\n• 1 uppercase letter\n• 1 lowercase letter\n• 1 number\n• 1 special character (@#%^&*_)';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 /// Forgot Password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ResetPassowrd()),
//                       );
//                     },
//                     child: Text('Forgot Password?'),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//
//                 /// Login Button
//                 ElevatedButton(
//                   onPressed: validateUser,
//                   child: Text('Login'),
//                 ),
//                 SizedBox(height: 10),
//
//                 /// Register Navigation
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('New here? '),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
//                       },
//                       child: Text('Register', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//
//                 /// Divider with "OR"
//                 Row(
//                   children: [
//                     Expanded(child: Divider()),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text('or', style: TextStyle(fontSize: 16)),
//                     ),
//                     Expanded(child: Divider()),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//
//                 /// Google Sign-In Button
//
//                 ElevatedButton(
//                 // icon: Image.asset('assets/google_logo.png', height: 24), // Ensure you have a Google logo in assets
//                 //   decoration: InputDecoration(
//                 //     label: Text('Sign in with Google'),
//                 //   ),
//                   child: Text('Sign in with Google'),
//                   onPressed: signInWithGoogle,
//                   style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
