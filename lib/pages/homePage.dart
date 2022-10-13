import 'package:flutter/material.dart';
import 'package:forrus/pages/formPage.dart';
import 'package:forrus/pages/newsPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
      SalomonBottomBarItem(
          icon: Icon(
              Icons.newspaper,
              color: (currentTabIndex == 0) ? const Color.fromRGBO(244, 198, 6, 1) : const Color.fromRGBO(29, 31, 38, 1)),
          title: const Text('Новости'),
          selectedColor: const Color.fromRGBO(244, 198, 6, 1)
      ),
      SalomonBottomBarItem(
          icon: Icon(
              Icons.support_agent,
              color: (currentTabIndex != 0) ? const Color.fromRGBO(244, 198, 6, 1) : const Color.fromRGBO(29, 31, 38, 1)),
          title:const  Text('Поддержка'),
          selectedColor: const Color.fromRGBO(244, 198, 6, 1)
      )
    ];



    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 244, 198, 6),
        title: Image.asset('assets/images/logo_black.png', height: 40,),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/images/bg2.png', width: double.infinity,),
            _tabPages[currentTabIndex],

          ],
        ),
      ),

      bottomNavigationBar: SalomonBottomBar(
        items: _tabIcons,
        currentIndex: currentTabIndex,
        //type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState((){
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
