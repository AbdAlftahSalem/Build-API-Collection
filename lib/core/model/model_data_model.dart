class ModelDataModel {
  String fieldName,
      type,
      requiredMessage,
      minLengthMessage,
      maxLengthMessage,
      uniqueMessage;
  int minLength, maxLength;

  bool unique, required;

  ModelDataModel({
    required this.fieldName,
    required this.type,
    this.required = false,
    this.requiredMessage = "",
    this.minLengthMessage = "",
    this.maxLengthMessage = "",
    this.uniqueMessage = "",
    this.minLength = 0,
    this.maxLength = 0,
    this.unique = false,
  });
}
