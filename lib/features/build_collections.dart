import 'dart:io';

import './read_folder_name.dart';
import '../core/extensions/string_extensions.dart';

// "E:\Node\e-commerce\src\addresses\controller\addresses.controller.js"
class BuildCollections {
  static void buildCollection() async {
    // Read controller folder
    String folderPath = ReadFolderName.readFolderName();

    // get sub file from controller folder
    List<FileSystemEntity> subFiles = ReadFolderName.listFiles(folderPath);

    for (var i in subFiles) {
      String file = i.toString().replaceAll("File: '", "");
      file = file.replaceAll("'", "");
      File file2 = File(file);
      String content = await file2.readAsString();
      List<String> contentsList = content.split("\n");
      String desc = "";
      String route = "";
      String params = "";
      String body = "";
      String header = "";
      String access = "";
      for (String j in contentsList) {
        if (j.startsWith("// @")) {
          if (j.startsWith("// @desc")) {
            desc = j.replaceAll("// @desc", "").removeFirstSpaces();
          } else if (j.startsWith("// @route")) {
            route = j.replaceAll("// @route", "").removeFirstSpaces();
          } else if (j.startsWith("// @param")) {
            params = j.replaceAll("// @param", "").removeFirstSpaces();
          } else if (j.startsWith("// @body")) {
            body = j.replaceAll("// @body", "").removeFirstSpaces();
          } else if (j.startsWith("// @header")) {
            header = j.replaceAll("// @header", "").removeFirstSpaces();
          } else if (j.startsWith("// @access")) {
            access = j.replaceAll("// @access", "").removeFirstSpaces();
          }
        }

        if (j.startsWith("exports.")) {
          print("DESC : $desc");
          print("route : $route");
          print("params : $params");
          print("body : $body");
          print("header : $header");
          print("access : $access");
          print("Start new method\n\n");
        }
      }
    }
  }
}
