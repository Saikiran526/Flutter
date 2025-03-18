import 'package:flutter/material.dart';
import 'package:flutter_demo/SplashScreen.dart';

import 'login_Form.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    // var arrColors=[Colors.grey,Colors.green,Colors.blue,Colors.black,Colors.purple,Colors.orange,Colors.red,Colors.blueGrey];

  final TextEditingController name=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

       //Body Here
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white,Colors.deepPurple],
                // begin: FractionalOffset(0.0, dy)
                begin: Alignment(0.0,0.1),
                end: Alignment(0.1,1.1),
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Home Page',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        label: Text('Enter Your Name')
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return SplashScreen(userName: name.text);
                        }
                        )
                    );
                  }, child: Text('Intro Screen')),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>Login_Form(),),
                        );
                      },
                      child: Text('Login Form')
                  )

                ],
              ),
            ),
          ),
        );
  }
}

