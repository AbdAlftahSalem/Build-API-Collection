import '../../core/model/api_collection_model.dart';
import '../../core/model/request_data.dart';
import 'print_request_data.dart';
import './read_collection_name.dart';
import 'read_folder_name.dart';
import 'read_request_from_methods.dart';
import './read_variables_from_user.dart';
import 'requests_adapter.dart';

class BuildCollections {
  static void buildCollection() async {
    ApiCollectionModel apiCollectionModel = ApiCollectionModel();

    // setup info about collection
    apiCollectionModel.infoCollection =
        await ReadCollectionName.readCollectionName();

    // setup variables about collection
    apiCollectionModel.variables = ReadVariablesFromUser.readVariablesFromUser(
        apiCollectionModel.infoCollection!.baseUrl);

    String folderPath = await ReadFolderName.readFolderName();

    // get all data from controllers files
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(folderPath);

    apiCollectionModel.requestCollectionModel =
        RequestsAdapter.requestsAdapter(allRequestsData);

    // print all requests details
    PrintRequestData.printRequestData(
      apiCollectionModel.requestCollectionModel ?? [],
    );
  }
}
