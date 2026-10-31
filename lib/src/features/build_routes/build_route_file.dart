import 'dart:io';

import 'package:path/path.dart' as p;

import '../../core/model/api_collection_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

/// Writes one Express router file per controller.
class BuildRouteFile {
  /// Writes `routes/<name>.js` next to the controllers [directory] for each
  /// folder of requests in [apiCollectionModel].
  static Future buildRouteFile(
      ApiCollectionModel apiCollectionModel, Directory directory) async {
    String folderPath = p.join(directory.parent.path, 'routes');

    // create file and write content
    await FolderAndFileService.createFolder(folderPath);

    // build route file for each folder request
    for (var folderRequest in apiCollectionModel.requestCollectionModel) {
      String methods = folderRequest.detailRequests
          .map((detailApiRequest) => detailApiRequest.methodName.trim())
          .toSet()
          .join(",\n  ");

      String fileContent = """
const express = require("express");
const router = express.Router();

const {
  $methods,
} = require("${requirePath(folderRequest.filePath, folderPath, folderRequest.folderName)}");

""";

      for (var detailApiRequest in folderRequest.detailRequests) {
        fileContent +=
            "router.route('/${detailApiRequest.requestModel.url.path.join("/")}').${expressMethod(detailApiRequest.requestModel.method)}(${detailApiRequest.methodName.trim()});\n";
      }

      fileContent += "\nmodule.exports = router;\n";

      String filePath = p.join(folderPath, '${folderRequest.folderName}.js');
      File(filePath).writeAsStringSync(fileContent);
      print('📂 Create $filePath file successfully 🎉 ...');
    }
  }

  /// Express router method for an HTTP method: `GET` → `get`.
  static String expressMethod(String httpMethod) => httpMethod.toLowerCase();

  /// `require()` path from the routes folder to the controller file.
  static String requirePath(
      String controllerFile, String routesFolder, String folderName) {
    if (controllerFile.isEmpty) return "../controller/${folderName}_controller";
    String relative = p
        .relative(p.withoutExtension(controllerFile), from: routesFolder)
        .replaceAll(r"\\", "/");
    return relative.startsWith(".") ? relative : "./$relative";
  }
}
