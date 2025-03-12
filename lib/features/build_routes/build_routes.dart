import 'dart:developer';
import 'dart:io';

import '../../core/model/api_collection_model.dart';
import '../../core/model/info_model.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';
import '../../core/utils/read_request_from_methods.dart';
import '../../core/utils/requests_adapter.dart';
import 'bulid_route_file.dart';

class BuildRoutes {
  static void buildRoutes() async {
    print("HERE");

    ApiCollectionModel apiCollectionModel =
        ApiCollectionModel(infoCollection: InfoModel());

    Directory controllerPath = await ControllersPathUtils.readControllersPath();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(controllerPath.path);

    apiCollectionModel.requestCollectionModel =
        RequestsAdapter.requestsAdapter(allRequestsData);

    print(apiCollectionModel.requestCollectionModel.toString());

    await BuildRouteFile.buildRouteFile(apiCollectionModel, controllerPath);
  }
}
