import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:forrus/funcs/create_ticket.dart';
import 'package:forrus/funcs/select_files.dart';
import 'package:forrus/models/ticket_error.dart';
import 'package:forrus/models/ticket_model.dart';
import 'package:forrus/tools/compressor/compressor.dart';
import 'package:forrus/widgets/dialogs.dart';
import 'dart:io';
import 'package:video_compress/video_compress.dart';

class FormPageProvider with ChangeNotifier{
  String? title;
  String? name;
  String? contact;
  String? comment;
  List<File> files = [];
  bool waitStatus = false;
  bool loadStatus = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController commentController = TextEditingController();

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
  void onChangeFiles(List<File> value){
    files = value;
    notifyListeners();
  }

  bool notNull(){
    return (title != null && name != null && contact != null && comment != null)
        && (title!.isNotEmpty && name!.isNotEmpty && contact!.isNotEmpty && comment!.isNotEmpty);
  }
  void clear(){
    titleController.clear();
    nameController.clear();
    contactController.clear();
    commentController.clear();
    title = null;
    name = null;
    contact = null;
    comment = null;
    files = [];
  }

  void enableWaitStatus(){
    waitStatus = true;
    notifyListeners();
  }

  void disableWaitStatus(){
    waitStatus = false;
    notifyListeners();
  }

  void enableLoadStatus(){
    loadStatus = true;
    notifyListeners();
  }

  void disableLoadStatus(){
    loadStatus = false;
    notifyListeners();
  }

  Future<List<File>> onAddFiles(BuildContext context) async{
    enableLoadStatus();
    try{
      var files = await selectFiles();
      if(!VideoCompress.isCompressing){
        disableLoadStatus();
      }
      return files;
    }catch(exception, strc){
      print(strc);
      print("Ошибка $exception");
      if(VideoCompress.isCompressing){
        showErrorDialog(context, "Необходимо дождаться загрузки видео !");
      }else{
        disableLoadStatus();
      }
      rethrow;
    }



  }

  Future<void> onSend(BuildContext context) async{
    enableWaitStatus();
    try{
      await createTicket(TicketModel(
        title: title!,
        name: name!,
        contact: contact!,
        description: comment!,
        files: files,
      ));
      await showSuccessDialog(context, 'Зявка отправлена');
      Compressor.clear();
      clear();
    }catch(exception, strc){
      if(exception is TicketError){
        showErrorDialog(context, exception.toString());
      }
      else{
        await showErrorDialog(context, "Что-то пошло не так");
      }
    }
    disableWaitStatus();
  }


}