import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:forrus/funcs/getAPI.dart';
import 'package:forrus/funcs/newsFuncs.dart';
import 'package:forrus/pages/formPage.dart';
import 'package:skeletons/skeletons.dart';
import 'package:forrus/pages/detailNewsPage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<News>> futureTopNews;
  late Future<List<News>> futureLatestNews;
  //late Future<List<News>> futureDetail;



  @override
  void initState(){
    super.initState();

    if(!NewsFunc.isNewsPageLoaded){
      futureTopNews = fetchNews(true);
      NewsFunc.futureTopNewsLoaded = futureTopNews;
      futureLatestNews = fetchNews(false);
      NewsFunc.futureLatestNewsLoaded = futureLatestNews;
      NewsFunc.isNewsPageLoaded = true;
    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 1, 0),
      body: RefreshIndicator(
          color: Colors.black,
          onRefresh: ()async{
            setState((){
              futureTopNews = fetchNews(true);

              NewsFunc.futureTopNewsLoaded = futureTopNews;
              futureLatestNews = fetchNews(false);
              NewsFunc.futureLatestNewsLoaded = futureLatestNews;
            });
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(

            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  SingleChildScrollView(

                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      height: 220,
                      child: FutureBuilder<List<News>>(
                        future: NewsFunc.futureTopNewsLoaded,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            NewsFunc.isNewsContentLoaded = true;
                          } else{
                            NewsFunc.isNewsContentLoaded = false;
                          }
                          if( NewsFunc.isNewsContentLoaded){
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
                                                MaterialPageRoute(builder: (context) => DetailNewsPage(
                                                    id: snapshot.data![index].id,
                                                  ),
                                                )
                                            );
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.only(left: 10,bottom: 10),
                                            child: Stack(

                                              alignment: Alignment.bottomLeft,

                                              children: <Widget>[

                                                Hero(
                                                  tag: snapshot.data![index].id,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                                                    child: Image.network(
                                                        snapshot.data![index].pictureUrl,
                                                        width: 300,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                                        colorBlendMode: BlendMode.modulate,

                                                    ),
                                                  ),
                                                ),
                                                Container(

                                                  width: 300,
                                                  height: 200,
                                                  //color: Colors.black,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(25)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 0), // changes position of shadow
                                                      ),
                                                    ],
                                                    gradient:  const LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(0, 0, 0, 0.25),
                                                        Color.fromRGBO(0, 0, 0, 0.7)
                                                      ],
                                                    ),
                                                    //image: DecorationImage(image: Image.asset('assets/images/1img.jpg'))
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ),
                                    );
                                  } else{
                                    return const SizedBox.shrink();
                                  }
                                }
                            );
                          }else{
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 300,
                                        height: 200,
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 300,
                                        height: 200,
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text('Последние новости', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                    ),
                  const SizedBox(height: 10,),
                  FutureBuilder<List<News>>(
                      future: NewsFunc.futureLatestNewsLoaded,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          NewsFunc.isNewsContentLoaded = true;
                        } else{
                          NewsFunc.isNewsContentLoaded = false;
                        }
                        if(NewsFunc.isNewsContentLoaded){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index){
                                if(!snapshot.data![index].isTopNews){
                                  return GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => DetailNewsPage(
                                              id: snapshot.data![index].id,
                                            ),
                                            )
                                        );

                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.05),
                                                  spreadRadius: 3,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ]
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  Hero(
                                                      tag: snapshot.data![index].id,
                                                      child: Container(
                                                        width: 90,
                                                        height: 90,
                                                        child: ClipPolygon(
                                                          child: Image.network(snapshot.data![index].pictureUrl, fit: BoxFit.cover,),
                                                          sides: 6,
                                                          borderRadius: 10,
                                                        ),
                                                      )
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
                                                                  text: '${NewsFunc.cutString(snapshot.data![index].text, snapshot.data![index].text.length < 65 ? snapshot.data![index].text.length : 65)}...\n'
                                                                //style: TextStyle(fontSize: 14),
                                                              ),
                                                              TextSpan(text: snapshot.data![index].date)
                                                            ]
                                                        )
                                                    ),
                                                  ),

                                                  IconButton(
                                                      onPressed: (){
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => DetailNewsPage(
                                                              id: snapshot.data![index].id,
                                                            ),
                                                            )
                                                        );
                                                      },
                                                      icon: const Icon(Icons.arrow_forward_ios_outlined)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15,)
                                        ],
                                      )
                                  );
                                } else{
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          );
                        } else{
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 10)),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 80,
                                        height: 80,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.only(right: 10)),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                lines: 2,
                                                spacing: 5,
                                                lineStyle: SkeletonLineStyle(
                                                  alignment: Alignment.topLeft,
                                                  randomLength: true,
                                                  height: 18,
                                                  minLength: MediaQuery.of(context).size.width / 2,
                                                )

                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8, top: 3),
                                            child: SkeletonLine(
                                              style: SkeletonLineStyle(
                                                  width: 80,
                                                  height: 14
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),

                                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              Row(
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 10)),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 80,
                                        height: 80,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.only(right: 10)),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                lines: 2,
                                                spacing: 5,
                                                lineStyle: SkeletonLineStyle(
                                                  alignment: Alignment.topLeft,
                                                  randomLength: true,
                                                  height: 18,
                                                  minLength: MediaQuery.of(context).size.width / 2,
                                                )

                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8, top: 3),
                                            child: SkeletonLine(
                                              style: SkeletonLineStyle(
                                                  width: 80,
                                                  height: 14
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),

                                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  SizedBox(height: 20,)

                ]
            ),
          ),
        )
      );
  }
}
