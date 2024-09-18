import './event_model.dart';
import './folder_request_collection_Model.dart';
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
      'info': this.infoCollection.toMap(),
      'item': this.requestCollectionModel.map((e) => e.toMap()).toList(),
      'events': this.events.map((e) => e.toMap()).toList(),
      'variables': this.variables.map((e) => e.toMap()).toList(),
    };
  }
}
