import '../../core/model/folder_request_collection_Model.dart';
import '../../core/model/variable_model.dart';

class PrintRequestData {
  static void printRequestData(List<FolderRequestCollectionModel> allRequests,
      List<VariableModel> variables) {
    print("\n\n" + "*" * 30 + "⚡⚡ Variables Details ⚡⚡" + "*" * 30 + "\n\n");
    variables.forEach((element) {
      print("Key   : ${element.key}");
      print("Value : ${element.value}\n");
    });

    print("\n\n" + "*" * 30 + "⚡⚡ Requests Details ⚡⚡" + "*" * 30 + "\n\n");
    allRequests.forEach((folderRequest) {
      print("\n⚡ '${folderRequest.folderName}' requests : ");
      folderRequest.detailApiRequest.forEach((detailApiRequest) {
        String message =
            "   ✅ ${detailApiRequest.requestName} || Method : ${detailApiRequest.requestModel.method} || ";
        message += "Route : ${detailApiRequest.requestModel.urlModel.raw}";
        print(message);
      });
    });
    print("\n\n⚡ FINISH BUILD API COLLECTION SUCCESSFULLY ...");
    print("👑 Build by : Abd Alftah Al-Shanti 👑");
  }
}
