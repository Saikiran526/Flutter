import 'package:flutter/material.dart';

class FoodappscreensFavfood extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fav Food Section'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration:BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300
                        ),
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [BoxShadow(
                        //
                        // )]
                      ),
                      child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                    'assets/food1.jpg',
                                    fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text('China Hi,',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                                  Text('Description')
                                ],
                              ),
                            )
                          ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100, // Fixed height
                            width: 100,  // Fixed width
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Optional rounded corners
                              child: Image.asset(
                                'assets/food2.jpg',
                                fit: BoxFit.cover, // Ensures the image fills the box while maintaining aspect ratio
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text('Japan Hi,',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                                Text('Description')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100, // Fixed height
                            width: 100,  // Fixed width
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Optional rounded corners
                              child: Image.asset(
                                'assets/food3.jpg',
                                fit: BoxFit.cover, // Ensures the image fills the box while maintaining aspect ratio
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text('Bharat Hi,',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                                Text('Description')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100, // Fixed height
                            width: 100,  // Fixed width
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Optional rounded corners
                              child: Image.asset(
                                'assets/food4.jpg',
                                fit: BoxFit.cover, // Ensures the image fills the box while maintaining aspect ratio
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text('Russia Hi,',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                                Text('Description')
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
  
}