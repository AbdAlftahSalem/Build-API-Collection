class VariableModel {
  String key;
  dynamic value;

  VariableModel({this.key = "",  this.value = ""});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'Variable {key: $key, value: $value}';
  }
}
