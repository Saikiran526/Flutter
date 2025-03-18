import 'package:flutter/material.dart';
import 'package:flutter_tasks/sqflite_task2/addTask.dart';

class Home_Task_2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO App'),
        backgroundColor: Color.fromRGBO(182, 125, 245,1.0),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {  },
              icon: Icon(Icons.calendar_today)
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(225, 202, 250, 1.0),
        child: ListView.builder(
            itemBuilder: (_,index){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shadowColor: Colors.black,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Title'),
                    subtitle: Text('Sub-Title'),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color:Color.fromRGBO(202, 155, 253, 1.0)),),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete,color:Color.fromRGBO(202, 155, 253, 1.0))),
                          IconButton(onPressed: (){}, icon: Icon(Icons.check_circle,color:Color.fromRGBO(202, 155, 253, 1.0))),
                        ],
                      ),
                    )
                  ),
                ),
              ),
            );
          },
          itemCount: 1,
          ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Color.fromRGBO(182, 125, 245,1.0),
          foregroundColor: Colors.white,
          elevation: 10.0,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35)
          ),
          child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.add)
          ),
        ),
      ) ,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            SizedBox(
              child: Column(
                children: [
                  InkWell(
                    onTap:(){},
                    child: Icon(Icons.menu),
                  ),
                  Text('All',style: TextStyle(fontSize: 11),)
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  InkWell(
                    onTap:(){},
                    child: Icon(Icons.check),
                  ),
                  Text('Completed',style: TextStyle(fontSize: 11),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}