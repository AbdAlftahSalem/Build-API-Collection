import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/variable_model.dart';

class ReadVariablesFromUser {
  static List<VariableModel> readVariablesFromUser() {
    List<VariableModel> variables = [];
    String choice = "";
    while (choice.isEmpty) {
      stdout.write("Do you want to add variables in collection ? [ y / N ] : ");
      choice = (stdin.readLineSync() ?? "")
          .trim()
          .checkIfEmptyAndNullAndShowMessage("😢 Choice cannot be empty !!");
      if (choice.toLowerCase() != "y" && choice.toLowerCase() != "n") {
        choice = '';
      }
    }

    if (choice.toLowerCase() == "y") {
      VariableModel variableModel = VariableModel(key: "", value: "");
      bool addMoreVariables = true;
      String addMoreVariablesChoice = "";
      while (addMoreVariables ||
          addMoreVariablesChoice.isEmpty ||
          addMoreVariablesChoice.toLowerCase() == "y") {
        while (variableModel.key.isEmpty) {
          stdout.write("Enter the key of variable : ");
          variableModel.key = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Key cannot be empty !!");
        }
        while (variableModel.value.isEmpty) {
          stdout.write("Enter the value of variable : ");
          variableModel.value = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Value cannot be empty !!");
        }
        variables.add(variableModel);
        stdout.write("✅ ${variableModel.key} variable add successfully ...");
        addMoreVariables = true;
        while (addMoreVariables) {
          stdout.write("\n\nDo you want add more ? [ y / N ] : ");
          addMoreVariablesChoice = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage(
                  "😢 Choice cannot be empty !!");
          if (addMoreVariablesChoice.toLowerCase() == "y") {
            variableModel.key = "";
            variableModel.value = "";
            addMoreVariables = false;
          } else if (addMoreVariablesChoice.toLowerCase() == "n") {
            addMoreVariables = false;
          }
        }
      }
    }
    return variables;
  }
}
