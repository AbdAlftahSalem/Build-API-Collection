import 'dart:convert';

/// A folder of requests in the collection (one per controller file).
class FolderRequestCollectionModel {
  /// Folder name shown in Postman.
  String folderName;

  /// The requests in this folder.
  List<DetailRequest> detailRequests;

  /// Path of the controller file the requests came from.
  String filePath;

  /// Creates a folder of requests.
  FolderRequestCollectionModel({
    required this.folderName,
    required this.detailRequests,
    this.filePath = "",
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

/// One request in the collection.
class DetailRequest {
  /// Request name (from `@desc`).
  String requestName;

  /// Method, URL, headers, body and auth of the request.
  RequestModel requestModel;

  /// Saved example responses.
  List<String> response;

  /// Name of the exported controller method.
  String methodName;

  /// Creates a request.
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

/// The HTTP part of a request.
class RequestModel {
  /// HTTP method, e.g. `GET`, `POST`.
  String method;

  /// Request headers (from `@header`).
  List<HeaderModel> header;

  /// Request body (from `@body`).
  BodyModel body;

  /// Request URL with its query parameters.
  UrlModel url;

  /// Bearer auth for private routes, `null` for public ones.
  AuthModel? auth;

  /// Creates the HTTP part of a request.
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

/// One request header.
class HeaderModel {
  /// Header name.
  String key;

  /// Header value.
  String value;

  /// Postman value type.
  String type;

  /// Creates a header.
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

/// A request body: raw JSON, or form data for `formdata` routes.
class BodyModel {
  /// `raw` or `formdata`.
  String mode;

  /// The JSON written after `@body`.
  String body;

  /// Decoded JSON body (raw mode).
  Map<String, dynamic> raw;

  /// Postman body options.
  Map<String, dynamic> options;

  /// Form fields (formdata mode). Keys listed in `option.files_key` are files.
  List<FormDataModel>? formData;

  /// Creates a body for [mode] from the [body] JSON.
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
      Map<String, dynamic> formDataMap = jsonDecode(body.isEmpty ? "{}" : body);
      formData = [];
      if (!formDataMap.containsKey("option")) {
        formDataMap.addAll({
          "option": {"files_key": []}
        });
      }

      formDataMap.forEach((key, value) {
        // "option" only configures the form, it isn't a field
        if (key == "option") return;
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
    // Postman v2.1: `raw` is the body text (raw mode only), `formdata` the
    // fields (formdata mode only).
    Map<String, dynamic> objMap = {'mode': mode};

    if (mode.toLowerCase() != "formdata") {
      objMap.addAll({"raw": body, "options": options});
    } else {
      objMap.addAll(
          {"formdata": (formData ?? []).map((e) => e.toMap()).toList()});
    }

    return objMap;
  }

  @override
  String toString() {
    return 'Body {modeData: $mode, bodyData: $body, raw: $raw, options: $options, formData: $formData}';
  }
}

/// One form-data field.
class FormDataModel {
  /// Field name.
  String key;

  /// `text` or `file`.
  String type;

  /// Field value (text fields).
  String? value;

  /// File path (file fields).
  String? src;

  /// Creates a form-data field.
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

/// Request auth. Postman reads the values from a key named after [type].
class AuthModel {
  /// Auth type, e.g. `bearer`.
  String type;

  /// The auth values, e.g. `[{"key": "token", "value": "{{token}}"}]`.
  List<Map<String, dynamic>> authModels;

  /// Creates request auth.
  AuthModel({this.type = "bearer", required this.authModels});

  /// Postman v2.1 auth object: `{"type": "bearer", "bearer": [...]}`.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      type: authModels,
    };
  }

  @override
  String toString() {
    return 'Auth {type: $type, authModels: $authModels}';
  }
}

/// One auth value.
class AuthData {
  /// Name, value and Postman type of the auth value.
  String key, value, type;

  /// Creates an auth value.
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

/// One query parameter.
class QueryModel {
  /// Parameter name.
  String key;

  /// Parameter value.
  String value;

  /// Creates a query parameter.
  QueryModel({required this.key, required this.value});

  /// Postman query object.
  Map<String, dynamic> toMap() => {'key': key, 'value': value};

  @override
  String toString() => 'Query {key: $key, value: $value}';
}

/// A request URL: `{{base_url}}` plus the route and query parameters.
class UrlModel {
  /// The full URL, query string included.
  String raw;

  /// Always `{{base_url}}`.
  List<String> host;

  /// Route segments, e.g. `["api", "v1", "addresses"]`.
  List<String> path;

  /// Query parameters (from `@param`).
  List<QueryModel> query;

  /// Creates a URL from [raw] (`{{base_url}}/route`) and [query].
  UrlModel({
    required String raw,
    this.host = const [],
    this.path = const [],
    this.query = const [],
  }) : raw = query.isEmpty
            ? raw
            : "$raw?${query.map((e) => "${e.key}=${e.value}").join("&")}" {
    host = ["{{base_url}}"];
    setupPathValue();
  }

  /// Splits the route part of [raw] into [path] segments.
  void setupPathValue() {
    path = raw.split("?").first.split("/");
    path.removeWhere((element) => element.isEmpty);
    path.removeAt(0);
  }

  Map<String, dynamic> toMap() {
    return {
      'raw': raw,
      'host': ["{{base_url}}"],
      'path': path,
      if (query.isNotEmpty) 'query': query.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Url {raw: $raw, host: $host, path: $path, query: $query}';
  }
}
