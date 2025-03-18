import '../services/api_service.dart';
import '../model/news_model.dart';

class NewsViewModel{
  final ApiService _apiService=ApiService();
  List<NewsModel> newsList=[];

  ///Method to fetch News
  Future<void> getNews() async {
    try{
      List<dynamic>  newsData= await _apiService.getNews();
      newsList=newsData.map((data)=>NewsModel.fromJson(data)).toList();
    } catch (error){
      print('Error : $error');
    }
  }
}