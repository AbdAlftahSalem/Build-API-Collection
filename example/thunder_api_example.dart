import 'dart:convert';

import 'package:thunder_api/thunder_api.dart';

/// Builds a Postman collection from the sample controllers in
/// `example/controllers` without the interactive prompts, and prints it.
///
/// From the command line, the same thing is:
///
/// ```bash
/// thunder_api --build-api-doc   # Postman collection + web docs
/// thunder_api --build-routes    # Express route files
/// ```
Future<void> main() async {
  List<RequestData> requests =
      await ReadRequestFromMethods.getAllRequestsFromDir('example/controllers');

  ApiCollectionModel collection = ApiCollectionModel(
    infoCollection: InfoModel(
      collectionName: "Shop API",
      baseUrl: "http://localhost:3000",
    ),
    variables: [
      VariableModel(key: "base_url", value: "http://localhost:3000"),
      VariableModel(key: "token", value: "paste-a-token-here"),
    ],
    requestCollectionModel: RequestsAdapter.requestsAdapter(requests),
  );

  print(const JsonEncoder.withIndent('  ').convert(collection.toMap()));
}
