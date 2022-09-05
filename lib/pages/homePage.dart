import 'package:flutter/material.dart';
import 'package:forrus/pages/formPage.dart';
import 'package:forrus/pages/newsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    final _tabPages = <Widget>[
      const Center(child: NewsPage(),),
      const Center(child: FormPage(),)
    ];

    final _tabIcons = [
      BottomNavigationBarItem(icon: Icon(Icons.newspaper, color: (currentTabIndex == 0) ? Color.fromRGBO(244, 198, 6, 1) : Color.fromRGBO(29, 31, 38, 1)), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.support_agent, color: (currentTabIndex != 0) ? Color.fromRGBO(244, 198, 6, 1) : Color.fromRGBO(29, 31, 38, 1)), label: '')
    ];



    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/forrus.jpg', width: 130,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(244, 198, 6, 1),
      ),
      body: _tabPages[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _tabIcons,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState((){
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
