import 'dart:io';
import 'package:forrus/tools/compressor/compressor.dart';

List<File> deleteFileByName(List<File> files, String name){

  int? selectFileIndex;

  for(int i=0; i<files.length; i++){

    var checkName = Compressor.getFileNameFromPath(path: files[i].path);
    if(checkName == name){
      selectFileIndex = i;
      break;
    }
  }
  if(selectFileIndex != null){
    files.removeAt(selectFileIndex);
  }

  return files;

}