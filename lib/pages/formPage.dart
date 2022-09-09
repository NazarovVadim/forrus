import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';
// import '../funcs/newsFuncs.dart';
// import "package:images_picker/images_picker.dart";
//
// class FormPage extends StatefulWidget {
//   const FormPage({Key? key}) : super(key: key);
//
//   @override
//   State<FormPage> createState() => _FormPageState();
// }
//
// class _FormPageState extends State<FormPage> {
//   final _formKey = GlobalKey<FormState>();
//
//
//   final _nameTextController = TextEditingController();
//   final _contactTextController = TextEditingController();
//   final _commentTextController = TextEditingController();
//
//
//   final _focusName = FocusNode();
//   final _focusContact = FocusNode();
//   final _focusComment = FocusNode();
//
//
//
//
//   static const dropdownItems = <String>[
//     'Артефакты на экране/мониторе (некорректное изображение)',
//     'Другое...',
//     'Материнская плата',
//     'Нет звука',
//     'Нет изображения на экране/мониторе',
//     'Нет реакции на подключение USB устройства',
//     'Устройство зависает во время работы',
//     'Устройство не реагирует на кнопку включения',
//     'Устройство перезагружается во время работы',
//     'Произвольная заявка'
//   ];
//
//   final List<DropdownMenuItem<String>> _dropdownMenuItems = dropdownItems.map(
//           (String value) => DropdownMenuItem(value: value,  child: Text(value)),
//   ).toList();
//   String defaultDropdownHint = NewsFunc.cutString(dropdownItems[0], 29);
//   String? path;
//   String? path2;
//   String? path3;
//   String? path4;
//   String? defaultDropdownValue = dropdownItems[1];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         _focusComment.unfocus();
//         _focusContact.unfocus();
//         _focusName.unfocus();
//       },
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 15, bottom: 15),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Container(
//                 width: 320,
//                 color: const Color.fromRGBO(233, 236, 239, 1),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text( 'Создание заявки', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Padding(padding: EdgeInsets.only(top: 10)),
//                             const Text('Укажите заголовок заявки:', style: TextStyle(fontSize: 16,)),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             DropdownButtonFormField(
//                               items: _dropdownMenuItems,
//                               isExpanded: true,
//                               //value: defaultDropdownValue,
//                               hint: Text(defaultDropdownHint),
//                               decoration: InputDecoration(
//                                 //hintText: defaultDropdownHint,
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6),
//
//                                 ),
//                               ),
//                               onChanged: (String? newValue){
//                                 if(newValue!= null){
//                                   setState((){
//                                     defaultDropdownValue = newValue;
//                                   });
//                                 }
//                               },
//                             ),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             const Text('Укажите ФИО *:', style: TextStyle(fontSize: 16,)),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             TextFormField(
//                               controller: _nameTextController,
//                               focusNode: _focusName,
//                               decoration: InputDecoration(
//                                 hintText: 'Введите Ваше имя...',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6),
//
//                                 ),
//
//                               ),
//                             ),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             const Text('Укажите Контакт по которому с Вами могут связаться', style: TextStyle(fontSize: 16,)),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             TextFormField(
//                               controller: _contactTextController,
//                               focusNode: _focusContact,
//                               decoration: InputDecoration(
//                                 hintText: 'Введите телефон или e-mail...',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6),
//
//                                 ),
//
//                               ),
//                             ),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             const Text('Укажите комментарий к заявке *:', style: TextStyle(fontSize: 16,)),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             TextFormField(
//                               controller: _commentTextController,
//                               focusNode: _focusComment,
//                               maxLines: 7,
//                               textCapitalization: TextCapitalization.sentences,
//                               decoration: InputDecoration(
//                                 hintText: 'Укажите серийный номер устройства',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding: const EdgeInsets.only(top: 20, left: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6),
//
//                                 ),
//
//                               ),
//                             ),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             const Text('Файлы к заявке:', style: TextStyle(fontSize: 16,)),
//
//
//
//                             path != null ? Container(
//                               height: 70,
//                               child: Image.file(File(path!), fit: BoxFit.contain,)
//                             ) :  OutlinedButton(
//                                 onPressed: ()async{
//                                   List<Media>? res = await ImagesPicker.pick(
//                                     count: 1,
//                                     pickType: PickType.all,
//                                     language: Language.English,
//                                     maxTime: 30,
//                                     cropOpt: CropOption(cropType: CropType.rect),
//                                   );
//                                   if(res != null){
//                                     setState((){
//                                       path = res[0].thumbPath;
//                                     });
//                                   }
//                                 },
//                                 child: const Text('Выбрать файл', style: TextStyle(fontSize: 16, color: Color.fromRGBO(54, 39, 39, 1)),)
//                             ),
//
//                             path2 != null ? Container(
//                                 height: 70,
//                                 child: Image.file(File(path2!), fit: BoxFit.contain,)
//                             ) :  OutlinedButton(
//                                 onPressed: ()async{
//                                   List<Media>? res = await ImagesPicker.pick(
//                                     count: 1,
//                                     pickType: PickType.all,
//                                     language: Language.English,
//                                     maxTime: 30,
//                                     cropOpt: CropOption(cropType: CropType.rect),
//                                   );
//                                   if(res != null){
//                                     setState((){
//                                       path2 = res[0].thumbPath;
//                                     });
//                                   }
//                                 },
//                                 child: const Text('Выбрать файл', style: TextStyle(fontSize: 16, color: Color.fromRGBO(54, 39, 39, 1)),)
//                             ),
//
//                             path3 != null ? Container(
//                                 height: 70,
//                                 child: Image.file(File(path3!), fit: BoxFit.contain,)
//                             ) :  OutlinedButton(
//                                 onPressed: ()async{
//                                   List<Media>? res = await ImagesPicker.pick(
//                                     count: 1,
//                                     pickType: PickType.all,
//                                     language: Language.English,
//                                     maxTime: 30,
//                                     cropOpt: CropOption(cropType: CropType.rect),
//                                   );
//                                   if(res != null){
//                                     setState((){
//                                       path3 = res[0].thumbPath;
//                                     });
//                                   }
//                                 },
//                                 child: const Text('Выбрать файл', style: TextStyle(fontSize: 16, color: Color.fromRGBO(54, 39, 39, 1)),)
//                             ),
//
//                             path4 != null ? Container(
//                                 height: 70,
//                                 child: Image.file(File(path4!), fit: BoxFit.contain,)
//                             ) :  OutlinedButton(
//                                 onPressed: ()async{
//                                   List<Media>? res = await ImagesPicker.pick(
//                                     count: 1,
//                                     pickType: PickType.all,
//                                     language: Language.English,
//                                     maxTime: 30,
//                                     cropOpt: CropOption(cropType: CropType.rect),
//                                   );
//                                   if(res != null){
//                                     setState((){
//                                       path4 = res[0].thumbPath;
//                                     });
//                                   }
//                                 },
//                                 child: const Text('Выбрать файл', style: TextStyle(fontSize: 16, color: Color.fromRGBO(54, 39, 39, 1)),)
//                             ),
//
//                             path != null ||
//                             path2!= null ||
//                             path3!= null ||
//                             path4!=null ? OutlinedButton(
//                                 onPressed: (){
//                                   setState((){
//                                     path = null;
//                                     path2 = null;
//                                     path3 = null;
//                                     path4 = null;
//                                   });
//                                 },
//                                 child: const Text('Очистить', style: TextStyle(fontSize: 16, color: Color.fromRGBO(54, 39, 39, 1)),)
//                             ) : const SizedBox.shrink(),
//
//
//
//
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//
//                             const Text('* - Обязательно заполните', style: TextStyle(fontSize: 16,)),
//                             const Padding(padding: EdgeInsets.only(top: 8)),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 OutlinedButton(
//                                   onPressed: (){},
//                                   style: ElevatedButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//
//                                   ),
//                                   child: const Text(
//                                       'Отменить',
//                                       style: TextStyle(fontSize: 21, color: Colors.black)
//                                   ),
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: (){},
//                                     style: ElevatedButton.styleFrom(
//                                         primary: const Color.fromRGBO(244, 198, 6, 1),
//                                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
//                                     ),
//                                     child: const Text(
//                                         'Отправить',
//                                         style: TextStyle(fontSize: 21,)
//                                     )
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }



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
          const Center(
            child: CircularProgressIndicator(
              //color: Color.fromRGBO(244, 198, 6, 1),
              color: Color.fromRGBO(29, 31, 38, 1),
            ),
          )
        ],
      ),
    );
  }
}

