import 'package:flutter/material.dart';
import 'package:flutter_demo/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginSuccess.dart';

class Login_Form extends StatefulWidget{
  Login_Form({super.key});

  @override
  State<Login_Form> createState() => _Login_FormState();
}


class _Login_FormState extends State<Login_Form> {

  String? getUserEmail;
  String? getUserPassword;
  String? getUserName;
  String error="";

  Future<void> getDetails()async{
    var sharedPref=await SharedPreferences.getInstance();
    setState(() {
      getUserEmail=  sharedPref.getString("email");
      getUserPassword=sharedPref.getString("password");
      getUserName=sharedPref.getString("name");

    });
  }

  @override
  void initState() {
    super.initState();

  }

  final formKey=GlobalKey<FormState>();

  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();

  bool hidePassword=true;


  var emailRegExp=RegExp(r'^(?!\s)([a-z0-9.]+)@(gmail\.com|yahoo\.com)(?!\s)$');
  var passwordRegExp=RegExp(r'^(?!\s)(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*_])(?!\s).{6,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Login Form'),backgroundColor: Colors.blue,),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      label: Text('Enter Your Email'),
                      border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value==null && value!.isEmpty){
                        return 'Please Enter Your Name';
                      }else if(!emailRegExp.hasMatch(value)){
                        return 'Wrong format for email';
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      label: Text('Enter Your Password'),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              hidePassword=!hidePassword;
                            });
                          },
                          icon: hidePassword ? Icon(Icons.visibility): Icon(Icons.visibility_off) ,
                      ),
                    ),
                    obscureText: hidePassword,
                    obscuringCharacter: '*',
                    validator: (value){
                      if(value==null && value!.isEmpty){
                        return  'Please Enter Password';
                      }
                      else if(!passwordRegExp.hasMatch(value)){
                        return 'Password pattern Did\'nt match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text('Forget password?',style: TextStyle(color: Colors.blue),),
                  ),
                  SizedBox(height: 5,),
                  ElevatedButton(
                      onPressed: ()async{
                         await getDetails();
                        if(formKey.currentState!.validate()){
                          // var sharedPref= await SharedPreferences.getInstance();
                          // sharedPref.setString("email", email.text);
                          // sharedPref.setString("password", password.text);

                          if(getUserEmail==email.text && getUserPassword==password.text){
                            setState(() {
                              error="Login success!";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>LoginSuccess()),
                            );
                          }else{
                            setState(() {
                              error="Invalid Credentials";
                            });
                          }
                          print('get values $getUserEmail $getUserPassword ');
                          print('local values ${email.text} ${password.text} ');
                        }
                      },
                      child: Text('Login'),

                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                               'New to Here ?...',
                              style: TextStyle(
                                color: Colors.black
                              )
                            ),
                            TextButton(

                              onPressed: ()  {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>SignUp())
                                );
                                setState(() {
                                  error="";
                                });
                              },
                              child:  Text('Register', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                            )
                          ]
                        )
                    ),
                  SizedBox(height: 20,),
                  Text(error ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}