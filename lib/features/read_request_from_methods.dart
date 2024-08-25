import 'dart:io';

import '../core/model/detail_request_code.dart';
import '../core/model/request_data.dart';

// E:\Node\e-commerce\src\auth\controller
class ReadRequestFromMethods {
  static Future<List<RequestData>> getAllRequestsFromDir(
      List<FileSystemEntity> subFiles) async {
    List<RequestData> requestData = [];

    for (var i in subFiles) {
      if (i.toString().toLowerCase().startsWith("file")) {
        String file = i.toString().replaceAll("File: '", "");
        file = file.replaceAll("'", "");
        File file2 = File(file);
        String content = await file2.readAsString();
        List<String> contentsList = content.split("\n");
        List<DetailRequestCode> detailsRequests =
            extractDataFromMethod(contentsList);
        requestData.add(RequestData(
          key:
              "${(file.split("\\")[file.split("\\").length - 1]).split(".")[0]}",
          detailRequestCode: detailsRequests,
        ));
        print("✅ Finish read '${file.split("\\")[file.split("\\").length - 1]}' success ...\n");
      }
    }
    return requestData;
  }

  static List<DetailRequestCode> extractDataFromMethod(
      List<String> contentsList) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    List<DetailRequestCode> detailsRequests = [];
    List<String> requestData = [];
    for (String j in contentsList) {
      if (j.startsWith("// @")) {
        requestData.add(j);
      } else if (j.startsWith("exports.")) {
        detailRequestCode = getDetailsRequest(requestData);
        detailsRequests.add(detailRequestCode);
        print("⚡ Read '${detailRequestCode.desc}' Request Success ...");
        detailRequestCode = DetailRequestCode();
      }
    }
    return detailsRequests;
  }

  static DetailRequestCode getDetailsRequest(List<String> requestData) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    for (String i in requestData) {
      if (i.startsWith("// @desc")) {
        detailRequestCode.desc = i.replaceAll("// @desc", "").trim();
      } else if (i.startsWith("// @route")) {
        detailRequestCode.route =
            i.replaceAll("// @route", "").trim().split(" ")[1];
        detailRequestCode.requestType =
            i.replaceAll("// @route", "").trim().split(" ")[0];
        // print('HERE ${i.replaceAll("// @route", "").trim().split(" ")[0]}');
      } else if (i.startsWith("// @param")) {
        detailRequestCode.params = i.replaceAll("// @param", "").trim();
      } else if (i.startsWith("// @body")) {
        detailRequestCode.body = i.replaceAll("// @body", "").trim();
      } else if (i.startsWith("// @header")) {
        detailRequestCode.header = i.replaceAll("// @header", "").trim();
      } else if (i.startsWith("// @access")) {
        if (i.toLowerCase().contains("privet")) {
          detailRequestCode.access = "privet";
        } else {
          detailRequestCode.access = "public";
        }
      }
    }
    return detailRequestCode;
  }
}
