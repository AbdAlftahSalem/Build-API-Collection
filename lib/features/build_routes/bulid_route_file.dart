import 'dart:io';

import '../../core/model/api_collection_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

class BuildRouteFile {
  static Future buildRouteFile(
      ApiCollectionModel apiCollectionModel, Directory directory) async {
    // Adjusted path formatting to avoid incorrect syntax
    String folderPath = '${directory.parent.path}\\routes';

    // create file and write content
    await FolderAndFileService.createFolder(folderPath);

    // build route file for each folder request
    for (var folderRequest in apiCollectionModel.requestCollectionModel) {
      String fileContent = '''
const express = require("express");
const router = express.Router();

const {} = require("../controller/${folderRequest.folderName}_controller");\n\n
''';

      String methods = '';
      // get all methods from controller
      for (var detailApiRequest in folderRequest.detailRequests) {
        methods += "${detailApiRequest.methodName.trim()}, ";
      }

      fileContent = fileContent.replaceFirst(
          "{}", "{${methods.replaceAll(", ", ",\n    ")}}");

      for (var detailApiRequest in folderRequest.detailRequests) {
        fileContent +=
            "router.route('/${detailApiRequest.requestModel.url.path.join("/")}').${detailApiRequest.requestModel.method}(${detailApiRequest.methodName.trim()})\n";
      }

      File file = File('$folderPath\\${folderRequest.folderName}.js');
      file.writeAsStringSync(fileContent);
      print(
          '📂 Create $folderPath\\${folderRequest.folderName}.js file successfully 🎉 ...');
    }
  }
}
