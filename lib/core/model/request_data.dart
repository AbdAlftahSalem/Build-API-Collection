import './detail_request_code.dart';

class RequestData {
  String key;
  List<DetailRequestCode> detailRequestCode;

  RequestData({required this.key, required this.detailRequestCode});

  @override
  String toString() {
    return 'Request Data {key: $key, detailRequestCode: $detailRequestCode}';
  }
}
