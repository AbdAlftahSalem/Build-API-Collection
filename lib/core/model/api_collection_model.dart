import './event_model.dart';
import './folder_request_collection_model.dart';
import './info_model.dart';
import './variable_model.dart';

class ApiCollectionModel {
  InfoModel infoCollection;
  List<EventModel> events;
  List<VariableModel> variables;
  List<FolderRequestCollectionModel> requestCollectionModel;

  ApiCollectionModel({
    required this.infoCollection,
    this.events = const [],
    this.variables = const [],
    this.requestCollectionModel = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'info': infoCollection.toMap(),
      'item': requestCollectionModel.map((e) => e.toMap()).toList(),
      'events': events.map((e) => e.toMap()).toList(),
      'variables': variables.map((e) => e.toMap()).toList(),
    };
  }
}
