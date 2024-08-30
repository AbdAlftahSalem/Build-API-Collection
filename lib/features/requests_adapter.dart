import '../core/model/detail_request_code.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';

class RequestsAdapter {
  static List<FolderRequestCollectionModel> requestsAdapter(
      List<RequestData> allRequestsData) {
    List<DetailApiRequest> allRequestsDataAdapter = [];
    List<DetailApiRequest> allRequestsDataAdapterLocal = [];
    List<FolderRequestCollectionModel> folderRequestCollectionModel = [];

    for (RequestData requestData in allRequestsData) {
      for (DetailRequestCode detailRequest in requestData.detailRequestCode) {
        late RequestModel requestModel;
        List<HeaderModel> headerModel = [];
        late BodyModel bodyModel;
        AuthModel authModel = AuthModel();
        late UrlModel urlModel;

        String params = "";

        headerModel = headersAdapter(detailRequest);
        urlModel = UrlModel(raw: "{{base_url}}${detailRequest.route}$params");
        if (detailRequest.access.contains("privet")) {
          authModel = AuthModel(type: "bearer" , authModels: [AuthData(key: "token", value: "e", type: "string")]);
        }
        bodyModel = BodyModel(
          modeData: detailRequest.requestType,
          bodyData: detailRequest.body,
          authModel: authModel,
        );

        detailRequest.params.forEach((key, value) => params += "?$key=$value");

        requestModel = RequestModel(
          method: detailRequest.requestType,
          header: headerModel,
          bodyModel: bodyModel,
          urlModel: urlModel,
        );
        DetailApiRequest detailApiRequest = DetailApiRequest(
            requestName: detailRequest.desc, requestModel: requestModel);
        // singleRequestData.addAll({"name": detailRequest.desc});
        // singleRequestData.addAll({
        //   "request": {
        //     "method": detailRequest.requestType.toUpperCase(),
        //     "auth": auth,
        //     "header": headerModel,
        //     "body": bodyData,
        //     "url": urlModel.toMap(),
        //   }
        // });
        allRequestsDataAdapterLocal.add(detailApiRequest);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      folderRequestCollectionModel.add(FolderRequestCollectionModel(
        folderName: requestData.key,
        detailApiRequest: allRequestsDataAdapter,
      ));
      // for (int i = 0; i < allRequestsDataAdapterLocal.length; ++i) {
      // print(
      //     "   ${i + 1} - ${allRequestsDataAdapterLocal[i]} || ${allRequestsDataAdapterLocal[i]['request']['method']} || ${allRequestsDataAdapter[i]['request']['url']['raw']}");
      // }
      allRequestsDataAdapterLocal = [];
      allRequestsDataAdapter = [];
    }

    return folderRequestCollectionModel;
  }

  static List<HeaderModel> headersAdapter(DetailRequestCode detailRequest) {
    List<HeaderModel> headerModel = [];
    detailRequest.header.forEach(
        (key, value) => headerModel.add(HeaderModel(key: key, value: value)));
    return headerModel;
  }
}
