import './event_model.dart';
import './info_model.dart';
import './variable_model.dart';

class ApiCollectionModel {
  InfoModel infoCollection;
  List<EventModel> events;
  List<VariableModel> variables;

  ApiCollectionModel({
    required this.infoCollection,
    required this.events,
    required this.variables,
  });
}
