import 'package:args/args.dart';

import 'get_command.dart';

class CommandServices {
  /// SetUp Commands to using ThunderCLI
  static startCommands(List<String> arguments) {
    final parser = ArgParser();
    parser.addFlag(
      'build-api-doc',
      abbr: 'b',
      help: 'Build API collection from code.',
      defaultsTo: false,
    );

    parser.addFlag(
      'help',
      abbr: 'h',
      help: 'Show help message.',
      defaultsTo: false,
    );
    final results = parser.parse(arguments);

    GetCommand.getCommand(results, parser);
  }
}
