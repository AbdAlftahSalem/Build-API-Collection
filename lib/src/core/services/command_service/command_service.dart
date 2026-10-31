import 'dart:io';

import 'package:args/args.dart';

import 'get_command.dart';

/// Entry point of the `thunder_api` command.
class CommandServices {
  /// Set up commands for ThunderAPI
  static Future<void> startCommands(List<String> arguments) async {
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

    final ArgResults results;
    try {
      results = parser.parse(arguments);
    } on FormatException catch (e) {
      print("😢 ${e.message}\n");
      print('Usage: thunder_api [options]\n');
      print(parser.usage);
      exitCode = 64;
      return;
    }

    await GetCommand.getCommand(results, parser);
  }
}
