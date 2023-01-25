import 'package:flutter/material.dart';
import 'package:forrus/pages/homePage.dart';
import 'package:forrus/pages/newsPage.dart';
import 'package:forrus/providers/form_page_provider.dart';
import 'package:provider/provider.dart';

void main(){

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FormPageProvider()),
    ],
    child: ForrusApp(),
  ));

}

class ForrusApp extends StatelessWidget {
  const ForrusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: const Color.fromRGBO(244, 98, 6, 1),
          fontFamily: 'Bahnschrift'
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
