
extension StringConversion on String {
  /// convert String with lower case to upper case word . Ex : contact_us => ContactUs
  String toCamelCaseFirstLetterForEachWord() {
    List<String> words = split('_');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      words[i] = word.substring(0, 1).toUpperCase() + word.substring(1);
    }
    return words.join();
  }

  /// lower the first letter in word . Ex : ContactUs => contactUs
  String lowerCaseFirstLetter() {
    return "${this[0].toLowerCase()}${substring(1)}";
  }

}

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
