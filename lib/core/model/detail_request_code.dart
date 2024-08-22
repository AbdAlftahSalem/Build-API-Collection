class DetailRequestCode {
  String desc;
  String route;
  String params;
  String body;
  String header;
  String access;
  String requestType;

  DetailRequestCode({
    this.desc = "",
    this.route = "",
    this.params = "",
    this.body = "",
    this.header = "",
    this.access = "",
    this.requestType = "",
  });

  @override
  String toString() {
    return 'DetailRequestCode{desc: $desc, route: $route, params: $params, body: $body, header: $header, access: $access, requestType: $requestType}';
  }
}
