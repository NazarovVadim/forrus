import 'package:file_picker/file_picker.dart';

Future<FilePickerResult> selectFiles() async{
  var files = await FilePicker.platform.pickFiles(
      allowMultiple: true,
  );
  if(files != null){
    return files;
  }else{
    throw "Файлы не выбраны";
  }
}