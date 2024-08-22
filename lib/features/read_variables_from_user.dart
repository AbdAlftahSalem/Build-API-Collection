import 'dart:io';

import '../core/extensions/string_extensions.dart';
import '../core/model/variable_model.dart';

class ReadVariablesFromUser {
  static readVariablesFromUser() {
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
      String key = "";
      String value = "";
      bool addMoreVariables = true;
      String addMoreVariablesChoice = "";
      while (addMoreVariables ||
          addMoreVariablesChoice.isEmpty ||
          addMoreVariablesChoice.toLowerCase() == "y") {
        while (key.isEmpty) {
          stdout.write("Enter the key of variable : ");
          key = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Key cannot be empty !!");
        }
        while (value.isEmpty) {
          stdout.write("Enter the value of variable : ");
          value = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Value cannot be empty !!");
        }
        variables.add(VariableModel(key: key, value: value));
        stdout.write(
            "$key variable add successfully . Do you want add more ? [ y / N ] : ");
        addMoreVariablesChoice = (stdin.readLineSync() ?? "")
            .trim()
            .checkIfEmptyAndNullAndShowMessage("😢 Choice cannot be empty !!");
        if (addMoreVariablesChoice.toLowerCase() == "n") {
          addMoreVariables = false;
          addMoreVariablesChoice = "n";
        }
      }
    }
    print(variables.toString());
  }
}
