import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/request_data.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';
import '../../core/utils/read_controllers_path.dart';
import '../build_api_collection/read_request_from_methods.dart';
import '../build_api_collection/requests_adapter.dart';

class BuildRoutesFiles {
  static Future<void> buildRoutesFiles() async {
    String folderPath = await ReadControllersPath.readControllersPath();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(folderPath);

    List<FolderRequestCollectionModel> requestCollection =
        RequestsAdapter.requestsAdapter(allRequestsData);

    await FolderAndFileService.createFolder("lib/src/routes");
    await FolderAndFileService.createFile("lib/src/routes/test.js", "");
  }
}
