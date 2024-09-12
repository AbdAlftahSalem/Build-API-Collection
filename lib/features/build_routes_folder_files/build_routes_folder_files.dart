import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/methods_name_model.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';
import '../build_api_collection/read_request_from_methods.dart';
import '../build_api_collection/requests_adapter.dart';
import './build_routes_files.dart';
import './get_methods_name.dart';

class BuildRoutesFolderFiles {
  static Future<void> buildRoutesFiles() async {
    String folderPath = await ReadControllersPath.readControllersPath();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(folderPath);

    List<FolderRequestCollectionModel> requestsFromControllers =
        RequestsAdapter.requestsAdapter(allRequestsData);
    BuildRoutesFiles.buildRoutesFiles(requestsFromControllers);

    List<MethodsNameModel> methodsName = await
        GetMethodsName.getMethodsName(folderPath);
  }
}
