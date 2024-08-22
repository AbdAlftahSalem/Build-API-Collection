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
