import 'dart:convert';
import 'dart:io';

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
    print("\n\n" + "*" * 30 + "⚡⚡ Variables Details ⚡⚡" + "*" * 30 + "\n\n");
    variables.forEach((element) {
      print("Key   : ${element.key}");
      print("Value : ${element.value}\n");
    });

    // print request details
    print("\n\n" + "*" * 30 + "⚡⚡ Requests Details ⚡⚡" + "*" * 30 + "\n\n");
    allRequests.forEach((folderRequest) {
      print("\n⚡ '${folderRequest.folderName}' requests : ");
      folderRequest.detailRequests.forEach((detailApiRequest) {
        String message =
            "   ✅ ${detailApiRequest.requestName} || Method : ${detailApiRequest.requestModel.method} || ";
        message += "Route : ${detailApiRequest.requestModel.url.raw}";
        print(message);
      });
    });
    print("\n\n⚡ FINISH BUILD API COLLECTION SUCCESSFULLY ...");
    print("👑 Build by : Abd Alftah Al-Shanti 👑");
  }

  static void saveJSONFile(ApiCollectionModel apiCollectionModel) {
    File file =
        File("${apiCollectionModel.infoCollection.collectionName}.json");

    file.writeAsStringSync(jsonEncode(apiCollectionModel.toMap()));
  }
}
