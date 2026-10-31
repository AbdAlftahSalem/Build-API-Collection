/// The annotations read above one controller method.
class DetailRequestCode {
  /// `@desc`: request name.
  String desc;

  /// `@route`: the path, e.g. `/api/v1/addresses`.
  String route;

  /// `@param`: query parameters.
  Map<String, dynamic> params;

  /// `@body`: the body JSON as written.
  String body;

  /// `@header`: request headers.
  Map<String, dynamic> header;

  /// `@access`: `privet` (private) or `public`.
  String access;

  /// `@route`: the method (`GET`, `POST`, …) or `formdata`.
  String requestType;

  /// Name of the exported method, e.g. `getAddresses`.
  String methodNameInFile;

  /// Creates the annotations of one method.
  DetailRequestCode({
    this.desc = "",
    this.route = "",
    this.params = const {},
    this.body = "",
    this.header = const {},
    this.access = "",
    this.requestType = "",
    this.methodNameInFile = "",
  });
}
