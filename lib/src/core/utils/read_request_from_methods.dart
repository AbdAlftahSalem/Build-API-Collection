import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../model/detail_request_code.dart';
import '../model/request_data.dart';

/// Reads the `// @...` annotations above each exported controller method.
class ReadRequestFromMethods {
  /// Get all files and dirs from [ folderPath ] and read them to extract requests
  static Future<List<RequestData>> getAllRequestsFromDir(
      String folderPath) async {
    final List<FileSystemEntity> allFilesInDir = Directory(folderPath)
        .listSync()
      ..sort((a, b) => a.path.compareTo(b.path));
    List<RequestData> requestData = [];

    for (FileSystemEntity fileSystemEntity in allFilesInDir) {
      String fileName = p.basenameWithoutExtension(fileSystemEntity.path);

      // skip generated output and hidden folders
      if (fileName == "thunder-output" || fileName.startsWith(".")) continue;

      try {
        // if fileSystemEntity is file [ not dir ]
        if (fileSystemEntity is File) {
          if (!const [".js", ".ts", ".mjs", ".cjs"]
              .contains(p.extension(fileSystemEntity.path).toLowerCase())) {
            continue;
          }
          String content = await fileSystemEntity.readAsString();
          List<String> contentsList = const LineSplitter().convert(content);

          // get details request
          List<DetailRequestCode> detailsRequests =
              extractDataFromMethod(contentsList);

          // if file contain summary before method
          if (detailsRequests.isNotEmpty) {
            requestData.add(RequestData(
              key: fileName.replaceAll("_controller", ""),
              detailRequestCode: detailsRequests,
              filePath: fileSystemEntity.path,
            ));
            print(
                "✅ File : '$fileName' || Finish read ${detailsRequests.length} request successfully 🎉");
          }
          // if fileSystemEntity is dir [ not file ]
        } else if (fileSystemEntity is Directory) {
          List<RequestData> outputData =
              await getAllRequestsFromDir(fileSystemEntity.path);
          requestData.addAll(outputData);
        }
      } on FileSystemException catch (e) {
        print("❌ '$fileName' || ${e.message}");
      } on FormatException catch (e) {
        print("❌ '$fileName' || ${e.message}");
      }
    }
    return requestData;
  }

  /// get all lines start with // @ from [contents]
  static List<DetailRequestCode> extractDataFromMethod(List<String> contents) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    List<DetailRequestCode> detailsRequests = [];
    List<String> requestData = [];
    for (String rawLine in contents) {
      final String line = rawLine.trim();
      if (line.startsWith("// @")) {
        requestData.add(line);
      } else if (_exportedMethod.hasMatch(line) && requestData.isNotEmpty) {
        detailRequestCode = getDetailsRequest(requestData);
        detailRequestCode.methodNameInFile =
            _exportedMethod.firstMatch(line)!.group(1)!;
        detailsRequests.add(detailRequestCode);
        detailRequestCode = DetailRequestCode();
        requestData = [];
      }
    }
    return detailsRequests;
  }

  /// `exports.name =` or `module.exports.name =`
  static final RegExp _exportedMethod =
      RegExp(r"^(?:module\.)?exports\.([A-Za-z_$][\w$]*)\s*=");

  /// Parses one block of `// @` lines into a [DetailRequestCode].
  ///
  /// Throws a [FormatException] naming the annotation when its JSON is invalid.
  static DetailRequestCode getDetailsRequest(List<String> requestData) {
    DetailRequestCode detailRequestCode = DetailRequestCode();
    for (String i in requestData) {
      if (i.startsWith("// @desc")) {
        detailRequestCode.desc = i.replaceFirst("// @desc", "").trim();
      } else if (i.startsWith("// @route")) {
        List<String> route =
            i.replaceFirst("// @route", "").trim().split(RegExp(r"\s+"));
        detailRequestCode.requestType = route.first;
        detailRequestCode.route = route.length > 1 ? route[1] : "";
      } else if (i.startsWith("// @param")) {
        detailRequestCode.params =
            _decodeJson(i.replaceFirst("// @param", "").trim(), "@param");
      } else if (i.startsWith("// @body")) {
        detailRequestCode.body = i.replaceFirst("// @body", "").trim();
        _decodeJson(detailRequestCode.body, "@body");
      } else if (i.startsWith("// @header")) {
        String headers = i.replaceFirst("// @header", "").trim();
        detailRequestCode.header = _decodeJson(headers, "@header");
      } else if (i.startsWith("// @access")) {
        final String access = i.toLowerCase();
        // "Privet" is the spelling used by earlier versions; keep accepting it
        if (access.contains("privet") || access.contains("private")) {
          detailRequestCode.access = "privet";
        } else {
          detailRequestCode.access = "public";
        }
      }
    }
    return detailRequestCode;
  }

  static Map<String, dynamic> _decodeJson(String source, String annotation) {
    try {
      final decoded = jsonDecode(source);
      if (decoded is Map<String, dynamic>) return decoded;
    } on FormatException {
      // reported below
    }
    throw FormatException("$annotation must be a JSON object: $source");
  }
}
