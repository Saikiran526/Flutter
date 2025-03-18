import 'package:dio/dio.dart';

class ApiService{
  final Dio _dio=Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      receiveTimeout: Duration(seconds: 1),
      connectTimeout: Duration(seconds: 1),
    )
  );

  Future<List<dynamic>> getNews() async {
    try{
      Response response= await _dio.get(
        "top-headlines",
          queryParameters: {
          "country":"us",
            "category":"general",
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