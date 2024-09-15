import '../../core/services/folder_and_file_service/folder_and_file_service.dart';
import './get_string_data_from_file.dart';
class BuildValidators {
  static Future<void> buildValidators() async {
    String content = await FolderAndFileService.readFile(
        r"C:\Users\hp\Desktop\note_model.js");

    GetDataFromString.getDataFromString(content);
  }
}
