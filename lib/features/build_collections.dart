import 'dart:io';
import '../core/extensions/string_extensions.dart';

class BuildCollections {
  static void buildCollection() {
    String folderPath = "";
    while(folderPath.isEmpty){
      stdout.write("Enter your controller folder path : ");
       folderPath = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage(
          "😢 Folder name cannot be empty !!");

    }


  }
}
