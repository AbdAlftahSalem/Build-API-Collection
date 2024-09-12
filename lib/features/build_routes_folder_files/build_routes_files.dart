import '../../core/consts/folder_files_consts.dart';
import '../../core/model/folder_request_collection_Model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

class BuildRoutesFiles {
  static Future<void> buildRoutesFiles(
      List<FolderRequestCollectionModel> requestsFromControllers) async {
    // Build routes folder
    await FolderAndFileService.createFolder(
        FoldersFilesPaths.instance.routesFolder);

    for (FolderRequestCollectionModel folderRequestCollectionModel
        in requestsFromControllers) {
      print(folderRequestCollectionModel.folderName);
      for (DetailApiRequest detailApiRequest
          in folderRequestCollectionModel.detailApiRequest) {

        
        String contentRoutes = "";

        await FolderAndFileService.createFile(
          "${FoldersFilesPaths.instance.routesFolder}${folderRequestCollectionModel.folderName}.js",
          contentRoutes,
        );
      }
    }

    // await FolderAndFileService.createFile("lib/src/routes/test.js", "");
  }
}
