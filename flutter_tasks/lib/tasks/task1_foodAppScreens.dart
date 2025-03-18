import 'package:flutter/material.dart';

import 'foodAppScreens_FavFood.dart';

class Task1_foodAppScreens extends StatefulWidget{
  const Task1_foodAppScreens({super.key});

  @override
  State<Task1_foodAppScreens> createState() => _Task1_foodAppScreensState();
}

class _Task1_foodAppScreensState extends State<Task1_foodAppScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Picker',),backgroundColor: Colors.blue,),
      body:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: [
                      //1st item
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/food1.jpg',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Description'),
                                      Text('250')
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  radius: 10.0,
                                  child: Text('+'),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                      //2nd item
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/food2.jpg',
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Description'),
                                      Text('250')
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  radius: 10.0,
                                  child: Text('+'),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                      //3rd item
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/food3.jpg',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Description'),
                                      Text('250')
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  radius: 10.0,
                                  child: Text('+'),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                      //4th item
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/food4.jpg',
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Description'),
                                      Text('250')
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  radius: 10.0,
                                  child: Text('+'),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>FoodappscreensFavfood()
                          ),
                      );
                    }, 
                    child: Text('Fav Food',style: TextStyle(fontSize: 20,color: Colors.red),)
                )
              ],
            ),
          ),
    );
  }
}

