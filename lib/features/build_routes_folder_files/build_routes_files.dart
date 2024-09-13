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
        FoldersFilesPaths.instance.routesFolderPath);

    await _createRouteFile(requestsFromControllers, methodsName);
    createIndexFile(requestsFromControllers);
  }

  static Future<void> createIndexFile(
      List<FolderRequestCollectionModel> requestsFromControllers) async {
    List<String> constImports = [];
    List<String> useRoutes = [];
    for (var value in requestsFromControllers) {
      constImports.add(ConstStrings.instance.getConstRoute(value.folderName));
      useRoutes.add(ConstStrings.instance.getUseRoute(value.folderName));
    }

    await FolderAndFileService.createFile(
        FoldersFilesPaths.instance.indexRoutePath,
        ConstStrings.instance
            .indexRouteTemplate(constImports.join("\n"), useRoutes.join("\n")));
  }

  static Future<void> _createRouteFile(
      List<FolderRequestCollectionModel> requestsFromControllers,
      List<MethodsNameModel> methodsName) async {
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
      await FolderAndFileService.createFile(
          FoldersFilesPaths.instance.fileInRoutes("${fileName}_route.js"),
          ConstStrings.instance.routeFileTemplate(fileName, methods, routes));
    }
  }
}
