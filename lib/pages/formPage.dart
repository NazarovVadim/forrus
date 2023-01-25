import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forrus/providers/form_page_provider.dart';
import 'package:forrus/styles/style_library.dart';
import 'package:forrus/widgets/custom_button.dart';
import 'package:forrus/widgets/file_picker_widget.dart';
import 'package:forrus/widgets/form_field_widget.dart';
import 'package:provider/provider.dart';
import '../funcs/delete_files_by_name.dart';

class FormPage extends StatefulWidget {
   const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  @override
  void initState() {
    context.read<FormPageProvider>().clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var state = context.watch<FormPageProvider>();

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
              label: "Заголовок*",
              isOutlineBorder: false,
              onChange: (value) {
                state.onChangeTitle(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Ваше имя*",
              isOutlineBorder: false,
              onChange: (value) {
                state.onChangeName(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Телефон или email*",
              isOutlineBorder: false,
              onChange: (value) {
               state.onChangeContact(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              label: "Комментарий к заявке*",
              lines: 6,
              isOutlineBorder: true,
              onChange: (value) {
                state.onChangeComment(value);
              },
            ),
             StyleLibrary.padding.contentDivider,
             FileFormField(onChange: (files){
               state.onChangeFiles(files);
             },),
              StyleLibrary.padding.contentDivider,
              CustomButton(
                  title: "Отправить",
                  onTap: (state.notNull())
                      ? () async => await state.onSend()
                      : null
              ),
          ],
          ),
        ),
      )
    );
  }
}
class FileFormField extends StatefulWidget {
  const FileFormField({Key? key, required this.onChange}) : super(key: key);

  final Function(List<PlatformFile> files) onChange;

  @override
  State<FileFormField> createState() => _FileFormFieldState();
}

class _FileFormFieldState extends State<FileFormField> {

  List<PlatformFile> files = [];


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: files.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ImageContainer(file: files[index], onTap: (file){
                     setState(() {
                       files = deleteFileByName(files, file.name);
                     });
                     widget.onChange(files);
                    }),
                  );
                }
            ),
          ),
          FilePickerWidget(onSave: (files){
            setState(() {
              this.files.addAll(files);
            });
            widget.onChange(this.files);
          },)
        ],
      ),
    );
  }
}


