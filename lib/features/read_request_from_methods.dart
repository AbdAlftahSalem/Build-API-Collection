import 'dart:io';

import '../core/model/detail_request_code.dart';
import '../core/model/request_data.dart';

// E:\Node\e-commerce\src\auth\controller
class ReadRequestFromMethods {
  static Future<List<RequestData>> getAllRequestsFromDir(
      List<FileSystemEntity> subFiles) async {
    List<RequestData> requestData = [];

    for (var i in subFiles) {
      String file = i.toString().replaceAll("File: '", "");
      file = file.replaceAll("'", "");
      File file2 = File(file);
      String content = await file2.readAsString();
      List<String> contentsList = content.split("\n");
      List<DetailRequestCode> detailsRequests = [];
      extractDataFromMethod(contentsList, detailsRequests);

      requestData.add(RequestData(
        key: "${file.split("\\")[file.split("\\").length - 1]}",
        detailRequestCode: detailsRequests,
      ));
    }
    return requestData;
  }

  static void extractDataFromMethod(
      List<String> contentsList, List<DetailRequestCode> detailsRequests) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    for (String j in contentsList) {
      if (j.startsWith("// @")) {
        getDetailsRequest(j, detailRequestCode);
      } else if (j.startsWith("exports.")) {
        detailsRequests.add(detailRequestCode);
        print("⚡ Read ${detailRequestCode.desc} Request Success ... \n");
      }
    }
  }

  static void getDetailsRequest(String j, DetailRequestCode detailRequestCode) {
    if (j.startsWith("// @desc")) {
      detailRequestCode.desc = j.replaceAll("// @desc", "").trim();
    } else if (j.startsWith("// @route")) {
      detailRequestCode.route =
          j.replaceAll("// @route", "").trim().split(" ")[1];
      detailRequestCode.requestType =
          j.replaceAll("// @route", "").trim().split(" ")[0];
      // print('HERE ${j.replaceAll("// @route", "").trim().split(" ")[0]}');
    } else if (j.startsWith("// @param")) {
      detailRequestCode.params = j.replaceAll("// @param", "").trim();
    } else if (j.startsWith("// @body")) {
      detailRequestCode.body = j.replaceAll("// @body", "").trim();
    } else if (j.startsWith("// @header")) {
      detailRequestCode.header = j.replaceAll("// @header", "").trim();
    } else if (j.startsWith("// @access")) {
      if (j.toLowerCase().contains("privet")) {
        detailRequestCode.access = "privet";
      } else {
        detailRequestCode.access = "public";
      }
    }
  }
}
