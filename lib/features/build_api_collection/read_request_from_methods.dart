import 'dart:convert';
import 'dart:io';

import '../../core/model/detail_request_code.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';

class ReadRequestFromMethods {
  static Future<List<RequestData>> getAllRequestsFromDir(
      String folderPath) async {
    List<FileSystemEntity> allFilesInDir =
        ReadControllersPath.listFilesFromPath(folderPath);
    List<RequestData> requestData = [];

    for (var i in allFilesInDir) {
      String file = i.toString().replaceAll("File: '", "");
      file = file.replaceAll("'", "");
      File file2 = File(file);

      try {
        if (i.toString().toLowerCase().startsWith("file")) {
          String content = await file2.readAsString();
          List<String> contentsList = content.split("\n");
          List<DetailRequestCode> detailsRequests =
              extractDataFromMethod(contentsList);
          if (detailsRequests.isNotEmpty) {
            requestData.add(RequestData(
              key:
                  "${(file.split("\\")[file.split("\\").length - 1]).split(".")[0]}",
              detailRequestCode: detailsRequests,
            ));
            print(
                "✅ File : '${file.split("\\")[file.split("\\").length - 1]}' || Finish read ${detailsRequests.length} request successfully 🎉");
          }
        } else if (i.toString().toLowerCase().startsWith("directory")) {
          List<RequestData> outputData = await getAllRequestsFromDir(i.path);
          requestData.addAll(outputData);
        }
      } on FileSystemException catch (e) {
        print(
            "❌ '${(file.split("\\")[file.split("\\").length - 1]).split(".")[0]}' || ${e.message}");
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
      } else if (j.startsWith("exports.") && requestData.isNotEmpty) {
        detailRequestCode = getDetailsRequest(requestData);
        detailRequestCode.methodNameInFile =
            j.replaceAll("exports.", "").split("=").first;
        detailsRequests.add(detailRequestCode);
        detailRequestCode = DetailRequestCode();
        requestData = [];
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
      } else if (i.startsWith("// @param")) {
        detailRequestCode.params =
            jsonDecode(i.replaceAll("// @param", "").trim());
      } else if (i.startsWith("// @body")) {
        detailRequestCode.body = i.replaceAll("// @body", "").trim();
      } else if (i.startsWith("// @header")) {
        String headers = i.replaceAll("// @header", "").trim();
        detailRequestCode.header = jsonDecode(headers);
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
