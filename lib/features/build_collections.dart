import 'dart:io';

import '../core/model/api_collection_model.dart';
import '../core/model/detail_request_code.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';
import './read_folder_name.dart';
import './read_request_from_methods.dart';

class BuildCollections {
  static void buildCollection() async {
    ApiCollectionModel apiCollectionModel = ApiCollectionModel();

    // setup info about collection
    // apiCollectionModel.infoCollection =
    //     await ReadCollectionName.readCollectionName();

    // setup variables about collection
    // apiCollectionModel.variables =
    //     ReadVariablesFromUser.readVariablesFromUser();

    // read controllers folder name from user
    // String folderPath = ReadFolderName.readFolderName();
    String folderPath = "C:\\Users\\hp\\Desktop\\New folder (2)\\New folder";

    // get all dirs and files from controller folder
    List<FileSystemEntity> allFilesInDir = ReadFolderName.listFiles(folderPath);

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(allFilesInDir);
    _requestAdapter(allRequestsData);
  }

  static List<FolderRequestCollectionModel> _requestAdapter(
      List<RequestData> requestsData) {
    for (RequestData requestDataLocal in requestsData) {
      for (DetailRequestCode detailRequestCode
          in requestDataLocal.detailRequestCode) {
        DetailRequest detailRequest = DetailRequest(
          requestName: detailRequestCode.desc,
          requestModel: RequestModel(
            method: detailRequestCode.requestType.toLowerCase() == "formdata"
                ? "POST"
                : detailRequestCode.requestType,
            bodyModel: BodyModel(
              modeData: detailRequestCode.requestType == "formdata"
                  ? "formdata"
                  : "raw",
              bodyData: detailRequestCode.body,
            ),
            header: [HeaderModel(type: '', key: '', value: '')],
            urlModel: UrlModel(raw: detailRequestCode.route),
          ),
        );
        FolderRequestCollectionModel folderRequestCollectionModel =
            FolderRequestCollectionModel(
          folderName: requestDataLocal.key,
          detailRequest: detailRequest,
        );
        print(folderRequestCollectionModel.toMap());
      }
    }

    return [];
  }
}
