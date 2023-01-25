import 'package:flutter/material.dart';
import 'package:forrus/funcs/select_files.dart';
import 'package:forrus/styles/style_library.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({Key? key, required this.onSave}) : super(key: key);

  final Function(List<PlatformFile> files) onSave;

  @override
  Widget build(BuildContext context) {
    return AddButton(
      onSave: (files){
        onSave(files.files);
      },
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onSave}) : super(key: key);

  final Function(FilePickerResult files) onSave;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: StyleLibrary.color.primary,
        child: InkWell(
          onTap: ()  async => onSave(await selectFiles()),
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Icon(Icons.add, color: Colors.black,),
          ),
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.file, required this.onTap}) : super(key: key);

  final PlatformFile file;
  final Function(PlatformFile file) onTap;

  @override
  Widget build(BuildContext context) {
    print(file.extension);
    return Stack(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child:  (file.extension == "jpg" ||
              file.extension == "jpeg" ||
              file.extension == "png")
              ? Image.file(File(file.path!), fit: BoxFit.cover,)
              : Column(
            children: [
              Expanded(child: Icon(Icons.file_copy_outlined, )),
              Text(file.name, style: StyleLibrary.font.small,)
            ],
          )
        ),
        Positioned(
          right: 0,
          top: 0,
          child: ClipOval(
            child: Container(
                color: Colors.white,
                child: Material(
                    child: InkWell(
                        onTap: (){
                          onTap(file);
                        },
                        child: Icon(Icons.close, size: 20,)))),
          ),
        ),
      ],
    );
  }
}



