import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forrus/providers/form_page_provider.dart';
import 'package:forrus/styles/style_library.dart';
import 'package:forrus/tools/compressor/compressor.dart';
import 'package:forrus/widgets/custom_button.dart';
import 'package:forrus/widgets/file_picker_widget.dart';
import 'package:forrus/widgets/form_field_widget.dart';
import 'package:provider/provider.dart';
import '../funcs/delete_files_by_name.dart';
import 'dart:io';

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
              controller: state.titleController,
              label: "Заголовок*",
              isOutlineBorder: false,
              onChange: (value) {
                state.onChangeTitle(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              controller: state.nameController,
              label: "Ваше имя*",
              isOutlineBorder: false,
              onChange: (value) {
                state.onChangeName(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              controller: state.contactController,
              label: "Телефон или email*",
              isOutlineBorder: false,
              onChange: (value) {
               state.onChangeContact(value);
              },
            ),
            StyleLibrary.padding.contentDivider,
            StyleLibrary.padding.contentDivider,
            FormFieldWidget(
              controller: state.commentController,
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
             },
             onAdd: () => state.onAddFiles(context),
             ),
              StyleLibrary.padding.contentDivider,
              (!state.waitStatus) ? CustomButton(
                  title: "Отправить",
                  onTap: (state.notNull() && !state.loadStatus)
                      ? () async => await state.onSend(context)
                      : null
              ) : WaitButton(),
          ],
          ),
        ),
      )
    );
  }
}
class FileFormField extends StatefulWidget {
  const FileFormField({Key? key, required this.onChange, required this.onAdd}) : super(key: key);

  final Function(List<File> files) onChange;
  final Function() onAdd;

  @override
  State<FileFormField> createState() => _FileFormFieldState();
}

class _FileFormFieldState extends State<FileFormField> {



  @override
  Widget build(BuildContext context) {

    List<File> contentFiles = context.watch<FormPageProvider>().files;

    var state = context.watch<FormPageProvider>();

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
                itemCount: contentFiles.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ImageContainer(file: contentFiles[index], onTap: (file){
                     setState(() {
                       contentFiles = deleteFileByName(contentFiles, Compressor.getFileNameFromPath(path: file.path));
                     });
                     widget.onChange(contentFiles);
                    }),
                  );
                }
            ),
          ),
          (state.loadStatus) ? Padding(
            padding: StyleLibrary.padding.onlyHorizontalPadding,
            child: const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(color: Colors.black,)
            ),
          ) : const SizedBox(),
          FilePickerWidget(onSave: (files) {
            setState(() {
               contentFiles.addAll(files);
            });
            widget.onChange(contentFiles);
          },
          onTap: widget.onAdd,
          )
        ],
      ),
    );
  }
}


