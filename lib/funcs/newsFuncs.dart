import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async' show Future;

import 'getAPI.dart';

class NewsFunc{

  static cutString (String str,int maxLength){
    //int maxLength = 65;
    String editString = str.substring(0, maxLength);
    if(editString.endsWith(' ')){
      editString.substring(0, editString.length-1);
    }
    return editString;
  }

  static bool isNewsLoaded = false;
  static bool isSupportLoaded = false;
  static late Future<List<News>> futureTopNewsLoaded;
  static late Future<List<News>> futureLatestNewsLoaded;
}

