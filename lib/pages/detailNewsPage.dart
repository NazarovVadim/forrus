import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../funcs/getAPI.dart';
import '../funcs/newsFuncs.dart';

class DetailNewsPage extends StatefulWidget {
  final String id;




  const DetailNewsPage({Key? key, required this.id}) : super(key: key);


  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  late final String id;
  late Future<List<News>> futureDetail;
  @override
  void initState(){
    super.initState();
    id = widget.id;
    futureDetail = fetchDetailNews(id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 244, 198, 6),
          title: Image.asset('assets/images/logo_black.png', width: 150,),
          centerTitle: true,
          elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset('assets/images/bg2.png', width: double.infinity,),
          SingleChildScrollView(
              child: FutureBuilder<List<News>>(
                future: futureDetail,
                builder: (context, snapshot){
                  // Future<void>.delayed(const Duration(seconds: 2));
                  if(snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Hero(
                          tag: id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),

                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              child: Image.network(
                                snapshot.data![0].pictureUrl,
                                width: 350,
                                fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress){
                                    if(loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey,
                                      height: 200,
                                      width: 350,
                                    );
                                  }
                                // color: const Color.fromRGBO(255, 255, 255, 0.5),
                                // colorBlendMode: BlendMode.modulate
                              ),
                            )
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30, left: 30),
                            child: Container(
                              width: double.infinity,
                              child: Text(snapshot.data![0].name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 26),),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 30),
                          child: Container(
                            width: double.infinity,
                            child: Text(snapshot.data![0].date, style: const TextStyle(color: Colors.grey, fontSize: 16),),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                            child: Container(
                              width: double.infinity,
                              child: Text.rich(
                                  TextSpan(
                                      children:[
                                        TextSpan(
                                          text: snapshot.data![0].text,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ]
                                  )
                              ),
                            )
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                        )

                      ],
                    );
                  } else{
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 350,
                                  height: 250,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 300,
                                height: 15,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 150,
                                height: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SkeletonParagraph(
                              style: const SkeletonParagraphStyle(
                                  lines: 8,
                                  spacing: 8,
                                  lineStyle: SkeletonLineStyle(
                                      height: 15,
                                      width: 350
                                  )
                              ),
                            ),

                          )
                        ],
                      ),
                    );
                  }

                },
              )
          )
        ],
      )

      );
  }
}
