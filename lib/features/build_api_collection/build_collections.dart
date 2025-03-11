import 'package:build_post_man_collection/features/build_web_version/build_web_version.dart';

import '../../core/model/api_collection_model.dart';
import '../../core/model/info_model.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';
import './read_base_data_collection.dart';
import './read_request_from_methods.dart';
import './read_variables_from_user.dart';
import 'print_request_data.dart';
import 'requests_adapter.dart';

class BuildApiCollection {
  static void buildApiCollection() async {
    late ApiCollectionModel apiCollectionModel;

    // setup info about collection
    InfoModel infoModel = ReadBaseDataCollection.readBaseDataCollection();
    apiCollectionModel = ApiCollectionModel(infoCollection: infoModel);

    // setup variables about collection
    apiCollectionModel.variables = ReadVariablesFromUser.readVariablesFromUser(
        apiCollectionModel.infoCollection.baseUrl);

    String controllerPath = await ControllersPathUtils.readControllersPath();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(controllerPath);

    apiCollectionModel.requestCollectionModel =
        RequestsAdapter.requestsAdapter(allRequestsData);

    PrintAndSaveRequestData.saveJSONFile(apiCollectionModel, controllerPath);

    // print all requests details
    PrintAndSaveRequestData.printRequestData(
      apiCollectionModel.requestCollectionModel,
      apiCollectionModel.variables,
    );

    await BuildWebVersion.buildWebVersion(apiCollectionModel, controllerPath);
  }
}
