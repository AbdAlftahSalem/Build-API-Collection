/// Thunder API: build a Postman collection, web API docs and Express routes
/// from the `// @desc`, `// @route`, ... comments above your controller
/// methods.
///
/// Most people use the command line tool:
///
/// ```bash
/// dart pub global activate thunder_api
/// thunder_api --build-api-doc
/// thunder_api --build-routes
/// ```
library;

export 'src/core/services/command_service/command_service.dart';
export 'src/features/build_api_collection/build_collections.dart';
export 'src/features/build_routes/build_routes.dart';
export 'src/core/extensions/string_extensions.dart';
export 'src/core/utils/read_controllers_path.dart';
export 'src/core/utils/read_request_from_methods.dart';
export 'src/core/utils/requests_adapter.dart';
export 'src/core/model/api_collection_model.dart';
export 'src/core/model/detail_request_code.dart';
export 'src/core/model/event_model.dart';
export 'src/core/model/folder_request_collection_model.dart';
export 'src/core/model/info_model.dart';
export 'src/core/model/request_data.dart';
export 'src/core/model/variable_model.dart';
