class EventModel {
  String listen;
  ScriptModel script;

  EventModel({required this.listen, required this.script});

  Map<String, dynamic> toMap() {
    return {
      'listen': listen,
      'script': script,
    };
  }
}

class ScriptModel {
  String type;
  List<String> exec;

  ScriptModel({required this.type, required this.exec});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'exec': exec,
    };
  }
}
