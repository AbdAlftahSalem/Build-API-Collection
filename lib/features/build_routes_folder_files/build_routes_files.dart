import '../../core/consts/consts_strings.dart';
import '../../core/consts/folder_files_consts.dart';
import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/methods_name_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

class BuildRoutesFiles {
  static Future<void> buildRoutesFiles(
      List<FolderRequestCollectionModel> requestsFromControllers,
      List<MethodsNameModel> methodsName) async {
    // Build routes folder
    await FolderAndFileService.createFolder(
        FoldersFilesPaths.instance.routesFolder);

    List<String> routes = [];
    for (FolderRequestCollectionModel folderRequestCollectionModel
        in requestsFromControllers) {

      String fileName = folderRequestCollectionModel.folderName;
      List<String> methods = methodsName
          .where((element) => element.folderName.contains(fileName))
          .first
          .methodsName;

      for (DetailApiRequest detailApiRequest
          in folderRequestCollectionModel.detailApiRequest) {
        String route = detailApiRequest.requestModel.urlModel.raw;
        String requestType = detailApiRequest.requestModel.method;

        String routeInFJsFile = ConstStrings.instance.routesTemplate(
            route, requestType, detailApiRequest.methodNameInFile);
        routes.add(routeInFJsFile);
      }
      await FolderAndFileService.createFile(FoldersFilesPaths.instance.fileInRoutes("$fileName.js"), ConstStrings.instance.routeFileTemplate(fileName, methods, routes));
    }
  }
}
