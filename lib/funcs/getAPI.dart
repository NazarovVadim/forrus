import 'dart:convert';
import 'dart:async';
import 'dart:ui';

import 'package:http/http.dart' as http;


class News {

  final String id;
  final String name;
  final String text;
  final String pictureUrl;
  final String date;
  final bool isTopNews;


  const News ({
    required this.id,
    required this.name,
    required this.text,
    required this.pictureUrl,
    required this.date,
    required this.isTopNews
  });

}

Future<List<News>> fetchNews(bool isTopNews) async {
  var result = await http.get(Uri.parse("http://forrus.incomp.tmweb.ru/api/news/"));
  var jsonData = jsonDecode(result.body);

  List<News> news = [];

  for(var jsonNews in jsonData){

    News article = News(
      id: jsonNews['id'],
      name: jsonNews['name'],
      text: jsonNews['previewText'],
      pictureUrl: jsonNews['previewPicture'],
      date: jsonNews['date'],
      isTopNews: jsonNews['topNews']
    );

    if(isTopNews){
      if(article.isTopNews) news.add(article);
    } else{
      if(!article.isTopNews) news.add(article);
    }



  }

  return news;
}

int getTopNewsCount(List<News>? data){
  int result = 0;

  for(int index = 0; index<data!.length; index++){
    if(data[index].isTopNews){
      result++;
    }
  }

  return result;
}

