import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebase=FirebaseAuth.instance;

class AuthScreen extends StatefulWidget{
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  bool isLogin=true;
  final formKey=GlobalKey<FormState>();

  void submit() async {
    // if(formKey.currentState!.validate()){
    //   return ;
    // };

      try{
        final userCredentials= await firebase.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text
        );
        print(userCredentials);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                  bottom: 20
                ),
                width: 200,
                child: SizedBox(
                  width: 100,
                    height: 100,
                    child: Image.asset('assets/images/chat.png')
                ),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value){
                                  if(value== null || value.trim().isEmpty || !value.contains('@')){
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                              },
                            ),
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                              validator: (value){
                                if(value== null || value.trim().length<6){
                                  return 'Password must be minimum 6 char';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton(
                                onPressed: submit,
                                child: Text(isLogin ? 'Login':'Singnup')
                            ),
                            TextButton(
                                onPressed: (){
                                  setState(() {
                                    isLogin=!isLogin;
                                  });
                                },
                                child: Text( isLogin ? 'Create Account' : 'Already have an Account')
                            )
                          ],
                        )
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
