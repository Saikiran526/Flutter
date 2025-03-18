import 'package:flutter/material.dart';
import 'package:flutter_dio_api/model/news_model.dart';
import 'package:flutter_dio_api/services/api_service.dart';
import 'package:flutter_dio_api/viewModel/news_viewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ApiService _apiService=ApiService();
   get apiService=>_apiService;
   final NewsModel _newsModel=NewsModel();
  get newsModel=>_newsModel;
  final NewsViewModel _newsViewModel=NewsViewModel();
  bool isLoading=true;


  @override
  void initState() {
    super.initState();
    fetchNews();
  }
  void fetchNews() async {
    await _newsViewModel.getNews();
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quick News'),backgroundColor: Colors.blue,),
      body: isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (context,index){
              NewsModel news= _newsViewModel.newsList[index];
              return Card(
                margin: EdgeInsets.all(11),
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                          height:80,
                          width: 80,
                          child: news.imgUrl!=null && news.imgUrl!.isNotEmpty
                                  ? Image.network(news.imgUrl!,fit: BoxFit.cover,)
                                  : Container(height: 80,width: 80,color: Colors.blue,)
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('${news.title}' ,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  '${news.description}',
                                  maxLines: 2,
                              ),
                              TextButton(onPressed: () async {
                                if(news.url!=null && news.url!.isNotEmpty){
                                  final Uri _url=Uri.parse(news.url!);
                                  if( await canLaunchUrl(_url)){
                                    await launchUrl(_url,mode: LaunchMode.externalApplication);
                                  } else {
                                    print('Url is : ${news.url}');
                                    print('Could not lunch url');
                                  }
                                } else {
                                  print('Url is not valid');
                                }
                              }, child: Text('more...'))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: _newsViewModel.newsList.length
        )
    );
  }
}
