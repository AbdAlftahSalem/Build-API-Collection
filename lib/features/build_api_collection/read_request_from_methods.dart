import 'dart:convert';
import 'dart:io';

import '../../core/model/detail_request_code.dart';
import '../../core/model/request_data.dart';
import '../../core/utils/read_controllers_path.dart';

class ReadRequestFromMethods {
  /// Get all files and dirs from [ folderPath ] and read them to extract requests
  static Future<List<RequestData>> getAllRequestsFromDir(
      String folderPath) async {
    List<FileSystemEntity> allFilesInDir =
        ControllersPathUtils.listFilesFromPath(folderPath);
    List<RequestData> requestData = [];

    for (FileSystemEntity fileSystemEntity in allFilesInDir) {
      String fileString = fileSystemEntity.toString().replaceAll("File: '", "");
      fileString = fileString.replaceAll("'", "");

      String fileName = fileString
          .split("\\")[fileString.split("\\").length - 1]
          .split(".")[0];

      File file = File(fileString);

      try {
        // if fileSystemEntity is file [ not dir ]
        if (fileSystemEntity.toString().toLowerCase().startsWith("file")) {
          String content = await file.readAsString();
          List<String> contentsList = content.split("\n");

          // get details request
          List<DetailRequestCode> detailsRequests =
              extractDataFromMethod(contentsList);

          // if file contain summary before method
          if (detailsRequests.isNotEmpty) {
            requestData.add(RequestData(
              key:
                  (fileString.split("\\")[fileString.split("\\").length - 1]).split(".")[0].replaceAll("_controller", ""),
              detailRequestCode: detailsRequests,
            ));
            print(
                "✅ File : '$fileName' || Finish read ${detailsRequests.length} request successfully 🎉");
          }
          // if fileSystemEntity is dir [ not file ]
        } else if (fileSystemEntity
            .toString()
            .toLowerCase()
            .startsWith("directory")) {
          List<RequestData> outputData =
              await getAllRequestsFromDir(fileSystemEntity.path);
          requestData.addAll(outputData);
        }
      } on FileSystemException catch (e) {
        print("❌ '$fileName' || ${e.message}");
      }
    }
    return requestData;
  }

  /// get all lines start with // @ from [contents]
  static List<DetailRequestCode> extractDataFromMethod(
      List<String> contents) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    List<DetailRequestCode> detailsRequests = [];
    List<String> requestData = [];
    for (String line in contents) {
      if (line.startsWith("// @")) {
        requestData.add(line);
      } else if (line.startsWith("exports.") && requestData.isNotEmpty) {
        detailRequestCode = getDetailsRequest(requestData);
        detailRequestCode.methodNameInFile =
            line.replaceAll("exports.", "").split("=").first;
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
