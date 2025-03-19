import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/category_provider.dart';
import '../services/api_service.dart';
import '../viewModel/news_viewModel.dart';
import '../viewModel/overlay_viewModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  late NewsViewModel newsViewModel;
  late OverlayViewModel overlayViewModel;

  @override
  void initState() {
    super.initState();
    print('Init State is called');
    newsViewModel = NewsViewModel();
    overlayViewModel = OverlayViewModel(context: context);
    fetchNewsdata();
  }

  @override
  void didChangeDependencies() {
    print('Did change Dependencies called');
    super.didChangeDependencies();
    fetchNewsdata();
  }



  void fetchNewsdata() async {
    final category = Provider.of<CategoryProvider>(context, listen: true).category;
    print('Category in the home screen : $category');
    await newsViewModel.getNews(category);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Quick News'),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                if (overlayViewModel.overlayEntry == null) {
                  overlayViewModel.showOverlay();
                } else {
                  overlayViewModel.removeOverlay();
                }
              },
              icon: const Icon(Icons.menu),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: newsViewModel.newsList.length,
        itemBuilder: (context, index) {
          final news = newsViewModel.newsList[index];
          return Card(
            margin: const EdgeInsets.all(11),
            child: SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: news.imgUrl != null && news.imgUrl!.isNotEmpty
                        ? Image.network(news.imgUrl!, fit: BoxFit.cover)
                        : Container(height: 80, width: 80, color: Colors.blue),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            news.title ?? "No Title",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            news.description ?? "No Description",
                            maxLines: 2,
                          ),
                          TextButton(
                            onPressed: () async {
                              if (news.url != null && news.url!.isNotEmpty) {
                                final Uri _url = Uri.parse(news.url!);
                                if (await canLaunchUrl(_url)) {
                                  await launchUrl(_url, mode: LaunchMode.externalApplication);
                                } else {
                                  print('Url is: ${news.url}');
                                  print('Could not launch url');
                                }
                              } else {
                                print('Url is not valid');
                              }
                            },
                            child: const Text('more...'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}