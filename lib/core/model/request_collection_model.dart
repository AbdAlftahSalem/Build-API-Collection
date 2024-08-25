class FolderRequestCollectionModel {
  String folderName;
  DetailRequest detailRequest;

  FolderRequestCollectionModel({
    required this.folderName,
    required this.detailRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      'folderName': this.folderName,
      'detailRequest': this.detailRequest,
    };
  }
}

class DetailRequest {
  String requestName;
  RequestModel requestModel;
  List<String> response;

  DetailRequest({
    required this.requestName,
    required this.requestModel,
    this.response = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'requestName': this.requestName,
      'requestModel': this.requestModel.toMap(),
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
    required this.type,
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

  BodyModel({
    required this.modeData,
    this.bodyData = '',
    this.formData = const [],
  });

  String updateRawValue() {
    String newRaw = bodyData.replaceAll("{", "{\r\n    ");
    newRaw = newRaw.replaceAll('"', '\"');
    newRaw = newRaw.replaceAll("}", "\r\n}");
    return newRaw;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> objMap = {
      'mode': modeData,
    };
    if (modeData.toLowerCase() != "formdata") {
      objMap.addAll({
        "options": {
          "raw": {"language": "json"}
        },
        "raw": bodyData,
      });
    } else {
      objMap.addAll({
        "formdata": bodyData,
      });
    }

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
