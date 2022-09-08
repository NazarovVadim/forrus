import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async' show Future;

class NewsFunc{

  static cutString (String str,int maxLength){
    //int maxLength = 65;
    String editString = str.substring(0, maxLength);
    if(editString.endsWith(' ')){
      editString.substring(0, editString.length-1);
    }
    return editString;
  }
}

class ImportantNews{
  late String title;
  late String subtitle;
  late String date;
  late String picturePath;

  ImportantNews({required this.title, required this.subtitle, required this.date, required this.picturePath});

  factory ImportantNews.fromJson(Map<String, dynamic> parsedJson){
    return ImportantNews(
        title: parsedJson['title'],
        subtitle: parsedJson['subtitle'],
        date: parsedJson['date'],
        picturePath: parsedJson['picturePath']
    );
  }

  static int index = 0;

}

Future<String> _loadJsonAsset() async{
  return await rootBundle.loadString('assets/db/example.json');
}

Future wait(int seconds) {
  return Future.delayed(Duration(seconds: seconds), () => {});
}

Future<ImportantNews> loadJson() async {
  await wait(5);
  String jsonString = await _loadJsonAsset();
  final jsonResponse = json.decode(jsonString);
  print(jsonResponse);
  return ImportantNews.fromJson(jsonResponse);
}

