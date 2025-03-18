import 'package:flutter/material.dart';
import 'package:flutter_tasks/sqflite/home_sqflite.dart';
import 'package:flutter_tasks/sqflite_task1/home_task_1.dart';
import 'package:flutter_tasks/sqflite_task2/home_task_2.dart';
import 'firebase_EmailPass/login.dart';
import 'tasks/task1_foodAppScreens.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Tasks Home Page'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Home Page',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('UI',style: TextStyle(color: Colors.red,fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Task1_foodAppScreens()));
              },
              child: Text('Food Picker'),
            ),
            SizedBox(height: 20,),
            Text("SQFLite",style: TextStyle(color: Colors.red,fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_sqflite()));
                    },
                    child: Text('SQFLite')
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Home_task_1())
                      );
                    },
                    child: Text('task_1')
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Home_Task_2())
                      );
                    },
                    child: Text('task_2')
                )
              ],
            ),
            SizedBox(height: 20,),
            Text('Fire Base',style: TextStyle(color: Colors.red,fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text('Email/Password')
                )
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

