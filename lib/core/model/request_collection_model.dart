class RequestCollectionModel {
  String folderName;
  DetailRequest detailRequest;

  RequestCollectionModel({
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
      'requestModel': this.requestModel,
      'response': this.response,
    };
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
      'bodyModel': this.bodyModel,
      'urlModel': this.urlModel,
    };
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
}

class BodyModel {
  String mode;
  String raw;
  List<FormDataModel> formData;

  BodyModel({
    required this.mode,
    this.raw = '',
    this.formData = const [],
  });

  String updateRawValue() {
    String newRaw = raw.replaceAll("{", "{\r\n    ");
    newRaw = newRaw.replaceAll('"', '\"');
    newRaw = newRaw.replaceAll("}", "\r\n}");
    return newRaw;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> objMap = {
      'mode': this.mode,
      'raw': this.raw,
      'formData': this.formData,
    };
    if (mode.toLowerCase() != "formdata") {
      objMap.addAll({
        "options": {
          "raw": {"language": "json"}
        }
      });
    }

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
}

class UrlModel {
  // end point
  String raw;

  // for base uel
  List<String> host;
  List<String> path;

  UrlModel({
    required this.raw,
    this.host = const [],
    this.path = const [],
  });

  UrlModel setUpData() {
    UrlModel? urlModel;

    List<String> localeHost = [];
    List<String> localePath = [];
    localeHost.add(raw.split("/")[0]);
    localePath.addAll(raw.split("/"));

    return urlModel!;
  }

  Map<String, dynamic> toMap() {
    return {
      'raw': this.raw,
      'host': this.host,
      'path': this.path,
    };
  }
}
