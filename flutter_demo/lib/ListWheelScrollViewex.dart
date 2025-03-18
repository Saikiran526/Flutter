import 'package:flutter/material.dart';

class ListWheelScrollViewex extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var itmIndex=[1,2,3,4,5,6,7,8,9,10,11];

    return Scaffold(
      appBar: AppBar(title: Text("ListWheelScrollView Example"),backgroundColor: Colors.purple.shade200,),

      body: ListWheelScrollView(
          itemExtent: 300,
          children:itmIndex.map((ele){
            return Padding(
                padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(21)
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.blueGrey,),
                    title: Text('Name'),
                    subtitle: Text('Index : $ele'),
                    trailing: Icon(Icons.insert_chart),
                    onTap: (){
                      print('Index No is : $ele');
                    },
                  ),
                ),
              ),
            );
          }).toList(),
      ),
    );
  }

}