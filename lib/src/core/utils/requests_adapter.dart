import '../model/detail_request_code.dart';
import '../model/folder_request_collection_model.dart';
import '../model/request_data.dart';

/// Turns the parsed annotations into Postman collection models.
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

        // adapt header
        headerModel = _headersAdapter(detailRequest);

        // adapt params + url
        List<QueryModel> query = [
          for (final entry in detailRequest.params.entries)
            QueryModel(key: entry.key, value: entry.value.toString()),
        ];
        urlModel = UrlModel(
          raw: "{{base_url}}${detailRequest.route}",
          query: query,
        );

        // adapt auth
        AuthModel? authModel;
        if (detailRequest.access.contains("privet")) {
          authModel = AuthModel(
            type: "bearer",
            authModels: [
              AuthData(key: "token", value: "{{token}}", type: "string").toMap()
            ],
          );
        }

        // adapt body
        bodyModel = BodyModel(
          mode: detailRequest.requestType,
          body: detailRequest.body,
        );

        // setup final request
        requestModel = RequestModel(
          method: httpMethod(detailRequest.requestType),
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
        filePath: requestData.filePath,
      ));

      allRequestsDataAdapterLocal = [];
      allRequestsDataAdapter = [];
    }

    return folderRequestCollectionModel;
  }

  /// HTTP method for a `@route` type: `formdata` routes are sent as `POST`,
  /// everything else is upper-cased (`get` → `GET`).
  static String httpMethod(String requestType) {
    if (requestType.toLowerCase() == "formdata") return "POST";
    return requestType.toUpperCase();
  }

  static List<HeaderModel> _headersAdapter(DetailRequestCode detailRequest) {
    List<HeaderModel> headerModel = [];
    detailRequest.header.forEach((key, value) =>
        headerModel.add(HeaderModel(key: key, value: value.toString())));
    return headerModel;
  }
}
