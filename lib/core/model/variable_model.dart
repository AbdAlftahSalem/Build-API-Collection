class VariableModel {
  String key;
  dynamic value;

  VariableModel({required this.key, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'value': this.value,
    };
  }

  @override
  String toString() {
    return 'Variable {key: $key, value: $value}';
  }
}
