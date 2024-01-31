import 'dart:io';

import 'package:mason/mason.dart';

ProcessResult executeSync({
  required HookContext context,
  required String executable,
  required List<String> parameters,
  required bool verbose,
}) {
  context.logger.info("$executable ${parameters.join(" ")}");

  final ProcessResult result = Process.runSync(executable, parameters, runInShell: true);

  if (result.exitCode != 0) {
    context.logger.err(result.stderr);
  } else if (verbose) {
    context.logger.info(result.stdout);
  }

  return result;
}
