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
        AuthModel authModel = AuthModel(authModels: []);
        late UrlModel urlModel;

        String params = "";

        headerModel = headersAdapter(detailRequest);
        urlModel = UrlModel(raw: "{{base_url}}${detailRequest.route}$params");
        if (detailRequest.access.contains("privet")) {
          authModel.type = "bearer";
          authModel.authModels = [
            AuthData(key: "token", value: "e", type: "string").toMap()
          ];
        }
        bodyModel = BodyModel(
          modeData: detailRequest.requestType,
          bodyData: detailRequest.body,
        );

        detailRequest.params.forEach((key, value) => params += "?$key=$value");

        requestModel = RequestModel(
          method: detailRequest.requestType,
          header: headerModel,
          bodyModel: bodyModel,
          urlModel: urlModel,
          authModel: authModel,
        );
        DetailApiRequest detailApiRequest = DetailApiRequest(
            requestName: detailRequest.desc, requestModel: requestModel);

        allRequestsDataAdapterLocal.add(detailApiRequest);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      folderRequestCollectionModel.add(FolderRequestCollectionModel(
        folderName: requestData.key,
        detailApiRequest: allRequestsDataAdapter,
      ));

      // print("✅ ${requestData.key}");
      // for (int i = 0; i < allRequestsDataAdapterLocal.length; ++i) {
      //   String printMessage =
      //       "   Request name      : ${allRequestsDataAdapterLocal[i].requestName}\n";
      //   printMessage +=
      //       "   Request URL       : ${allRequestsDataAdapterLocal[i].requestModel.urlModel.raw}\n";
      //   printMessage +=
      //       "   Request method    : ${allRequestsDataAdapterLocal[i].requestModel.method}\n";
      //   printMessage +=
      //       "   Request Body      : ${allRequestsDataAdapterLocal[i].requestModel.bodyModel}\n";
      //   printMessage +=
      //       "   Request Headers   : ${allRequestsDataAdapterLocal[i].requestModel.header}\n";
      //   printMessage +=
      //       "   Request auth      : ${allRequestsDataAdapterLocal[i].requestModel.authModel?.toMap()}\n ${allRequestsDataAdapterLocal.length - 1 == i ? "\n" : ""}";
      //
      //   print(printMessage);
      //   if (allRequestsDataAdapterLocal.length - 1 == i) {
      //     print("\n");
      //   }
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
