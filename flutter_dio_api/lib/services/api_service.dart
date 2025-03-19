import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ApiService extends ChangeNotifier{
  final Dio _dio=Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
    )
  );

  Future<List<dynamic>> fetchNews(String category) async {
    try{
      print("Category we get in the api_service : $category");
      Response response= await _dio.get(
        "top-headlines",
          queryParameters: {
          "country":"us",
            "category":category,///"general",///category,
            "apiKey":"ee4270806ec74c82a014d5c4c41e0ff5",
          }
      );
      // print('Api fetch successfully..!');
      // print(response.data['articles']);
      return response.data['articles'];
    } on DioException catch(error){
      print("DioException error : $error");
      return [];
    } catch(error){
      print("Error : $error");
      return [];
    }
  }
}