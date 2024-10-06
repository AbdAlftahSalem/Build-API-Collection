import 'dart:convert';
import 'dart:io';

import 'package:build_post_man_collection/core/services/folder_and_file_service/folder_and_file_service.dart';

import '../../core/model/api_collection_model.dart';
import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/variable_model.dart';

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

  static void saveJSONFile(ApiCollectionModel apiCollectionModel) async{
    await FolderAndFileService.createFolder("${Directory.current.path}\\dist");
    File file =
        File("${Directory.current.path}\\dist\\${apiCollectionModel.infoCollection.collectionName}.json");

    file.writeAsStringSync(jsonEncode(apiCollectionModel.toMap()));
  }
}
