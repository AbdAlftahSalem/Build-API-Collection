import 'dart:io';

import '../core/model/api_collection_model.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';
import './read_folder_name.dart';
import './read_request_from_methods.dart';
import './requests_adapter.dart';

class BuildCollections {
  static void buildCollection() async {
    ApiCollectionModel apiCollectionModel = ApiCollectionModel();

    // // setup info about collection
    // apiCollectionModel.infoCollection =
    //     await ReadCollectionName.readCollectionName();
    //
    // // setup variables about collection
    // apiCollectionModel.variables =
    //     ReadVariablesFromUser.readVariablesFromUser();
    //
    // apiCollectionModel.variables!.add(VariableModel(
    //   key: "base_url",
    //   value: apiCollectionModel.infoCollection?.baseUrl,
    // ));

    // read controllers folder name from user
    // String folderPath = ReadFolderName.readFolderName();
    String folderPath = "C:\\Users\\hp\\Desktop\\New folder (2)";

    // get all dirs and files from controller folder
    List<FileSystemEntity> allFilesInDir = ReadFolderName.listFiles(folderPath);

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(allFilesInDir);

    List<FolderRequestCollectionModel> allRequestsDataAdapter =
        RequestsAdapter.requestsAdapter(allRequestsData);

    apiCollectionModel.requestCollectionModel = allRequestsDataAdapter;

    allRequestsDataAdapter.forEach((element) {
      print(element.toMap());
      // print("\nName      : ${element.requestName}");
      // print("Body data : ${element.requestModel.bodyModel.toMap()}");
      // print("AUTH data : ${element.requestModel.bodyModel.authModel.toMap()}");
      // print("Headers   : ${element.requestModel.header}");
      // print("URL       : ${element.requestModel.urlModel.toMap()}");
    });
    // for (RequestData requestData in allRequestsData) {
    //   for (DetailRequestCode detailRequest in requestData.detailRequestCode) {
    //     Map<String, dynamic> singleRequestData = {};
    //     Map<String, dynamic> bodyData = {};
    //     if (!detailRequest.requestType.contains("form")) {
    //       bodyData.addAll({
    //         "mode": "raw",
    //         'raw': detailRequest.body,
    //         "options": {
    //           "raw": {"language": "json"}
    //         }
    //       });
    //     } else {
    //       bodyData.addAll({
    //         "mode": "formdata",
    //         'formdata': detailRequest.body,
    //       });
    //     }
    //     String params = "";
    //     Map<String, dynamic> auth = {};
    //     detailRequest.params.forEach((key, value) => params += "?$key=$value");
    //     if (detailRequest.access.contains("privet")) {
    //       auth = {
    //         "type": "bearer",
    //         "bearer": [
    //           {"key": "token", "value": "", "type": "string"}
    //         ]
    //       };
    //     }
    //
    //     singleRequestData.addAll({"name": detailRequest.desc});
    //     singleRequestData.addAll({
    //       "request": {
    //         "method": detailRequest.requestType.toUpperCase(),
    //         "auth": auth,
    //         "header": detailRequest.header,
    //         "body": bodyData,
    //         "url": {
    //           "raw": "{{base_url}}${detailRequest.route}$params",
    //           "host": ["{{base_url}}"],
    //           "path": detailRequest.route.split("/"),
    //         },
    //       }
    //     });
    //     allRequestsDataAdapter.add(singleRequestData);
    //   }
    //   print(
    //       "\n* '${requestData.key}' requests || ${allRequestsDataAdapter.length} requests");
    //   for (int i = 0; i < allRequestsDataAdapter.length; ++i) {
    //     print("   ${i + 1} - ${allRequestsDataAdapter[i]['name']} || ${allRequestsDataAdapter[i]['request']['method']} || ${allRequestsDataAdapter[i]['request']['url']['raw']}");
    //   }
    // allRequestsDataAdapter = [];
    // }
  }
}
