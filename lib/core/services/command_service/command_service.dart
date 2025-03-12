import 'package:args/args.dart';

import 'get_command.dart';

class CommandServices {
  /// Set up commands for ThunderAPI
  static void startCommands(List<String> arguments) {
    final parser = ArgParser()
      ..addFlag(
        'build-api-doc',
        abbr: 'b',
        help: 'Build API collection from code.',
        defaultsTo: false,
      )
      ..addFlag(
        'build-routes',
        abbr: 'r',
        help: 'Automatically generate routes from controllers.',
        defaultsTo: false,
      )
      ..addFlag(
        'help',
        abbr: 'h',
        help: 'Show help message.',
        defaultsTo: false,
      );

    final results = parser.parse(arguments);

    GetCommand.getCommand(results, parser);
  }
}
