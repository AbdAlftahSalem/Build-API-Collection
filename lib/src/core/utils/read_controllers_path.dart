import 'dart:io';

import '../extensions/string_extensions.dart';

/// Asks for the controllers folder.
class ControllersPathUtils {
  /// Asks until the user enters a folder that exists.
  static Future<Directory> readControllersPath() async {
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
    return Directory(folderPath);
  }

  /// Files and folders directly inside [folderPath].
  static List<FileSystemEntity> listFilesFromPath(String folderPath) {
    Directory directory = Directory(folderPath);
    return directory.listSync();
  }
}
