/// A collection variable, used in requests as `{{key}}`.
class VariableModel {
  /// Variable name.
  String key;

  /// Variable value.
  dynamic value;

  /// Creates a variable.
  VariableModel({this.key = "", this.value = ""});

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
