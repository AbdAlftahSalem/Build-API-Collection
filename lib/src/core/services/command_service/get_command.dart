import 'package:args/args.dart';

import '../../../features/build_api_collection/build_collections.dart';
import '../../../features/build_routes/build_routes.dart';

/// Dispatches the parsed command line to the right command.
class GetCommand {
  /// Runs the command selected in [results].
  static Future<void> getCommand(ArgResults results, ArgParser parser) async {
    if (results['help']) {
      _showHelpMessage(parser);
    } else if (results['build-api-doc']) {
      await BuildApiCollection.buildApiCollection();
    } else if (results['build-routes']) {
      await BuildRoutes.buildRoutes();
    } else {
      _showHelpMessage(parser);
    }
  }

  /// Show help message -> thunder_api --help
  static void _showHelpMessage(ArgParser parser) {
    print('⚡ Welcome to Thunder API builder 🚀🚀\n');
    print('Usage: thunder_api [options]\n');
    print('Options:');
    print(parser.usage);
  }
}
