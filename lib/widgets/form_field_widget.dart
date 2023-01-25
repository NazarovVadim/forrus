import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({Key? key, required this.label, this.lines, required this.isOutlineBorder, required this.onChange}) : super(key: key);

  final String label;
  final int? lines;
  final bool isOutlineBorder;
  final Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: lines,
      maxLines: (lines != null) ? 10 : null,
      cursorColor: StyleLibrary.color.primary,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: StyleLibrary.padding.fieldPadding,
        fillColor: StyleLibrary.color.primary,
        focusColor: StyleLibrary.color.primary,
        focusedBorder: (!isOutlineBorder) ? UnderlineInputBorder(
          borderSide:  BorderSide(color: StyleLibrary.color.primary, width: 3))
            : OutlineInputBorder(borderSide:  BorderSide(color: StyleLibrary.color.primary, width: 3)),
        enabledBorder: (!isOutlineBorder) ? const UnderlineInputBorder(
          borderSide:  BorderSide(color: Colors.black, width: 1.5),
        ) : const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black, width: 1)),
        //labelText: label,
        labelStyle: StyleLibrary.font.body.copyWith(
          color: Colors.grey,
        ),
        label: Text(label,),
        floatingLabelStyle: StyleLibrary.font.body.copyWith(
          color: Colors.grey,
        ),
        alignLabelWithHint: true
      ),
      style: StyleLibrary.font.body,
      onChanged: onChange,

    );
  }
}
