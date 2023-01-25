import 'package:file_picker/file_picker.dart';

List<PlatformFile> deleteFileByName(List<PlatformFile> files, String name){

  int? selectFileIndex;

  for(int i=0; i<files.length; i++){
    if(files[i].name == name){
      selectFileIndex = i;
      break;
    }
  }
  if(selectFileIndex != null){
    files.removeAt(selectFileIndex);
  }

  return files;

}