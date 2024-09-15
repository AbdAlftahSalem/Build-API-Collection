class ModelDataModel {
  String filedName;
  List<DataModel> dataModel;

  ModelDataModel({
    required this.filedName,
    required this.dataModel,
  });
}

class DataModel {
  String type,
      requiredMessage,
      minLengthMessage,
      maxLengthMessage,
      uniqueMessage;
  int minLength, maxLength;

  bool unique, required;

  DataModel({
    this.type = '',
    this.required = false,
    this.requiredMessage = "",
    this.minLengthMessage = "",
    this.maxLengthMessage = "",
    this.uniqueMessage = "",
    this.minLength = 0,
    this.maxLength = 0,
    this.unique = false,
  });

  @override
  String toString() {
    return 'DataModel {type: $type, requiredMessage: $requiredMessage, minLengthMessage: $minLengthMessage, maxLengthMessage: $maxLengthMessage, uniqueMessage: $uniqueMessage, minLength: $minLength, maxLength: $maxLength, unique: $unique, required: $required}';
  }
}
