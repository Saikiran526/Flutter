import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
           Text(
             'Hello World',
             style:GoogleFonts.abel(
              fontSize: 30,
              fontWeight: FontWeight.bold
             ) ,
           ),
           SizedBox(height: 21,),
           Text(
             'Hello World',
             style: GoogleFonts.abhayaLibre(
               fontSize: 30,
               fontWeight: FontWeight.bold
             ),
           ),
           SizedBox(height: 21,),
           Text(
               'Hello World',
                style: GoogleFonts.actor(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
           ),
           SizedBox(height: 21,),
           Text('Hello World',style: GoogleFonts.tektur(
             fontSize: 30,
             fontWeight: FontWeight.bold,
            )
           ),
           SizedBox(height: 21,),
           Text('Hello World',style: GoogleFonts.dancingScript(
             fontSize: 30,
             fontWeight: FontWeight.bold,
            ),
           ),
         ],
       ),
      ),
    );
  }
}
