import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final  counterProvider=Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home'),backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value :'),
            Text('${counterProvider.getCount()}'),
            SizedBox(height: 21,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: counterProvider.increment, child: Text('+')),
                SizedBox(width: 11,),
                ElevatedButton(onPressed: counterProvider.decrement, child: Text('-')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
