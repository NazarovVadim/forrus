import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class TicketModel{
  String title;
  String name;
  String contact;
  String description;
  List<PlatformFile>? files;

  TicketModel({
    required this.title,
    required this.name,
    required this.contact,
    required this.description,
    this.files});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      title: json["title"],
      name: json["name"],
      contact: json["contact"],
      description: json["description"],
      files: List.of(json["files"])
          .map((i) => PlatformFile.fromMap(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson()  {

    return {
      "TITLE": title,
      "NAME": name,
      "CONTACT": contact,
      "DESCRIPTION": description,
      "file[]": (files != null) ?  List.of(files!).map((file)  => base64Encode( (File(file.path!).readAsBytesSync()))).toList() : "",
      "fileName[]": (files != null) ? List.of(files!).map((file) => file.name).toList() : "",
    };
  }

//

}