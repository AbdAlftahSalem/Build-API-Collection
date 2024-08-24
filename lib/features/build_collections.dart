import 'dart:io';

import '../core/model/api_collection_model.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';
import './read_collection_name.dart';
import './read_folder_name.dart';
import './read_request_from_methods.dart';
import './read_variables_from_user.dart';

class BuildCollections {
  static void buildCollection() async {
    ApiCollectionModel apiCollectionModel = ApiCollectionModel();

    // setup info about collection
    apiCollectionModel.infoCollection =
        await ReadCollectionName.readCollectionName();

    // setup variables about collection
    apiCollectionModel.variables =
        ReadVariablesFromUser.readVariablesFromUser();

    // read controllers folder name from user
    String folderPath = ReadFolderName.readFolderName();

    // get all dirs and files from controller folder
    List<FileSystemEntity> allFilesInDir = ReadFolderName.listFiles(folderPath);

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(allFilesInDir);
    _requestAdapter(allRequestsData);

    print(allRequestsData);
  }

  static List<RequestCollectionModel> _requestAdapter(
      List<RequestData> requestsData) {
    for (RequestData requestDataLocal in requestsData) {
      print(requestDataLocal.key);
      print("${requestDataLocal.detailRequestCode}\n\n");
    }

    return [];
  }
}
