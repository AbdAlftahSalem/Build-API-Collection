import 'package:args/args.dart';

import '../../../features/build_api_collection/build_collections.dart';
import '../../../features/build_routes/build_routes.dart';

class GetCommand {
  static void getCommand(ArgResults results, ArgParser parser) async {
    if (results['help']) {
      _showHelpMessage(parser);
    } else if (results['build-api-doc']) {
      BuildApiCollection.buildApiCollection();
    } else if (results['build-routes']) {
      BuildRoutes.buildRoutes();
    } else {
      _showHelpMessage(parser);
    }
  }

  /// Show help message -> thunder_cli --h
  static void _showHelpMessage(ArgParser parser) {
    print('⚡ Welcome to Thunder API builder 🚀🚀\n');
    print('Usage: thunder_api [options]\n');
    print('Options:');
    print(parser.usage);
  }
}
