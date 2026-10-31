import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:thunder_api/src/core/services/folder_and_file_service/folder_and_file_service.dart';

import '../../core/model/api_collection_model.dart';
import '../../core/model/folder_request_collection_model.dart';
import '../../core/model/variable_model.dart';

/// Prints the collection summary and saves the collection JSON.
class PrintAndSaveRequestData {
  /// print all data about collection .
  /// [allRequests] to print request details .
  /// [variables] to print variables details .
  static void printRequestData(List<FolderRequestCollectionModel> allRequests,
      List<VariableModel> variables) {
    // print variables details
    print("\n\n${"*" * 30}⚡⚡ Variables Details ⚡⚡${"*" * 30}\n\n");
    for (var element in variables) {
      print("Key   : ${element.key}");
      print("Value : ${element.value}\n");
    }

    // print request details
    print("\n\n${"*" * 30}⚡⚡ Requests Details ⚡⚡${"*" * 30}\n\n");
    for (var folderRequest in allRequests) {
      print("\n⚡ '${folderRequest.folderName}' requests : ");
      for (var detailApiRequest in folderRequest.detailRequests) {
        String message =
            "   ✅ ${detailApiRequest.requestName} || Method : ${detailApiRequest.requestModel.method} || ";
        message += "Route : ${detailApiRequest.requestModel.url.raw}";
        print(message);
      }
    }
    print("\n\n⚡ FINISH BUILD API COLLECTION SUCCESSFULLY ...");
    print("👑 Build by : Abd Alftah Al-Shanti 👑");
  }

  /// Writes the collection to `thunder-output/<collection name>.json` inside
  /// [outputPath], ready to import into Postman.
  static Future<void> saveJSONFile(
      ApiCollectionModel apiCollectionModel, String outputPath) async {
    String outputFolder = p.join(outputPath, 'thunder-output');
    await FolderAndFileService.createFolder(outputFolder);
    File file = File(p.join(outputFolder,
        "${apiCollectionModel.infoCollection.collectionName}.json"));

    file.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(apiCollectionModel.toMap()));
    print("\n📄 Postman collection : ${file.path}");
  }
}
