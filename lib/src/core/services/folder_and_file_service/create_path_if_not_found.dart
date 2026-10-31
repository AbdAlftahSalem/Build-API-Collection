import 'dart:io';

import 'folder_and_file_service.dart';

class CreatePathIfNotFound {
  /// When read or write in files . file must found . this method to create file or folder if not found
  static Future<void> createIt(String filePath,
      {bool createFile = false, bool showMessageWhenCreate = true}) async {
    List<String> preFolders = filePath.split("/");
    preFolders.removeWhere((element) => element.endsWith(".dart"));

    for (int folderIndex = 0; folderIndex <= preFolders.length; ++folderIndex) {
      String path = _joinPath(preFolders, folderIndex);
      if (path.isNotEmpty) {
        final directory = Directory(path);

        if (!(await directory.exists())) {
          await FolderAndFileService.createFolder(path);
          if (showMessageWhenCreate) {
            // print('📂 Create $path folder successfully 🎉 ...');
          }
        }
      }
    }
    if (createFile) {
      await FolderAndFileService.createFile(filePath, '');
    }
  }

  static String _joinPath(List<String> paths, int currentIndex) {
    String path = '';
    for (int i = 0; i < currentIndex; ++i) {
      path += "${paths[i]}/";
    }
    return path;
  }
}
