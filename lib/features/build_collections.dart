import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/detail_request_code.dart';
import './read_folder_name.dart';

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
      List<DetailRequestCode> detailsRequests = [];
      DetailRequestCode detailRequestCode = DetailRequestCode();
      for (String j in contentsList) {
        if (j.startsWith("// @")) {
          if (j.startsWith("// @desc")) {
            detailRequestCode.desc =
                j.replaceAll("// @desc", "").removeFirstSpaces();
          } else if (j.startsWith("// @route")) {
            detailRequestCode.route =
                j.replaceAll("// @route", "").removeFirstSpaces();
          } else if (j.startsWith("// @param")) {
            detailRequestCode.params =
                j.replaceAll("// @param", "").removeFirstSpaces();
          } else if (j.startsWith("// @body")) {
            detailRequestCode.body =
                j.replaceAll("// @body", "").removeFirstSpaces();
          } else if (j.startsWith("// @header")) {
            detailRequestCode.header =
                j.replaceAll("// @header", "").removeFirstSpaces();
          } else if (j.startsWith("// @access")) {
            if (j.toLowerCase().contains("privet")) {
              detailRequestCode.access = "privet";
            }else{
              detailRequestCode.access = "public";
            }
          }
        }

        if (j.startsWith("exports.")) {
          detailsRequests.add(detailRequestCode);
          print("Add ${detailRequestCode.desc} Success ");
        }
      }
    }
  }
}
