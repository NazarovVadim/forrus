import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';
import 'package:forrus/widgets/file_picker_widget.dart';
import 'package:forrus/widgets/form_field_widget.dart';

class FormPage extends StatelessWidget {
   const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: StyleLibrary.padding.allContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Создание заявки", style: StyleLibrary.font.header),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Заголовок",
              isOutlineBorder: false,
              onChange: (value) {
                print(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Ваше имя",
              isOutlineBorder: false,
              onChange: (value) {
                print(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Телефон или email",
              isOutlineBorder: false,
              onChange: (value) {
                print(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Комментарий к заявке",
              lines: 6,
              isOutlineBorder: true,
              onChange: (value) {
                print(value);
              },
            ),
             StyleLibrary.padding.contentDivider,
             FilePickerWidget()
          ],
          ),
        ),
      )
    );
  }
}

