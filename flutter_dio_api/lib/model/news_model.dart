import 'dart:convert';

class NewsModel{
  String? title;
  String? description;
  String? url;
  String? imgUrl;

  NewsModel({
    this.title,
    this.description,
    this.url,
    this.imgUrl
  });

  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      url: json['url'],
      imgUrl: json['urlToImage'],
    );
  }

  static List<NewsModel> getNewsList(List<dynamic> jsonList){
    return jsonList.map((json)=>NewsModel.fromJson(json)).toList();
  }

}