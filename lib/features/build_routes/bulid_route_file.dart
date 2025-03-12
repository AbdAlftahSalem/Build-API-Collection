import 'dart:developer';
import 'dart:io';

import '../../core/model/api_collection_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

class BuildRouteFile {
  static Future buildRouteFile(
      ApiCollectionModel apiCollectionModel, Directory directory) async {
    String fileContent = '';

    // Adjusted path formatting to avoid incorrect syntax
    String folderPath = '${directory.parent.path}\\routes';

    // create file and write content
    await FolderAndFileService.createFolder(folderPath);

    // build route file for each folder request
    for (var folderRequest in apiCollectionModel.requestCollectionModel) {
      fileContent = '';
      for (var detailApiRequest in folderRequest.detailRequests) {
        fileContent +=
        'router.${detailApiRequest.requestModel.method.toLowerCase()}("${detailApiRequest.requestModel.url.raw}", (req, res) async {\n';
        fileContent += '  // write your code here\n';
        fileContent += '});\n\n';
      }

      File file = File('$folderPath\\${folderRequest.folderName}.js');
      file.writeAsStringSync(fileContent);
      print('📂 Create $folderPath\\${folderRequest.folderName}.js file successfully 🎉 ...');
      print(fileContent);
    }
  }
}
