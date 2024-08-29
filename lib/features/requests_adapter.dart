import '../core/model/request_data.dart';
import '../core/model/detail_request_code.dart';

class RequestsAdapter {
  static List<Map<String, dynamic>> requestsAdapter(List<RequestData> allRequestsData) {
    List<Map<String, dynamic>> allRequestsDataAdapter = [];
    List<Map<String, dynamic>> allRequestsDataAdapterLocal = [];

    for (RequestData requestData in allRequestsData) {
      for (DetailRequestCode detailRequest in requestData.detailRequestCode) {
        Map<String, dynamic> singleRequestData = {};
        Map<String, dynamic> bodyData = {};
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
        String params = "";
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
            "header": detailRequest.header,
            "body": bodyData,
            "url": {
              "raw": "{{base_url}}${detailRequest.route}$params",
              "host": ["{{base_url}}"],
              "path": detailRequest.route.split("/"),
            },
          }
        });
        allRequestsDataAdapterLocal.add(singleRequestData);
      }
      allRequestsDataAdapter.addAll(allRequestsDataAdapterLocal);
      print(
          "\n* '${requestData.key}' requests || ${allRequestsDataAdapterLocal.length} requests");
      for (int i = 0; i < allRequestsDataAdapterLocal.length; ++i) {
        print("   ${i + 1} - ${allRequestsDataAdapterLocal[i]['name']} || ${allRequestsDataAdapterLocal[i]['request']['method']} || ${allRequestsDataAdapter[i]['request']['url']['raw']}");
      }
      allRequestsDataAdapterLocal = [];
    }

    return allRequestsDataAdapter;
  }
}
