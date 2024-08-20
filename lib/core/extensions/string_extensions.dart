extension StringConversion on String {
  String removeFirstSpaces() {
    List<String> splitString = this.split("");
    bool flag = true;
    int i = 0;
    while(flag){
      if (splitString[i].isEmpty){
        splitString.remove(splitString[i]);
      }else{
        flag = false;
      }
      ++i;
    }
    return splitString.join().trim();
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
