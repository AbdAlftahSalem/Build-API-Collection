import 'dart:convert';

class FolderRequestCollectionModel {
  String folderName;
  List<DetailApiRequest> detailApiRequest;

  FolderRequestCollectionModel({
    required this.folderName,
    required this.detailApiRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.folderName,
      'item': this.detailApiRequest,
    };
  }
}

class DetailApiRequest {
  String requestName;
  RequestModel requestModel;
  List<String> response;

  DetailApiRequest({
    required this.requestName,
    required this.requestModel,
    this.response = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.requestName,
      'request': this.requestModel.toMap(),
      'response': this.response,
    };
  }
}

class RequestModel {
  String method;
  List<HeaderModel> header;
  BodyModel bodyModel;
  UrlModel urlModel;
  AuthModel? authModel;

  RequestModel({
    required this.method,
    required this.header,
    required this.bodyModel,
    required this.urlModel,
    this.authModel,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {"method": method, "url": urlModel.toMap()};

    if (header.isNotEmpty) data.addAll({'header': header});

    if (bodyModel.bodyData.isNotEmpty) data.addAll({'body': bodyModel.toMap()});

    if (authModel != null) data.addAll({"auth": authModel!.toMap()});

    return data;
  }
}

class HeaderModel {
  String key;
  String value;
  String type = "text";

  HeaderModel({
    required this.key,
    required this.value,
    this.type = "text",
  });

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'value': this.value,
      'type': this.type,
    };
  }
}

class BodyModel {
  String modeData;
  String bodyData;
  Map<String, dynamic> raw;
  Map<String, dynamic> options;
  List<FormDataModel>? formData;

  BodyModel(
      {required this.modeData,
      this.bodyData = '',
      this.formData,
      this.raw = const {},
      this.options = const {}}) {
    if (modeData.toLowerCase() != "formdata") {
      raw = jsonDecode(bodyData.isEmpty ? "{}" : bodyData);
      options = {
        "raw": {"language": "json"}
      };
    } else {
      Map<String, dynamic> formDataMap = jsonDecode(bodyData);
      formData = [];
      if (!formDataMap.containsKey("option")) {
        formDataMap.addAll({
          "option": {"files_key": []}
        });
      }

      formDataMap.forEach((key, value) {
        FormDataModel formDataModel = FormDataModel(
          key: key,
          type: (formDataMap['option']['files_key'] as List).contains(key)
              ? "file"
              : "text",
          value: (formDataMap['option']['files_key'] as List).contains(key)
              ? ""
              : value.toString(),
          src: (formDataMap['option']['files_key'] as List).contains(key)
              ? value.toString()
              : "",
        );
        formData!.add(formDataModel);
      });
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> objMap = {'mode': modeData};

    if (modeData.toLowerCase() != "formdata") {
      objMap.addAll({"raw": raw, "options": options});
    } else
      objMap.addAll({"formdata": formData});

    return objMap;
  }
}

class FormDataModel {
  String key;
  String type;
  String? value;
  String? src;

  FormDataModel({
    required this.key,
    required this.type,
    this.value,
    this.src,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {"key": key, "type": type};

    if ((value ?? "").isNotEmpty) data.addAll({"value": value});
    if ((src ?? "").isNotEmpty) data.addAll({"src": src});

    return data;
  }
}

class AuthModel {
  String type;
  List<Map<String, dynamic>> authModels;

  AuthModel({this.type = "bearer", required this.authModels});

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'auth': this.authModels,
    };
  }
}

class AuthData {
  String key, value, type;

  AuthData({
    required this.key,
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'value': this.value,
      'type': this.type,
    };
  }
}

class UrlModel {
  String raw;
  List<String> host;
  List<String> path;

  UrlModel({
    required this.raw,
    this.host = const [],
    this.path = const [],
  }) {
    host = ["{{base_url}}"];
    setupPathValue();
  }

  setupPathValue() {
    path = this.raw.split("/");
    path.removeWhere((element) => element.isEmpty);
    path.removeAt(0);
  }

  Map<String, dynamic> toMap() {
    return {
      'raw': this.raw,
      'host': ["{{base_url}}"],
      'path': path,
    };
  }
}
