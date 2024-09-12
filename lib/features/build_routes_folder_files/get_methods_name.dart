/*
[
  name : address
  data : []
]
*/

import 'dart:io';

import '../../core/model/methods_name_model.dart';
import '../../core/utils/read_controllers_path.dart';

class GetMethodsName {
  static Future<List<MethodsNameModel>> getMethodsName(
      String folderPath) async {
    List<MethodsNameModel> methodName = [];
    List<FileSystemEntity> allFilesInDir =
        ReadControllersPath.listFilesFromPath(folderPath);

    for (var i in allFilesInDir) {
      methodName.add(await _getMethods(i));
    }
    return methodName;
  }

  static Future<MethodsNameModel> _getMethods(
      FileSystemEntity fileSystemEntity) async {
    MethodsNameModel methodsNameModel = MethodsNameModel();
    String file = fileSystemEntity.toString().replaceAll("File: '", "");
    file = file.replaceAll("'", "");
    File file2 = File(file);

    if (fileSystemEntity.toString().toLowerCase().startsWith("file")) {
      String content = await file2.readAsString();
      List<String> contentsList = content.split("\n");
      List<String> methods = [];
      methodsNameModel.folderName =
          (file.split("\\")[file.split("\\").length - 1]).split(".")[0];
      for (var value in contentsList) {
        if (value.startsWith("exports.")) {
          methods.add(value.replaceFirst("exports.", "").split("=")[0].trim());
        }
      }
      methodsNameModel.methodsName = methods;
    }
    return methodsNameModel;
  }
}
