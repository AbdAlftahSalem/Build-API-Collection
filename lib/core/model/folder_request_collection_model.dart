import 'dart:convert';

class FolderRequestCollectionModel {
  String folderName;
  List<DetailRequest> detailRequests;

  FolderRequestCollectionModel({
    required this.folderName,
    required this.detailRequests,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': folderName,
      'item': detailRequests.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Folder Request Collection {folderName: $folderName, detailApiRequest: $detailRequests}';
  }
}

class DetailRequest {
  String requestName;
  RequestModel requestModel;
  List<String> response;
  String methodName;

  DetailRequest({
    required this.requestName,
    required this.requestModel,
    required this.methodName,
    this.response = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': requestName,
      'request': requestModel.toMap(),
      'response': response,
    };
  }

  @override
  String toString() {
    return 'Detail Api Request {requestName: $requestName, requestModel: $requestModel, response: $response}';
  }
}

class RequestModel {
  String method;
  List<HeaderModel> header;
  BodyModel body;
  UrlModel url;
  AuthModel? auth;

  RequestModel({
    required this.method,
    required this.header,
    required this.body,
    required this.url,
    this.auth,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {"method": method, "url": url.toMap()};

    if (header.isNotEmpty) {
      data.addAll({'header': header.map((e) => e.toMap()).toList()});
    }

    if (body.body.isNotEmpty) data.addAll({'body': body.toMap()});

    if (auth != null) data.addAll({"auth": auth!.toMap()});

    return data;
  }

  @override
  String toString() {
    return 'Request {method : $method, header : $header, body : $body, url : $url, auth : $auth}';
  }
}

class HeaderModel {
  String key;
  String value;
  String type;

  HeaderModel({
    required this.key,
    required this.value,
    this.type = "text",
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Header {key: $key, value: $value, type: $type}';
  }
}

class BodyModel {
  String mode;
  String body;
  Map<String, dynamic> raw;
  Map<String, dynamic> options;
  List<FormDataModel>? formData;

  BodyModel({
    required this.mode,
    this.body = '',
    this.formData,
    this.raw = const {},
    this.options = const {},
  }) {
    if (mode.toLowerCase() != "formdata") {
      raw = jsonDecode(body.isEmpty ? "{}" : body);
      mode = "raw";
      options = {
        "raw": {"language": "json"}
      };
    } else {
      mode = "formdata";
      Map<String, dynamic> formDataMap = jsonDecode(body);
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
    Map<String, dynamic> objMap = {
      'mode': mode,
      'raw': raw,
      'options': options
    };

    if (mode.toLowerCase() != "formdata") {
      objMap.addAll({"raw": body});
    } else {
      objMap.addAll(
          {"formdata": (formData ?? []).map((e) => e.toMap()).toList()});
    }

    print(objMap);

    return objMap;
  }

  @override
  String toString() {
    return 'Body {modeData: $mode, bodyData: $body, raw: $raw, options: $options, formData: $formData}';
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

  @override
  String toString() {
    return 'Form Data {key: $key, type: $type, value: $value, src: $src}';
  }
}

class AuthModel {
  String type;
  List<Map<String, dynamic>> authModels;

  AuthModel({this.type = "bearer", required this.authModels});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'auth': authModels,
    };
  }

  @override
  String toString() {
    return 'Auth {type: $type, authModels: $authModels}';
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
      'key': key,
      'value': value,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Auth Data {key: $key, value: $value, type: $type}';
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
    path = raw.split("/");
    path.removeWhere((element) => element.isEmpty);
    path.removeAt(0);
  }

  Map<String, dynamic> toMap() {
    return {
      'raw': raw,
      'host': ["{{base_url}}"],
      'path': path,
    };
  }

  @override
  String toString() {
    return 'Url {raw: $raw, host: $host, path: $path}';
  }
}
