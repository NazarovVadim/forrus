import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:forrus/funcs/newsFuncs.dart';
import 'package:forrus/pages/detailNewsPage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),

            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailNewsPage(
                              title: 'Пример названия новости',
                              describe: 'Я очень горжусь тем фактом, что карточный автомат убил KFC согласно загадочному плану, и у него закончились боеприпасы и еда.',
                              date: '08 янв 2020',
                              picturePath: 'assets/images/1img.jpg',
                              heroTag: 'first important news',
                            ),
                          ),
                        );
                      },
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
                            tag: 'first important news',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                  'assets/images/1img.jpg',
                                  width: 300,
                                  fit: BoxFit.cover,
                                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                                  colorBlendMode: BlendMode.modulate
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Пример названия новости', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
                                Text('08 янв 2020',style: TextStyle(color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailNewsPage(
                              title: 'Пример названия новости',
                              describe: 'Я очень горжусь тем фактом, что карточный автомат убил KFC согласно загадочному плану, и у него закончились боеприпасы и еда.',
                              date: '08 янв 2020',
                              picturePath: 'assets/images/1img.jpg',
                              heroTag: 'second important news',
                            ),
                          ),
                        );
                      },
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
                            tag: 'second important news',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                  'assets/images/1img.jpg',
                                  width: 300,
                                  fit: BoxFit.cover,
                                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                                  colorBlendMode: BlendMode.modulate
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Пример названия новости', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
                                Text('08 янв 2020',style: TextStyle(color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                  ],
                )
            ),




            //builder

            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: FutureBuilder<ImportantNews>(
            //     future: loadJson(),
            //     builder: (context, snapshot){
            //
            //       if(snapshot.hasData){
            //         if(ImportantNews.index % 2 != 0){
            //           ImportantNews.index++;
            //           return Stack(
            //             alignment: Alignment.bottomLeft,
            //             children: <Widget>[
            //               Container(
            //
            //                 width: 300,
            //                 height: 200,
            //                 //color: Colors.black,
            //                 decoration: const BoxDecoration(
            //                   borderRadius: BorderRadius.all(Radius.circular(25)),
            //                   gradient:  LinearGradient(
            //                     begin: Alignment.topCenter,
            //                     end: Alignment.bottomCenter,
            //                     colors: [
            //                       Color.fromRGBO(0, 0, 0, 0.4),
            //                       Color.fromRGBO(0, 0, 0, 0.9)
            //                     ],
            //                   ),
            //                   //image: DecorationImage(image: Image.asset('assets/images/1img.jpg'))
            //                 ),
            //               ),
            //               ClipRRect(
            //                 borderRadius: BorderRadius.circular(25),
            //                 child: Image.asset(
            //                     snapshot.data!.picturePath,
            //                     width: 300,
            //                     fit: BoxFit.cover,
            //                     color: const Color.fromRGBO(255, 255, 255, 0.5),
            //                     colorBlendMode: BlendMode.modulate
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 20, bottom: 20),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(snapshot.data!.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
            //                     Text(snapshot.data!.date,style: TextStyle(color: Colors.white, fontSize: 14))
            //                   ],
            //                 ),
            //               ),
            //
            //
            //             ],
            //           );
            //         } else{
            //           ImportantNews.index++;
            //           return const Padding(padding: EdgeInsets.only(left: 10));
            //         }
            //
            //       } else if (snapshot.hasError) {
            //         return Text("${snapshot.error}");
            //       }
            //       return const CircularProgressIndicator();
            //     },
            //   ),
            // ),



            Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Последнее', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailNewsPage(
                                title: 'Пример названия новости в списке',
                                describe: 'Я очень горжусь тем фактом, что карточный автомат убил KFC согласно загадочному плану, и у него закончились боеприпасы и еда.',
                                picturePath: 'assets/images/2img.jpg',
                                date: '10 дек 2020',
                                heroTag: 'first latest news',
                            ),
                            )
                            );
                      },
                      child: Row(
                        children: [
                          Hero(
                            tag: 'first latest news',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/2img.jpg',
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
                                      const TextSpan(
                                        text:'Пример названия новости в списке \n',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                          text: '${NewsFunc.cutString('Я очень горжусь тем фактом, что карточный автомат убил KFC согласно загадочному плану, и у него закончились боеприпасы и еда.', 65)}...\n'
                                        //style: TextStyle(fontSize: 14),
                                      ),
                                      const TextSpan(text: '10 дек 2020')
                                    ]
                                )
                            ),
                          ),

                          IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),




                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
