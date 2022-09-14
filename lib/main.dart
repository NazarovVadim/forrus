import 'package:flutter/material.dart';
import 'package:forrus/pages/homePage.dart';
import 'package:forrus/pages/newsPage.dart';

void main(){

  runApp(MaterialApp(
    theme: ThemeData(brightness: Brightness.light, primaryColor: const Color.fromRGBO(244, 98, 6, 1)),
    home: const HomePage(),
    debugShowCheckedModeBanner: false,
  ));

}