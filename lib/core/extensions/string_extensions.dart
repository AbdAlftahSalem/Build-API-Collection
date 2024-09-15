extension ValidateInputData on String? {
  /// check if String? is empty and null then return empty string . else return the same string
  String checkIfEmptyAndNullAndShowMessage(message) {
    if ((this ?? "").isEmpty || this == null) {
      print("$message\n");
      return "";
    }
    return this ?? "";
  }
}

extension GetDataFromList on String {
  List<String> getDataFromList() {
    List<String> values = split(":");
    String message = "";
    String number = "";
    String value = values.last;
    value = value.replaceAll("[", "").replaceAll("],", "").replaceAll("]", "");
    values = value.split(",");
    number = values.first;
    message = values.last;
    return [number.trim(), message.replaceAll("`", "").trim()];
  }
}
