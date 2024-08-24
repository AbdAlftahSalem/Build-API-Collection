import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/info_model.dart';

class ReadCollectionName {
  static InfoModel readCollectionName() {
    InfoModel infoModel = InfoModel(collectionName: "");
    String collectionName = '';
    while (collectionName.isEmpty) {
      stdout.write("Enter name for API collection : ");
      collectionName = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
              "😢 Collection name cannot be empty !!");
    }
    infoModel.collectionName = collectionName;

    return infoModel;
  }
}
