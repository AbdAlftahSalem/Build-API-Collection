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

/// The `--build-api-doc` command.
class BuildApiCollection {
  /// Asks for the collection name, base URL, variables and controllers
  /// folder, then writes the Postman collection and the web docs to
  /// `<controllers>/thunder-output/`.
  static Future<void> buildApiCollection() async {
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

    await PrintAndSaveRequestData.saveJSONFile(
        apiCollectionModel, controllerPath.path);

    await BuildWebVersion.buildWebVersion(
        apiCollectionModel, controllerPath.path);

    if (allRequestsData.isEmpty) {
      print("\n😢 No annotated methods found in '${controllerPath.path}'.");
      print("   Add // @desc and // @route lines above each exported method.");
    }

    // print all requests details
    PrintAndSaveRequestData.printRequestData(
      apiCollectionModel.requestCollectionModel,
      apiCollectionModel.variables,
    );
  }
}
