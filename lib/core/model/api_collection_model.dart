import './event_model.dart';
import './info_model.dart';
import './request_collection_model.dart';
import './variable_model.dart';

class ApiCollectionModel {
  InfoModel? infoCollection;
  List<EventModel>? events;
  List<VariableModel>? variables;
  List<FolderRequestCollectionModel>? requestCollectionModel;

  ApiCollectionModel({
    this.infoCollection,
    this.events,
    this.variables,
    this.requestCollectionModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'info': this.infoCollection,
      'item': this.requestCollectionModel,
      'events': this.events,
      'variables': this.variables,
    };
  }
}
