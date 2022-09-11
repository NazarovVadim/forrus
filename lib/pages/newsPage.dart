import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:forrus/funcs/getAPI.dart';
import 'package:forrus/funcs/newsFuncs.dart';
import 'package:forrus/pages/detailNewsPage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<News>> futureTopNews;
  late Future<List<News>> futureLatestNews;

  @override
  void initState(){
    super.initState();

    futureTopNews = fetchNews(true);
    futureLatestNews = fetchNews(false);

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 220,
                  child: FutureBuilder<List<News>>(
                    future: futureTopNews,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index){
                            if(snapshot.data![index].isTopNews){
                              return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailNewsPage(
                                          title: snapshot.data![index].name,
                                          describe: snapshot.data![index].text,
                                          date: snapshot.data![index].date,
                                          picturePath: snapshot.data![index].pictureUrl,
                                          heroTag: snapshot.data![index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Stack(

                                      alignment: Alignment.bottomLeft,

                                      children: <Widget>[
                                        Container(

                                          width: 300,
                                          height: 200,
                                          //color: Colors.black,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            gradient:  LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromRGBO(0, 0, 0, 0.4),
                                                Color.fromRGBO(0, 0, 0, 0.9)
                                              ],
                                            ),
                                            //image: DecorationImage(image: Image.asset('assets/images/1img.jpg'))
                                          ),
                                        ),
                                        Hero(
                                          tag: snapshot.data![index].id,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: Image.network(
                                                snapshot.data![index].pictureUrl,
                                                width: 300,
                                                height: 200,
                                                fit: BoxFit.cover,
                                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                                                colorBlendMode: BlendMode.modulate
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  width: 300,
                                                  child: Text( snapshot.data![index].name , style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                                                )
                                              ),
                                              snapshot.data![index].date != null ? Text(snapshot.data![index].date,style: const TextStyle(color: Colors.white, fontSize: 14)) : SizedBox.shrink()
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  )
                              );
                            } else{
                              return const SizedBox.shrink();
                            }
                          }
                        );
                      }else{
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                
                // child: Row(
                //   children: [
                //     Container(
                //       width: 300,
                //       height: 200,
                //       color: Colors.lightGreen,
                //     ),
                //     Container(
                //       width: 300,
                //       height: 200,
                //       color: Colors.red,
                //     ),
                //   ],
                // ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Text('Последнее', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            ),
            SingleChildScrollView(
              child: FutureBuilder<List<News>>(
                future: futureLatestNews,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index){
                        if(!snapshot.data![index].isTopNews){
                          return GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => DetailNewsPage(
                                                            title: snapshot.data![index].name,
                                                            describe: snapshot.data![index].text,
                                                            picturePath: snapshot.data![index].pictureUrl,
                                                            date: snapshot.data![index].date,
                                                            heroTag: snapshot.data![index].id,
                                                        ),
                                                        )
                                                        );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Padding(padding: EdgeInsets.only(left: 10)),
                                                      Hero(
                                                        tag: snapshot.data![index].id,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(15),
                                                          child: Image.network(
                                                            snapshot.data![index].pictureUrl,
                                                            width: 80,
                                                            height: 80,
                                                            fit: BoxFit.cover,
                                                            // color: const Color.fromRGBO(255, 255, 255, 0.5),
                                                            // colorBlendMode: BlendMode.modulate
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(padding: EdgeInsets.only(right: 10)),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text.rich(
                                                            TextSpan(
                                                                children:[
                                                                  TextSpan(
                                                                    text: snapshot.data![index].name + '\n',
                                                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                                                  ),
                                                                  TextSpan(
                                                                      text: '${NewsFunc.cutString(snapshot.data![index].text, 65)}...\n'
                                                                    //style: TextStyle(fontSize: 14),
                                                                  ),
                                                                  TextSpan(text: snapshot.data![index].date)
                                                                ]
                                                            )
                                                        ),
                                                      ),

                                                      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                                                    ],
                                                  ),
                                                );
                        } else{
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  } else{
                    return const CircularProgressIndicator(color: Color.fromRGBO(244, 198, 6, 1),);
                  }
                },
              ),
            )

          ]
        ),
      )
    );
  }
}
