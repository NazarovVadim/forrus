import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddButton();
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: StyleLibrary.color.primary,
        child: InkWell(
          onTap: (){},
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

