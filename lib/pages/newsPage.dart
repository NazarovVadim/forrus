import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:forrus/funcs/getAPI.dart';
import 'package:forrus/funcs/newsFuncs.dart';
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
      backgroundColor: const Color.fromRGBO(1, 1, 1, 0),
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

            physics: const BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(

                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      height: 230,
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<List<News>>(
                        future: NewsFunc.futureTopNewsLoaded,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            NewsFunc.isNewsContentLoaded = true;
                          } else{
                            NewsFunc.isNewsContentLoaded = false;
                          }
                          if(NewsFunc.isNewsContentLoaded){
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
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: <Widget>[
                                                Hero(
                                                  tag: snapshot.data![index].id,
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(25)),
                                                    child: Image.network(
                                                        snapshot.data![index].pictureUrl,
                                                        width: 300,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                                        colorBlendMode: BlendMode.modulate,
                                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                                                          if(loadingProgress == null) return child;
                                                          return const SizedBox(
                                                            height: 200,
                                                            child: SkeletonLine(
                                                              style: SkeletonLineStyle(
                                                                  width: 300,
                                                                  height: 200
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(

                                                  width: 300,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(25)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 10,
                                                        offset: const Offset(0, 0), // changes position of shadow
                                                      ),
                                                    ],
                                                    gradient:  const LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(0, 0, 0, 0.1),
                                                        Color.fromRGBO(0, 0, 0, 0.3)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 100,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20, bottom: 15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Flexible(
                                                            child: SizedBox(
                                                              width: 280,
                                                              child: Text( snapshot.data![index].name , style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                                                            )
                                                        ),
                                                        snapshot.data![index].date.isNotEmpty ? const SizedBox(height: 3,) : const SizedBox.shrink(),
                                                        snapshot.data![index].date.isNotEmpty ? Text(snapshot.data![index].date,style: const TextStyle(color: Colors.white, fontSize: 14)) : const SizedBox.shrink()
                                                      ],
                                                    ),
                                                  ),
                                                )


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
                  const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Последние новости', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                    ),
                  const SizedBox(height: 15,),
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
                            padding: const EdgeInsets.symmetric(horizontal: 13),
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
                                                      child: SizedBox(
                                                        width: 90,
                                                        height: 90,
                                                        child: ClipPolygon(
                                                          sides: 6,
                                                          borderRadius: 10,
                                                          child: Image.network(
                                                            snapshot.data![index].pictureUrl,
                                                            fit: BoxFit.cover,
                                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                                                                if(loadingProgress == null) return child;
                                                                return const SizedBox(
                                                                  width: 90,
                                                                  height: 90,
                                                                  child: SkeletonLine(
                                                                    style: SkeletonLineStyle(
                                                                        width: 90,
                                                                        height: 90
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                  const Padding(padding: EdgeInsets.only(right: 10)),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                         snapshot.data![index].name[0].toUpperCase() + snapshot.data![index].name.substring(1, snapshot.data![index].name.length),
                                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                                        ),
                                                        Text(
                                                            '${NewsFunc.cutString(snapshot.data![index].text, snapshot.data![index].text.length < 50 ? snapshot.data![index].text.length : 50)}...'
                                                          //style: TextStyle(fontSize: 14),
                                                        ),
                                                        snapshot.data![index].date.isNotEmpty ? Text(snapshot.data![index].date, style: TextStyle(height: 1.6)) : SizedBox.shrink()
                                                      ],
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
                                          const SizedBox(height: 15,)
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
                          return ListView.builder(
                            itemCount: 5,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:  Row(
                                  children: [
                                    const SizedBox(width: 10,),

                                    const SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: ClipPolygon(
                                        sides: 6,
                                        borderRadius: 10,
                                        child: SkeletonLine(
                                          style: SkeletonLineStyle(
                                              width: 90,
                                              height: 90,
                                              //borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.only(left: 8, bottom: 3),
                                              child: SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  randomLength: true,
                                                  height: 14
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8, bottom: 3),
                                              child: SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    randomLength: true,
                                                    height: 14
                                                ),
                                              ),
                                            ),
                                            Padding(
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

                                    //IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                                  ],
                                ),
                              );
                            },
                          );



                        }
                      },
                    ),
                  const SizedBox(height: 20,)

                ]
            ),
          ),
        )
      );
  }
}
