import 'package:file_picker/file_picker.dart';
import 'package:forrus/tools/compressor/compressor.dart';
import 'dart:io';

Future<List<File>> selectFiles() async{
  var files = await FilePicker.platform.pickFiles(
      allowMultiple: true,
  );

  if(files != null){
    return await Compressor.compressAllFiles(files: files.files);
  }else{
    throw "Файлы не выбраны";
  }
}