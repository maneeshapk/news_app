// ignore_for_file: avoid_print


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bbcnews/news_model.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  
  List<News> news = [];
  
  List<dynamic> get searchNews => news;

  void getNews(String item) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$item&apiKey=3b1ce7c57be948b785d49aec1be39548"));
    
final jsonData = jsonDecode(response.body);

print(jsonData);

  if (jsonData['articles'] != null) {
    final newsList = jsonData['articles'];
    List<News> tempNews = [];
  
    for (var newsMap in newsList) {
      News news = News.fromMap(newsMap);
      tempNews.add(news);
    }
    news = tempNews;
    notifyListeners();
  }
  else{

  }
  }
}





