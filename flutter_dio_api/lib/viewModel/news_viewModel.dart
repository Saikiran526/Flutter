import 'package:flutter/cupertino.dart';
import '../services/api_service.dart';
import '../model/news_model.dart';

class NewsViewModel extends ChangeNotifier{

  // BuildContext? context;
  // NewsViewModel({required this.context});

  final ApiService _apiService=ApiService();
  List<NewsModel> newsList=[];

  ///Method to fetch News
  Future<void> getNews(String category) async {
    try{
      print('Category in NewsViewModel : ${_apiService}');
      List<dynamic>  newsData= await _apiService.fetchNews(category);
      newsList=newsData.map((data)=>NewsModel.fromJson(data)).toList();
      notifyListeners();
    } catch (error){
      print('Error : $error');
    }
  }
}