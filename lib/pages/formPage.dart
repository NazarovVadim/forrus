import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:webview_flutter/webview_flutter.dart';
class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int position = 1;

  @override
  void initState(){
    super.initState();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(

        index: position,
        children: <Widget>[
          //Image.asset('assets/images/bg2.png', width: double.infinity,),
          WebView(
            initialUrl: 'https://1os.su/helpdesk/ticket.php?domain=nav-it.bitrix24.ru',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (value){
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (value){
              setState((){
                position = 0;
              });
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  width: 360,
                  height: 600,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )

        ],
      ),
    );
  }
}

