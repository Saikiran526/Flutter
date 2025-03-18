import 'package:flutter/material.dart';
import 'package:flutter_tasks/sqflite_task1/signIn.dart';

class Home_task_1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),backgroundColor: Colors.blue,),
      body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue,Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SQFLite task 1',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 20,),
                      Text('Storing the Registered values in the data base and validating the credentials while login'),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>SignIn())
                            );
                          },
                          child: Text('Login')
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

    );
  }

}