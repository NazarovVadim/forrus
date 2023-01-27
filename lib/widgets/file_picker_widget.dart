import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';
import 'dart:io';

import 'package:forrus/tools/compressor/compressor.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({Key? key, required this.onSave, required this.onTap}) : super(key: key);

  final Function(List<File> files) onSave;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AddButton(
      onSave: (files){
        onSave(files);
      },
      onTap: onTap,
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onSave, required this.onTap}) : super(key: key);

  final Function(List<File> files) onSave;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: StyleLibrary.color.primary,
        child: InkWell(
          onTap: ()  async => onSave(await onTap()),
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

  final File file;
  final Function(File file) onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child:  (Compressor.getFileFormat(path: file.path) == "jpg" ||
              Compressor.getFileFormat(path: file.path) == "jpeg" ||
              Compressor.getFileFormat(path: file.path)== "png")
              ? Image.file(File(file.path), fit: BoxFit.cover)
              : Column(
            children: [
              const Expanded(child: Icon(Icons.file_copy_outlined, )),
              Text(Compressor.getFileNameFromPath(path: file.path), style: StyleLibrary.font.small,)
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



