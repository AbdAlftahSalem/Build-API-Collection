import 'dart:io';

import '../extensions/string_extensions.dart';

class ControllersPathUtils {
  static Future<String> readControllersPath() async {
    String folderPath = "";
    while (folderPath.isEmpty) {
      stdout.write("Enter your controller folder path : ");
      folderPath = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
              "😢 Folder name cannot be empty !!");

      bool acceptPath = await Directory(folderPath).exists();
      if (!acceptPath) {
        print("😢 '$folderPath' path not found ...  !!\n");
        folderPath = "";
      }
    }
    return folderPath;
  }

  static List<FileSystemEntity> listFilesFromPath(String folderPath) {
    Directory directory = Directory(folderPath);
    return directory.listSync();
  }
}
