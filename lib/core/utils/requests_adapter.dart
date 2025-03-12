import '../model/detail_request_code.dart';
import '../model/folder_request_collection_model.dart';
import '../model/request_data.dart';

class RequestsAdapter {
  /// Adapter request from some of string to api collection
  static List<FolderRequestCollectionModel> requestsAdapter(
      List<RequestData> allRequestsData) {
    List<DetailRequest> allRequestsDataAdapter = [];
    List<FolderRequestCollectionModel> folderRequestCollectionModel = [];

    for (RequestData requestData in allRequestsData) {
      List<DetailRequest> allRequestsDataAdapterLocal = [];

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
          mode: detailRequest.requestType,
          body: detailRequest.body,
        );

        // adapt params
        detailRequest.params
            .forEach((key, value) => paramsRequest += "?$key=$value");

        // setup final request
        requestModel = RequestModel(
          method: detailRequest.requestType,
          header: headerModel,
          body: bodyModel,
          url: urlModel,
          auth: authModel,
        );

        DetailRequest detailApiRequest = DetailRequest(
          requestName: detailRequest.desc,
          requestModel: requestModel,
          methodName: detailRequest.methodNameInFile,
        );

        allRequestsDataAdapterLocal.add(detailApiRequest);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      folderRequestCollectionModel.add(FolderRequestCollectionModel(
        folderName: requestData.key,
        detailRequests: allRequestsDataAdapter,
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
