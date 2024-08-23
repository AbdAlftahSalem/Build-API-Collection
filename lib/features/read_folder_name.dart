import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/info_model.dart';

class ReadFolderName {
  static String readFolderName() {
    String folderPath = "";
    while (folderPath.isEmpty) {
      stdout.write("Enter your controller folder path : ");
      folderPath = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
              "😢 Folder name cannot be empty !!");

      try {
        Directory directoryFolder = Directory(folderPath);
        List<FileSystemEntity> filesAndFolderInDir = directoryFolder.listSync();
      } on PathNotFoundException catch (e) {
        print("😢 Folder name is not true !!\n");
        folderPath = "";
      }
    }
    return folderPath;
  }

  static List<FileSystemEntity> listFiles(String folderPath) {
    Directory directory = Directory(folderPath);
    return directory.listSync();
  }

  static InfoModel getInfoCollection() {
    InfoModel? infoModel;
    String collectionName = '';
    while (collectionName.isEmpty) {
      stdout.write("Enter name for API collection : ");
      collectionName = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
              "😢 Collection name cannot be empty !!");
    }
    infoModel?.collectionName = collectionName;

    return infoModel!;
  }
}
