import 'package:flutter/material.dart';
import 'package:flutter_demo/ListWheelScrollViewex.dart';

    class IntroScreen extends StatefulWidget{
  @override
  State<IntroScreen> createState() => _IntroScreeenState();

   IntroScreen({super.key, required this.uName});
   var uName;
}

class _IntroScreeenState extends State<IntroScreen> {

  RangeValues _currentRangeValues=const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {

    String minValue = _currentRangeValues.start.toString(); // Get min value
    String maxValue ="${_currentRangeValues.end}";   // Get max value

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Intro Screen'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Range Slider Demo',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 50,),
              RangeSlider(
                  min:0 ,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels(minValue,maxValue),
                  values: _currentRangeValues,
                  onChanged:(RangeValues values){
                    setState(() {
                      _currentRangeValues=values;
                      print('Current Range Values are : $_currentRangeValues');
                  });
                 } ,
              ),
              SizedBox(height: 30,),
              Text('Do You Want to Try ListWheelScrollView ..?',style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return ListWheelScrollViewex();
                          })
                      );
                  },
                  child: Text('Yes')
              )
            ],
          ),
        ),
      ),
    );
  }
}