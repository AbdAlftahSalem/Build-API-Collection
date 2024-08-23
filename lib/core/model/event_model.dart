class EventModel {
  String listen;
  ScriptModel script;

  EventModel({required this.listen, required this.script});
}

class ScriptModel {
  String type;
  List<String> exec;

  ScriptModel({required this.type, required this.exec});

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'exec': this.exec,
    };
  }
}
