import 'package:mason/mason.dart';

import 'utils.dart' as utils;

void run(HookContext context) {

  final progress = context.logger.progress("Creating splash screen...");
  utils.executeSync(
      context: context,
      executable: 'dart',
      parameters: ['run', 'flutter_native_splash:create'],
      verbose: context.vars['verbose']);

  progress.complete();
}
