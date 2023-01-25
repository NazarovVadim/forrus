import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class FormPageProvider with ChangeNotifier{
  String? title;
  String? name;
  String? contact;
  String? comment;
  List<PlatformFile> files = [];

  void onChangeTitle(String? value){
    title = value;
    notifyListeners();
  }

  void onChangeName(String? value){
    name = value;
    notifyListeners();
  }

  void onChangeContact(String? value){
    contact = value;
    notifyListeners();
  }

  void onChangeComment(String? value){
    comment = value;
    notifyListeners();
  }
  void onChangeFiles(List<PlatformFile> value){
    files = value;
    notifyListeners();
  }

  bool notNull(){
    return (title != null && name != null && contact != null && comment != null)
        && (title!.isNotEmpty && name!.isNotEmpty && contact!.isNotEmpty && comment!.isNotEmpty);
  }
  void clear(){
    title = null;
    name = null;
    contact = null;
    comment = null;
    files = [];
  }

  Future<void> onSend() async{

  }


}