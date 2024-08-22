import './detail_request_code.dart';

class RequestData {
  String key;
  List<DetailRequestCode> detailRequestCode;

  RequestData({required this.key, required this.detailRequestCode});

  @override
  String toString() {
    return 'RequestData{key: $key, detailRequestCode: $detailRequestCode}';
  }
}
