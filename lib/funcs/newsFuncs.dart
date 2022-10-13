import 'dart:async' show Future;
import 'getAPI.dart';

class NewsFunc{

  static cutString (String str,int maxLength){
    int endIndex = str[maxLength-1] == ' ' ? maxLength-1 : maxLength;
     String editString =str[0].toUpperCase() + str.substring(1, endIndex);
    return editString;
  }

  static bool isNewsPageLoaded = false;
  static bool isSupportLoaded = false;

  static bool isNewsContentLoaded = false;

  static late Future<List<News>> futureTopNewsLoaded;
  static late Future<List<News>> futureLatestNewsLoaded;
}

