import '../../core/model/detail_request_code.dart';
import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/request_data.dart';

class RequestsAdapter {
  /// Adapter request from some of string to api collection
  static List<FolderRequestCollectionModel> requestsAdapter(
      List<RequestData> allRequestsData) {
    List<DetailApiRequest> allRequestsDataAdapter = [];
    List<FolderRequestCollectionModel> folderRequestCollectionModel = [];

    for (RequestData requestData in allRequestsData) {
      List<DetailApiRequest> allRequestsDataAdapterLocal = [];

      for (DetailRequestCode detailRequest in requestData.detailRequestCode) {
        late RequestModel requestModel;
        late BodyModel bodyModel;
        late UrlModel urlModel;

        List<HeaderModel> headerModel = [];
        AuthModel authModel = AuthModel(authModels: []);

        String paramsRequest = "";

        // adapt header
        headerModel = _headersAdapter(detailRequest);

        // adapt url
        urlModel =
            UrlModel(raw: "{{base_url}}${detailRequest.route}$paramsRequest");

        // adapt auth
        if (detailRequest.access.contains("privet")) {
          authModel.type = "bearer";
          authModel.authModels = [
            AuthData(key: "token", value: "e", type: "string").toMap()
          ];
        }

        // adapt body
        bodyModel = BodyModel(
          modeData: detailRequest.requestType,
          bodyData: detailRequest.body,
        );

        // adapt params
        detailRequest.params
            .forEach((key, value) => paramsRequest += "?$key=$value");

        // setup final request
        requestModel = RequestModel(
          method: detailRequest.requestType,
          header: headerModel,
          bodyModel: bodyModel,
          urlModel: urlModel,
          authModel: authModel,
        );

        DetailApiRequest detailApiRequest = DetailApiRequest(
          requestName: detailRequest.desc,
          requestModel: requestModel,
          methodNameInFile: detailRequest.methodNameInFile,
        );

        allRequestsDataAdapterLocal.add(detailApiRequest);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      folderRequestCollectionModel.add(FolderRequestCollectionModel(
        folderName: requestData.key,
        detailApiRequest: allRequestsDataAdapter,
      ));

      allRequestsDataAdapterLocal = [];
      allRequestsDataAdapter = [];
    }

    return folderRequestCollectionModel;
  }

  static List<HeaderModel> _headersAdapter(DetailRequestCode detailRequest) {
    List<HeaderModel> headerModel = [];
    detailRequest.header.forEach(
        (key, value) => headerModel.add(HeaderModel(key: key, value: value)));
    return headerModel;
  }
}
