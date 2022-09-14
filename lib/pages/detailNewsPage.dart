import 'package:flutter/material.dart';

import '../funcs/newsFuncs.dart';

class DetailNewsPage extends StatefulWidget {
  final String title;
  final String describe;
  final String picturePath;
  final String date;
  final String heroTag;


  const DetailNewsPage({Key? key, required this.title, required this.describe, required this.picturePath, required this.date, required this.heroTag}) : super(key: key);


  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  late final String title;
  late final String describe;
  late final String picturePath;
  late final String date;
  late final String heroTag;

  @override
  void initState(){
    super.initState();
    title = widget.title;
    describe = widget.describe;
    picturePath = widget.picturePath;
    date = widget.date;
    heroTag = widget.heroTag;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/forrus.jpg', width: 130,),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(244, 198, 6, 1),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  picturePath,
                  width: 350,
                  fit: BoxFit.cover,
                  // color: const Color.fromRGBO(255, 255, 255, 0.5),
                  // colorBlendMode: BlendMode.modulate
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: 350,
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 26),),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: 350,
                child: Text.rich(
                    TextSpan(
                        children:[
                          TextSpan(
                            text: describe,
                            style: TextStyle(fontSize: 18),
                          ),
                        ]
                    )
                ),
              )
            )

          ],
        ),
      )
    );
  }
}
