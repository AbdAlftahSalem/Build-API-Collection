import '../../core/services/folder_and_file_service/folder_and_file_service.dart';

class BuildValidators {
  static Future<void> buildValidators() async {
    String content = await FolderAndFileService.readFile(
        r"C:\Users\hp\Desktop\note_model.js");

    List<String> contentList = content.split("\n");
    bool addFlag = false;
    String title = "";

    for (int i = 0; i < contentList.length - 1; ++i) {
      String value = contentList[i];
      value = value.trim();

      if (value.contains("timestamps")) break;

      bool printFlag = addFlag && !title.endsWith("{") && !title.endsWith("},")&& !title.endsWith("}");
      printFlag = printFlag && !value.endsWith("{") && !value.endsWith("},") && !value.endsWith("}");

      if (printFlag) {
        print("$title || $value");
      }

      // search in dict flag true
      if (value.endsWith("{")) {
        addFlag = true;
        title = value.split(":").first;
      }

      if (value.endsWith("}") || value.endsWith("},")) {
        addFlag = false;
      }

      if (value.endsWith("[") && contentList[i + 1].trim().startsWith("{")) {
        title = contentList[i].trim().split(":").first;
        addFlag = true;
        i ++;
      }

    }
  }
}
