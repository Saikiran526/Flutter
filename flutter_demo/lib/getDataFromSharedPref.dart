import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDataFromSharedPref extends StatefulWidget{
  const GetDataFromSharedPref({super.key});
  
  @override
  State<GetDataFromSharedPref> createState() => _GetDataFromSharedPrefState();
}

class _GetDataFromSharedPrefState extends State<GetDataFromSharedPref> {

  String? getEmail;
  String? getPswrd;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

Future<void> getDetails()async{
  final sharedPref= await SharedPreferences.getInstance();

  setState((){
    getEmail= sharedPref.getString("email");
    getPswrd= sharedPref.getString("password");
    print(getEmail);
    print(getPswrd);
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Shared Preferences'),backgroundColor: Colors.blue,),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getEmail??"Empty"),
              Text(getPswrd??"Empty"),
              // ElevatedButton(
              //     onPressed: (){
              //
              //     },
              //     child: Text('Clear'))
            ],
          ),
        ),
      ),
    );
  }
}