import '../core/model/request_collection_model.dart';

class PrintRequestData {
  static void printRequestData(List<FolderRequestCollectionModel> allRequests) {
    allRequests.forEach((folderRequest) {
      print("⚡ '${folderRequest.folderName}' requests : ");
      folderRequest.detailApiRequest.forEach((detailApiRequest) {
        String message =
            "  ✅ ${detailApiRequest.requestName} || Method : ${detailApiRequest.requestModel.method} || ";
        message += "Route : ${detailApiRequest.requestModel.urlModel.raw}";
        print(message);
      });
      print("\n");
    });
  }
}
