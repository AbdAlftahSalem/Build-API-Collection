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

  @override
  String toString() {
    return 'DetailRequest {requestName: $requestName, requestModel: $requestModel, response: $response}';
  }
}

class RequestModel {
  String method;
  List<HeaderModel> header;
  BodyModel bodyModel;
  UrlModel urlModel;

  RequestModel({
    required this.method,
    required this.header,
    required this.bodyModel,
    required this.urlModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'method': this.method,
      'header': this.header,
      'bodyModel': this.bodyModel.toMap(),
      'urlModel': this.urlModel.toMap(),
    };
  }

  @override
  String toString() {
    return 'RequestModel{method: $method, header: $header, bodyModel: $bodyModel, urlModel: $urlModel}';
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

  @override
  String toString() {
    return 'HeaderModel{key: $key, value: $value, type: $type}';
  }
}

class BodyModel {
  String modeData;
  String bodyData;
  List<FormDataModel> formData;
  AuthModel authModel;

  BodyModel({
    required this.modeData,
    required this.authModel,
    this.bodyData = '',
    this.formData = const [],
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> objMap = {
      'mode': modeData,
    };
    if (modeData.toLowerCase() != "formdata") {
      objMap.addAll({
        "raw": jsonDecode(bodyData.isEmpty ? "{}" : bodyData),
        "options": {
          "raw": {"language": "json"}
        },
      });
    } else {
      List<dynamic> formDataMap = jsonDecode(bodyData);
      List<FormDataModel> formDataList = [];
      formDataMap.forEach((element) {
        FormDataModel formDataModel = FormDataModel(
          key: element['key'],
          type: element['type'],
          value: element.containsKey("value") ? element['value'] : "",
          src: element.containsKey("src") ? element['src'] : "",
        );
        formDataList.add(formDataModel);
      });

      objMap.addAll({
        "formdata": formDataList,
      });
    }
    objMap.addAll({"auth" : authModel.toMap()});
    return objMap;
  }

  @override
  String toString() {
    return 'BodyModel{mode: $modeData, raw: $bodyData, formData: $formData}';
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

  @override
  String toString() {
    return 'FormDataModel{key: $key, type: $type, value: $value, src: $src}';
  }
}

class AuthModel {
  String type;
  List<AuthData> authModels;

  AuthModel({this.type = "bearer", this.authModels = const []});

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'authModels': this.authModels,
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
  // end point
  String raw;

  // for base uel
  List<String> host;
  String path;

  UrlModel({
    required this.raw,
    this.host = const [],
    this.path = "",
  });

  Map<String, dynamic> toMap() {
    List<String> path = this.raw.split("/");
    path.removeWhere((element) => element.isEmpty);
    path.removeAt(0);
    return {
      'raw': this.raw,
      'host': ["{{base_url}}"],
      'path': path,
    };
  }

  @override
  String toString() {
    return 'UrlModel{raw: $raw, host: $host, path: $path}';
  }
}
