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

    allRequestsDataAdapter.forEach((folderRequest) {
      print("⚡ '${folderRequest.folderName}' requests : ");
      folderRequest.detailApiRequest.forEach((detailApiRequest) {
        print(
            "   ✅ ${detailApiRequest.requestName} || Method : ${detailApiRequest.requestModel.method} || Route : ${detailApiRequest.requestModel.urlModel.raw}");
      });
      print("\n");
    });
  }
}
