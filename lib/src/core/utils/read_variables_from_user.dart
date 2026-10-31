import 'dart:io';

import '../../core/extensions/string_extensions.dart';
import '../../core/model/variable_model.dart';

/// Asks for the collection variables.
class ReadVariablesFromUser {
  /// read variable form user , [ baseUrl ] it will added automatically in list
  static List<VariableModel> readVariablesFromUser(String baseUrl) {
    List<VariableModel> variables = [];
    String choice = "";
    variables.add(VariableModel(key: "base_url", value: baseUrl));
    // ask if user want to add variables
    while (choice.isEmpty) {
      stdout.write("Do you want to add variables in collection ? [ y / N ] : ");
      choice = (stdin.readLineSync() ?? "").trim();
      // Enter alone means the default answer: N
      if (choice.isEmpty) choice = "n";
      if (choice.toLowerCase() != "y" && choice.toLowerCase() != "n") {
        choice = '';
      }
    }

    if (choice.toLowerCase() == "y") {
      VariableModel? variableModel;
      bool addMoreVariables = true;
      String addMoreVariablesChoice = "";

      // add variables
      while (addMoreVariables ||
          addMoreVariablesChoice.isEmpty ||
          addMoreVariablesChoice.toLowerCase() == "y") {
        variableModel = VariableModel();

        // ask key
        while (variableModel.key.isEmpty) {
          stdout.write("Enter the key of variable : ");
          variableModel.key = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Key cannot be empty !!");
        }

        // ask value
        while (variableModel.value.isEmpty) {
          stdout.write("Enter the value of variable : ");
          variableModel.value = (stdin.readLineSync() ?? "")
              .trim()
              .checkIfEmptyAndNullAndShowMessage("😢 Value cannot be empty !!");
        }

        stdout.write("✅ ${variableModel.key} variable add successfully ...");
        addMoreVariables = true;
        variables.add(variableModel);

        // ask to add more variables
        while (addMoreVariables) {
          stdout.write("\n\nDo you want add more ? [ y / N ] : ");
          addMoreVariablesChoice = (stdin.readLineSync() ?? "").trim();
          // Enter alone means the default answer: N
          if (addMoreVariablesChoice.isEmpty) addMoreVariablesChoice = "n";
          if (addMoreVariablesChoice.toLowerCase() == "y") {
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
