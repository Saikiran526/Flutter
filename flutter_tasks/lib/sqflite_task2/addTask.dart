import 'package:flutter/material.dart';

class AddTask extends StatelessWidget{

  ///Controllers
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task'),backgroundColor: Color.fromRGBO(182, 125, 245,1.0),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                SizedBox(height: 50,),
                TextField(
                  controller: description,
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                ),
                SizedBox(height: 80,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(182, 125, 245, 1.0), // Correct usage
                      ),

                    ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('Add')
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}