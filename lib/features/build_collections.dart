import 'dart:io';

import '../core/model/api_collection_model.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';
import '../core/model/variable_model.dart';
import './print_request_data.dart';
import './read_collection_name.dart';
import './read_folder_name.dart';
import './read_request_from_methods.dart';
import './read_variables_from_user.dart';
import './requests_adapter.dart';

class BuildCollections {
  static void buildCollection() async {
    ApiCollectionModel apiCollectionModel = ApiCollectionModel();

    // setup info about collection
    apiCollectionModel.infoCollection =
        await ReadCollectionName.readCollectionName();

    // setup variables about collection
    apiCollectionModel.variables =
        ReadVariablesFromUser.readVariablesFromUser();

    apiCollectionModel.variables!.add(VariableModel(
      key: "base_url",
      value: apiCollectionModel.infoCollection?.baseUrl,
    ));

    // String folderPath = ReadFolderName.readFolderName();
    String folderPath = "C:\\Users\\hp\\Desktop\\New folder (2)";

    // get all dirs and files from controller folder
    List<FileSystemEntity> allFilesInDir = ReadFolderName.listFiles(folderPath);

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(allFilesInDir);

    List<FolderRequestCollectionModel> allRequestsAdapter =
        RequestsAdapter.requestsAdapter(allRequestsData);

    apiCollectionModel.requestCollectionModel = allRequestsAdapter;

    PrintRequestData.printRequestData(allRequestsAdapter);
    print("\n\n⚡ FINISH BUILD API COLLECTION SUCCESSFULLY ...");
    print("   Build by : Abd Alftah Al-Shanti");
  }
}
