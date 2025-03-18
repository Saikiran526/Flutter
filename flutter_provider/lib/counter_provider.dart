import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier{

  ///Private variable
  int _count=0;

  ///getter for the counter
  int getCount()=>_count;

  void increment(){
    _count++;
    notifyListeners();
  }
  void decrement(){
    _count--;
    notifyListeners();
  }

}