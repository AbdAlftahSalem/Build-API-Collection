import '../../core/model/api_collection_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';
import '../../core/utils/string_consts.dart';

class BuildWebVersion {
  static buildWebVersion(
      ApiCollectionModel apiCollectionModel, String outputPath) async {
    String webPath = '$outputPath\\dist\\web';
    await FolderAndFileService.createFolder(webPath);
    await FolderAndFileService.createFolder("$webPath\\style");
    await FolderAndFileService.createFolder("$webPath\\js");
    await FolderAndFileService.createFolder("$webPath\\assets\\images");

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

    await FolderAndFileService.createFile(
      "$webPath\\js\\data.js",
      StringConsts.dataContent(apiCollectionModel),
    );

    await FolderAndFileService.createFile(
      "$webPath\\assets\\images\\icon-arrow-down.svg",
      '<svg width="10" height="6" xmlns="http://www.w3.org/2000/svg"><path stroke="#686868" stroke-width="1.5" fill="none" d="m1 1 4 4 4-4"/></svg>',
    );
  }
}
