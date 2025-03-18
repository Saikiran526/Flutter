import 'package:flutter/material.dart';
import 'package:flutter_provider/counter_provider.dart';
import 'package:flutter_provider/counter_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context)=>CounterProvider(),
        child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Consumer<CounterProvider>(
          builder: (context, counterProvider, child) {
            return Text(
              'Counter: ${counterProvider.getCount()}',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
