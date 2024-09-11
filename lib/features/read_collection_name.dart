import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/info_model.dart';

class ReadCollectionName {
  static InfoModel readCollectionName() {
    InfoModel infoModel = InfoModel(collectionName: "", baseUrl: "");
    while (infoModel.collectionName.isEmpty) {
      stdout.write("Enter name for API collection : ");
      infoModel.collectionName = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
              "😢 Collection name cannot be empty !!");
    }

    while (infoModel.baseUrl.isEmpty) {
      stdout.write(
          "Enter the base url of routes [ We will added it automatically in variable collection ] : ");
      infoModel.baseUrl = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage("😢 Base url cannot be empty !!");
    }

    return infoModel;
  }
}
