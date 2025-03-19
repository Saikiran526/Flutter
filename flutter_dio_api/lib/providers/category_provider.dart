import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier{

  String _category="general";
  String get category=>_category;

  ///Update category
  void setCategory( String newCategory ){
    // print('New Category $newCategory');
    _category=newCategory;
    notifyListeners();
  }
}