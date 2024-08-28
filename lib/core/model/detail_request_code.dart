class DetailRequestCode {
  String desc;
  String route;
  Map<String, dynamic> params;
  String body;
  Map<String, dynamic> header;
  String access;
  String requestType;

  DetailRequestCode({
    this.desc = "",
    this.route = "",
    this.params = const {},
    this.body = "",
    this.header = const {},
    this.access = "",
    this.requestType = "",
  });

  @override
  String toString() {
    return 'DetailRequestCode{desc: $desc, route: $route, params: $params, body: $body, header: $header, access: $access, requestType: $requestType}';
  }
}
