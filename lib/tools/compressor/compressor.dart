import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:forrus/tools/compressor/errors/directory_error.dart';
import 'package:forrus/tools/compressor/errors/file_error.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:video_compress/video_compress.dart';


enum Folders {imageCompress, videoCompress, allCompress}

class Compressor{

  static Future<File> compressImage({required File file, required String name}) async{

    var targetDirectory = await _getDirectory(folder: Folders.imageCompress);

    try{
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        '${targetDirectory.path}/$name.${getFileFormat(path: file.path)}',
        quality: 20,
      );
      if(result != null){return result;}
      throw FileError(message: "Пустой файл");

    }catch(e){
      rethrow;
    }

  }
  static Future<File> compressVideo({required File file, required String name}) async{

    try{
      var mediaInfo = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.LowQuality,
      );
      var compressFile =  await(_saveFile(file: mediaInfo!.file!, name: name, folder: Folders.videoCompress));
      VideoCompress.deleteAllCache();
      return compressFile;

    }catch(exception){
      rethrow;
    }

  }

  static Future<List<File>> compressAllFiles({required List<PlatformFile> files}) async{

    List<File> result = [];

    for(var file in files){

      var format = getFileFormat(path: file.path!);

      if(format.toLowerCase() == 'mp4' || format.toLowerCase() == 'mov' || format.toLowerCase() == 'avi'){
       var compressFile = await compressVideo(file: File(file.path!), name: file.name);
       result.add(compressFile);
      }else if(format.toLowerCase() == 'jpg' || format.toLowerCase() == 'jpeg' || format.toLowerCase() == 'png'){
        var compressFile = await compressImage(file: File(file.path!), name: file.name);
        result.add(compressFile);
      }else{
        result.add(File(file.path!));
      }
    }

    return result;
  }




  static Future<Directory> _getDirectory({Folders folder = Folders.allCompress}) async{

    var tempDirectory = await path.getExternalStorageDirectory();

    if(tempDirectory != null){
      var directory =  await Directory(
          "${tempDirectory.path.replaceAll('/storage/emulated/0', 'sdcard')}/${folder.name}")
          .create();
      return directory;
    }else{
       throw DirectoryError(message: "Не удалось получить путь для файлов");
    }
  }

  static Future<File> _saveFile({required File file, String? name, Folders folder = Folders.allCompress}) async{

    name ??= getFileNameFromPath(path: file.path);

    var directory = await _getDirectory(folder: folder);
    return file.copy('${directory.path}/$name');

  }

  static String getFileNameFromPath({required String path}){
    return path.split('/').last;
  }

  static String getFileFormat({required String path}){
    return path.split('.').last;
  }

  static Future<void> clear() async{
   var directory = await _getDirectory();
   directory.delete(recursive: true);
   directory = await _getDirectory(folder: Folders.videoCompress);
   directory.delete(recursive: true);
   directory = await _getDirectory(folder: Folders.imageCompress);
   directory.delete(recursive: true);
  }

}