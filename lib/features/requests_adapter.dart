import '../core/model/detail_request_code.dart';
import '../core/model/request_collection_model.dart';
import '../core/model/request_data.dart';

class RequestsAdapter {
  static List<Map<String, dynamic>> requestsAdapter(
      List<RequestData> allRequestsData) {
    List<Map<String, dynamic>> allRequestsDataAdapter = [];
    List<Map<String, dynamic>> allRequestsDataAdapterLocal = [];

    List<FolderRequestCollectionModel> folderRequestCollectionModel = [];

    for (RequestData requestData in allRequestsData) {
      for (DetailRequestCode detailRequest in requestData.detailRequestCode) {
        late RequestModel requestModel;
        List<HeaderModel> headerModel = [];
        late BodyModel bodyModel;
        late UrlModel urlModel;

        Map<String, dynamic> singleRequestData = {};
        Map<String, dynamic> bodyData = {};
        String params = "";

        headerModel = headersAdapter(detailRequest);
        urlModel = UrlModel(raw: "{{base_url}}${detailRequest.route}$params");
        bodyModel = BodyModel(
            modeData: detailRequest.requestType, bodyData: detailRequest.body);
        print(bodyModel.toMap());

        if (!detailRequest.requestType.contains("form")) {
          bodyData.addAll({
            "mode": "raw",
            'raw': detailRequest.body,
            "options": {
              "raw": {"language": "json"}
            }
          });
        } else {
          bodyData.addAll({
            "mode": "formdata",
            'formdata': detailRequest.body,
          });
        }

        Map<String, dynamic> auth = {};
        detailRequest.params.forEach((key, value) => params += "?$key=$value");
        if (detailRequest.access.contains("privet")) {
          auth = {
            "type": "bearer",
            "bearer": [
              {"key": "token", "value": "", "type": "string"}
            ]
          };
        }

        singleRequestData.addAll({"name": detailRequest.desc});
        singleRequestData.addAll({
          "request": {
            "method": detailRequest.requestType.toUpperCase(),
            "auth": auth,
            "header": headerModel,
            "body": bodyData,
            "url": urlModel.toMap(),
          }
        });
        allRequestsDataAdapterLocal.add(singleRequestData);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      print(
          "\n* '${requestData.key}' requests || ${allRequestsDataAdapterLocal.length} requests");
      for (int i = 0; i < allRequestsDataAdapterLocal.length; ++i) {
        print(
            "   ${i + 1} - ${allRequestsDataAdapterLocal[i]['name']} || ${allRequestsDataAdapterLocal[i]['request']['method']} || ${allRequestsDataAdapter[i]['request']['url']['raw']}");
      }
      allRequestsDataAdapterLocal = [];
    }

    return allRequestsDataAdapter;
  }

  static List<HeaderModel> headersAdapter(DetailRequestCode detailRequest) {
    List<HeaderModel> headerModel = [];
    detailRequest.header.forEach(
        (key, value) => headerModel.add(HeaderModel(key: key, value: value)));
    return headerModel;
  }
}
