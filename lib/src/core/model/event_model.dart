/// A collection script (Postman event).
class EventModel {
  /// When it runs: `prerequest` or `test`.
  String listen;

  /// The script.
  ScriptModel script;

  /// Creates an event.
  EventModel({required this.listen, required this.script});

  Map<String, dynamic> toMap() {
    return {
      'listen': listen,
      'script': script.toMap(),
    };
  }
}

/// Script source of an [EventModel].
class ScriptModel {
  /// Script type, e.g. `text/javascript`.
  String type;

  /// Script lines.
  List<String> exec;

  /// Creates a script.
  ScriptModel({required this.type, required this.exec});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'exec': exec,
    };
  }
}
