import 'package:flutter/material.dart';
import 'package:flutter_demo/login_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget{

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var formField=GlobalKey<FormState>();
  var userName=TextEditingController();
  var userEmail=TextEditingController();
  var userPassword=TextEditingController();
  var userReenterPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up Screen'),backgroundColor: Colors.green,),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: formField,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextFormField(
                   controller: userName,
                   decoration: InputDecoration(
                     label: Text('Enter your name'),
                     border: OutlineInputBorder(),
                   ),
                   validator: (value){
                      if(value==null && value!.isEmpty){
                        return 'Enter Your Name';
                      }else if(value.length>25){
                        return 'Name too long';
                      }else{
                        return null;
                      }
                   },
                 ),
                 SizedBox(height: 20,),
                 TextFormField(
                   controller: userEmail,
                   keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                     label: Text('Enter Your Email'),
                     border: OutlineInputBorder(),
                   ),
                   validator: (value){
                     if(value==null && value!.isEmpty){
                       return 'Enter mail address';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 20,),
                 TextFormField(
                   controller: userPassword,
                   decoration: InputDecoration(
                     label: Text('Enter your password'),
                     border: OutlineInputBorder()
                   ),
                   obscureText: true,
                   obscuringCharacter: '*',
                   validator: (value){
                     if(value==null && value!.isEmpty){
                       return 'Enter your password';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 20,),
                 TextFormField(
                   controller: userReenterPassword,
                   decoration: InputDecoration(
                       label: Text('Re-enter your password'),
                       border: OutlineInputBorder()
                   ),
                   obscureText: true,
                   obscuringCharacter: '*',
                   validator: (value){
                     if(value==null && value!.isEmpty) {
                       return 'Enter your password';
                     }
                     // }else if(userPassword.text!=userReenterPassword.text){
                     //   return 'Password did\'nt match';
                     // }
                     return null;
                   },
                 ),
                 SizedBox(height: 20,),
                 ElevatedButton(
                     onPressed: ()async{
                       if(formField.currentState!.validate()){
                         var sharedPref= await SharedPreferences.getInstance();
                         setState(() {
                           sharedPref.setString("name", userName.text);
                           sharedPref.setString("email", userEmail.text);
                           sharedPref.setString("password", userPassword.text);
                         });
                         Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context)=>Login_Form())
                         );

                       }
                     },
                     child: Text('Register')
                 )
               ],
              )
            ),
          ),
        ),
      ),
    );
  }
}