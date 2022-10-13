import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../funcs/getAPI.dart';

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
          backgroundColor: const Color.fromARGB(255, 244, 198, 6),
          title: Image.asset('assets/images/logo_black.png', width: 150,),
          centerTitle: true,
          elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Image.asset('assets/images/bg2.png', width: double.infinity,),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
              child: FutureBuilder<List<News>>(
                future: futureDetail,
                builder: (context, snapshot){
                  // Future<void>.delayed(const Duration(seconds: 2));
                  if(snapshot.hasData){
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          Hero(
                            tag: id,
                            child: ClipRRect(

                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  width: 300,
                                  child: Image.network(
                                      snapshot.data![0].pictureUrl,
                                      width: 300,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress){
                                        if(loadingProgress == null) return child;
                                        return const SkeletonLine(
                                          style: SkeletonLineStyle(
                                              width: 300,
                                              height: 200
                                          ),
                                        );
                                      }
                                    // color: const Color.fromRGBO(255, 255, 255, 0.5),
                                    // colorBlendMode: BlendMode.modulate
                                  ),
                                )
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                width: 300,
                                child: Text(snapshot.data![0].name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 26),),
                              )
                          ),
                          snapshot.data![0].date.isNotEmpty ?
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: 300,
                              child: Text(snapshot.data![0].date, style: const TextStyle(color: Colors.grey, fontSize: 16),),
                            ),
                          ) : const SizedBox.shrink(),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                width: 300,
                                child: Text.rich(
                                    TextSpan(
                                        children:[
                                          TextSpan(
                                            text: snapshot.data![0].text,
                                            style: const TextStyle(fontSize: 18),
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
                      ),
                    );
                  } else{
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              alignment: Alignment.center,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 300,
                                    height: 200,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                            const SizedBox(
                              width: 300,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 300,
                                  height: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6,),
                            const SizedBox(
                              width: 300,
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 150,
                                  height: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                           SizedBox(
                             width: 300,
                             child:  ListView.builder(
                               itemCount: 10,
                               shrinkWrap: true,
                               itemBuilder: (BuildContext context, int index){
                                 return const SkeletonLine(
                                     style: SkeletonLineStyle(
                                         padding: EdgeInsets.only(bottom: 8),
                                         width: 300,
                                         height: 15
                                     ),
                                   );
                               },
                             ),
                           )
                          ],
                        ),
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
