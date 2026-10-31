import './detail_request_code.dart';

/// The annotated requests read from one controller file.
class RequestData {
  /// Folder name in the collection (the file name without `_controller`).
  String key;

  /// The requests found in the file.
  List<DetailRequestCode> detailRequestCode;

  /// Path of the controller file the requests were read from.
  String filePath;

  /// Creates the requests read from one controller file.
  RequestData({
    required this.key,
    required this.detailRequestCode,
    this.filePath = "",
  });

  @override
  String toString() {
    return 'Request Data {key: $key, detailRequestCode: $detailRequestCode}';
  }
}
