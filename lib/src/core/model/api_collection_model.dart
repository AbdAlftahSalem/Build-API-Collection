import './event_model.dart';
import './folder_request_collection_model.dart';
import './info_model.dart';
import './variable_model.dart';

/// A whole Postman (v2.1) collection.
class ApiCollectionModel {
  /// Collection name and base URL.
  InfoModel infoCollection;

  /// Collection-level scripts.
  List<EventModel> events;

  /// Collection variables (`base_url` first).
  List<VariableModel> variables;

  /// One folder of requests per controller file.
  List<FolderRequestCollectionModel> requestCollectionModel;

  /// Creates a collection.
  ApiCollectionModel({
    required this.infoCollection,
    this.events = const [],
    this.variables = const [],
    this.requestCollectionModel = const [],
  });

  /// The collection as Postman v2.1 JSON (`info`, `item`, `event`,
  /// `variable`).
  Map<String, dynamic> toMap() {
    return {
      'info': infoCollection.toMap(),
      'item': requestCollectionModel.map((e) => e.toMap()).toList(),
      'event': events.map((e) => e.toMap()).toList(),
      'variable': variables.map((e) => e.toMap()).toList(),
    };
  }
}
