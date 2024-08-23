import 'dart:io';

import '../core/model/request_data.dart';
import '../core/model/variable_model.dart';
import './read_folder_name.dart';
import './read_request_from_methods.dart';
import './read_variables_from_user.dart';

class BuildCollections {
  static void buildCollection() async {
    String folderPath = ReadFolderName.readFolderName();

    List<FileSystemEntity> allFilesInDir = ReadFolderName.listFiles(folderPath);
    List<RequestData> allRequestsData =
        await ReadRequestFromMethods.getAllRequestsFromDir(allFilesInDir);

    List<VariableModel> userVariables =
        ReadVariablesFromUser.readVariablesFromUser();
  }
}
