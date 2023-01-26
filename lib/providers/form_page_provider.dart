import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:forrus/funcs/create_ticket.dart';
import 'package:forrus/models/ticket_model.dart';
import 'package:forrus/widgets/dialogs.dart';

class FormPageProvider with ChangeNotifier{
  String? title;
  String? name;
  String? contact;
  String? comment;
  List<PlatformFile> files = [];
  bool waitStatus = false;

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
  void onChangeFiles(List<PlatformFile> value){
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
      clear();
    }catch(exception, strc){
      print(exception);
      print(strc);
      await showErrorDialog(context, "Что-то пошло не так");
    }
    disableWaitStatus();
  }


}