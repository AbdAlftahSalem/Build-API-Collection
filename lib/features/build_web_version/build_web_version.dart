import 'dart:io';

import '../../core/services/folder_and_file_service/folder_and_file_service.dart';
import '../../core/utils/string_consts.dart';

class BuildWebVersion {
  static buildWebVersion() async {
    String webPath = '${Directory.current.path}\\dist\\web';
    await FolderAndFileService.createFolder(webPath);
    await FolderAndFileService.createFolder("$webPath\\style");
    await FolderAndFileService.createFolder("$webPath\\js");

    await FolderAndFileService.createFile(
      "$webPath\\index.html",
      StringConsts.htmlContent,
    );

    await FolderAndFileService.createFile(
      "$webPath\\style\\home.css",
      StringConsts.styleContent,
    );

    await FolderAndFileService.createFile(
      "$webPath\\js\\home.js",
      StringConsts.homeJSContent,
    );
  }
}
