import 'dart:io';

import '../../core/model/api_collection_model.dart';
import '../../core/model/info_model.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';
import '../../core/utils/read_request_from_methods.dart';
import '../../core/utils/read_variables_from_user.dart';
import '../../core/utils/requests_adapter.dart';
import '../build_web_version/build_web_version.dart';
import './read_base_data_collection.dart';
import 'print_request_data.dart';

class BuildApiCollection {
  static void buildApiCollection() async {
    late ApiCollectionModel apiCollectionModel;

    // setup info about collection
    InfoModel infoModel = ReadBaseDataCollection.readBaseDataCollection();
    apiCollectionModel = ApiCollectionModel(infoCollection: infoModel);

    // setup variables about collection
    apiCollectionModel.variables = ReadVariablesFromUser.readVariablesFromUser(
        apiCollectionModel.infoCollection.baseUrl);

    Directory controllerPath = await ControllersPathUtils.readControllersPath();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(controllerPath.path);

    apiCollectionModel.requestCollectionModel =
        RequestsAdapter.requestsAdapter(allRequestsData);

    PrintAndSaveRequestData.saveJSONFile(
        apiCollectionModel, controllerPath.path);

    await BuildWebVersion.buildWebVersion(
        apiCollectionModel, controllerPath.path);

    // print all requests details
    PrintAndSaveRequestData.printRequestData(
      apiCollectionModel.requestCollectionModel,
      apiCollectionModel.variables,
    );
  }
}
